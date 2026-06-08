use anyhow::{bail, Context, Result};
use sea_orm::{
    ActiveModelTrait, ColumnTrait, Database, DatabaseConnection, EntityTrait, QueryFilter,
    QueryOrder, Set, TransactionTrait,
};
use std::env;

mod entities;

use entities::{department, dependent, dept_location, employee, project, work_assignment};

const DEFAULT_DATABASE_URL: &str =
    "postgres://emilylucia.antosch:@localhost:5432/employee_management";

#[tokio::main]
async fn main() -> Result<()> {
    dotenvy::dotenv().ok();

    let database_url =
        env::var("DATABASE_URL").unwrap_or_else(|_| DEFAULT_DATABASE_URL.to_string());
    let db = Database::connect(&database_url)
        .await
        .context("connect to PostgreSQL")?;

    let args: Vec<String> = env::args().skip(1).collect();
    match args.as_slice() {
        [] => {
            print_department_summary(&db).await?;
            print_project_workload(&db).await?;
            print_direct_reports(&db).await?;
        }
        [command, dnumber] if command == "department" => {
            let dnumber = dnumber
                .parse::<i32>()
                .context("department number must be integer")?;
            print_department_employees(&db, dnumber).await?;
        }
        [command, dnumber, amount] if command == "give-raise" => {
            let dnumber = dnumber
                .parse::<i32>()
                .context("department number must be integer")?;
            let amount = amount
                .parse::<i32>()
                .context("raise amount must be integer")?;
            give_raise(&db, dnumber, amount).await?;
        }
        _ => bail!("usage: cargo run -- [department <dnumber> | give-raise <dnumber> <amount>]"),
    }

    Ok(())
}

async fn print_department_summary(db: &DatabaseConnection) -> Result<()> {
    println!("\nDepartments");

    let departments = department::Entity::find()
        .order_by_asc(department::Column::Dnumber)
        .all(db)
        .await?;

    for department in departments {
        let employees = employee::Entity::find()
            .filter(employee::Column::Dno.eq(department.dnumber))
            .all(db)
            .await?;

        let manager = match &department.mgr_ssn {
            Some(ssn) => employee::Entity::find_by_id(ssn.to_owned()).one(db).await?,
            None => None,
        };
        let manager_name = manager
            .map(|employee| format!("{} {}", employee.fname, employee.lname))
            .unwrap_or_else(|| "none".to_string());
        let locations = dept_location::Entity::find()
            .filter(dept_location::Column::Dnumber.eq(department.dnumber))
            .order_by_asc(dept_location::Column::Dlocation)
            .all(db)
            .await?
            .into_iter()
            .map(|location| location.dlocation)
            .collect::<Vec<_>>()
            .join(", ");

        println!(
            "{:>2} {:<15} manager={:<18} employees={} locations={}",
            department.dnumber,
            department.dname,
            manager_name,
            employees.len(),
            locations
        );
    }

    Ok(())
}

async fn print_project_workload(db: &DatabaseConnection) -> Result<()> {
    println!("\nProject workload");

    let projects = project::Entity::find()
        .order_by_asc(project::Column::Pnumber)
        .all(db)
        .await?;

    for project in projects {
        let assignments = work_assignment::Entity::find()
            .filter(work_assignment::Column::Pno.eq(project.pnumber))
            .all(db)
            .await?;
        let total_hours: f64 = assignments
            .iter()
            .map(|assignment| assignment.hours.unwrap_or(0.0))
            .sum();

        println!("{:<16} {:>5.1} h/week", project.pname, total_hours);
    }

    Ok(())
}

async fn print_direct_reports(db: &DatabaseConnection) -> Result<()> {
    println!("\nDirect reports of Franklin Wong");

    let supervisor = employee::Entity::find()
        .filter(employee::Column::Fname.eq("Franklin"))
        .filter(employee::Column::Lname.eq("Wong"))
        .one(db)
        .await?;

    let Some(supervisor) = supervisor else {
        println!("Supervisor not found");
        return Ok(());
    };

    let reports = employee::Entity::find()
        .filter(employee::Column::SuperSsn.eq(Some(supervisor.ssn)))
        .order_by_asc(employee::Column::Lname)
        .order_by_asc(employee::Column::Fname)
        .all(db)
        .await?;

    for employee in reports {
        println!(
            "{} {} salary={}",
            employee.fname, employee.lname, employee.salary
        );
    }

    Ok(())
}

async fn print_department_employees(db: &DatabaseConnection, dnumber: i32) -> Result<()> {
    println!("\nEmployees in department {dnumber}");

    let employees = employee::Entity::find()
        .filter(employee::Column::Dno.eq(dnumber))
        .order_by_asc(employee::Column::Lname)
        .order_by_asc(employee::Column::Fname)
        .all(db)
        .await?;

    if employees.is_empty() {
        println!("No employees found");
        return Ok(());
    }

    for employee in employees {
        let supervisor = match &employee.super_ssn {
            Some(ssn) => employee::Entity::find_by_id(ssn.to_owned()).one(db).await?,
            None => None,
        };
        let supervisor_name = supervisor
            .map(|supervisor| format!("{} {}", supervisor.fname, supervisor.lname))
            .unwrap_or_else(|| "none".to_string());

        let dependent_count = dependent::Entity::find()
            .filter(dependent::Column::Essn.eq(employee.ssn.clone()))
            .all(db)
            .await?
            .len();

        println!(
            "{} {} {} salary={} supervisor={} dependents={}",
            employee.ssn.trim_end(),
            employee.fname,
            employee.lname,
            employee.salary,
            supervisor_name,
            dependent_count
        );
    }

    Ok(())
}

async fn give_raise(db: &DatabaseConnection, dnumber: i32, amount: i32) -> Result<()> {
    let transaction = db.begin().await?;

    let employees = employee::Entity::find()
        .filter(employee::Column::Dno.eq(dnumber))
        .order_by_asc(employee::Column::Lname)
        .order_by_asc(employee::Column::Fname)
        .all(&transaction)
        .await?;

    for employee in &employees {
        let mut active: employee::ActiveModel = employee.clone().into();
        active.salary = Set(employee.salary + amount);
        active.update(&transaction).await?;
    }

    transaction.commit().await?;

    println!("Updated {} employees", employees.len());
    for employee in employees {
        println!(
            "{} {} {} new_salary={}",
            employee.ssn.trim_end(),
            employee.fname,
            employee.lname,
            employee.salary + amount
        );
    }

    Ok(())
}
