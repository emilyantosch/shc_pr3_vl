use anyhow::{bail, Context, Result};
use sqlx::{postgres::PgPoolOptions, FromRow, PgPool};
use std::env;

const DEFAULT_DATABASE_URL: &str =
    "postgres://emilylucia.:postgres@localhost:5432/employee_management";

#[derive(Debug, FromRow)]
struct DepartmentSummary {
    dnumber: i32,
    dname: String,
    manager: Option<String>,
    employee_count: i64,
}

#[derive(Debug, FromRow)]
struct ProjectWorkload {
    pname: String,
    total_hours: f64,
}

#[derive(Debug, FromRow)]
struct EmployeeRow {
    ssn: String,
    fname: String,
    lname: String,
    salary: i32,
    supervisor: Option<String>,
}

#[derive(Debug, FromRow)]
struct UpdatedEmployee {
    ssn: String,
    fname: String,
    lname: String,
    salary: i32,
}

#[tokio::main]
async fn main() -> Result<()> {
    dotenvy::dotenv().ok();

    let database_url =
        env::var("DATABASE_URL").unwrap_or_else(|_| DEFAULT_DATABASE_URL.to_string());
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .context("connect to PostgreSQL")?;

    let args: Vec<String> = env::args().skip(1).collect();
    match args.as_slice() {
        [] => {
            print_department_summary(&pool).await?;
            print_project_workload(&pool).await?;
            print_direct_reports(&pool).await?;
        }
        [command, dnumber] if command == "department" => {
            let dnumber = dnumber
                .parse::<i32>()
                .context("department number must be integer")?;
            print_department_employees(&pool, dnumber).await?;
        }
        [command, dnumber, amount] if command == "give-raise" => {
            let dnumber = dnumber
                .parse::<i32>()
                .context("department number must be integer")?;
            let amount = amount
                .parse::<i32>()
                .context("raise amount must be integer")?;
            give_raise(&pool, dnumber, amount).await?;
        }
        _ => bail!("usage: cargo run -- [department <dnumber> | give-raise <dnumber> <amount>]"),
    }

    Ok(())
}

async fn print_department_summary(pool: &PgPool) -> Result<()> {
    println!("\nDepartments");

    let departments = sqlx::query_as::<_, DepartmentSummary>(
        r#"
        SELECT
            d.dnumber,
            d.dname,
            manager.fname || ' ' || manager.lname AS manager,
            COUNT(e.ssn)::BIGINT AS employee_count
        FROM department AS d
        LEFT JOIN employee AS manager ON manager.ssn = d.mgr_ssn
        LEFT JOIN employee AS e ON e.dno = d.dnumber
        GROUP BY d.dnumber, d.dname, manager.fname, manager.lname
        ORDER BY d.dnumber
        "#,
    )
    .fetch_all(pool)
    .await?;

    for department in departments {
        println!(
            "{:>2} {:<15} manager={:<18} employees={}",
            department.dnumber,
            department.dname,
            department.manager.unwrap_or_else(|| "none".to_string()),
            department.employee_count
        );
    }

    Ok(())
}

async fn print_project_workload(pool: &PgPool) -> Result<()> {
    println!("\nProject workload");

    let projects = sqlx::query_as::<_, ProjectWorkload>(
        r#"
        SELECT
            p.pname,
            COALESCE(SUM(wo.hours), 0)::DOUBLE PRECISION AS total_hours
        FROM project AS p
        LEFT JOIN works_on AS wo ON wo.pno = p.pnumber
        GROUP BY p.pnumber, p.pname
        ORDER BY p.pnumber
        "#,
    )
    .fetch_all(pool)
    .await?;

    for project in projects {
        println!("{:<16} {:>5.1} h/week", project.pname, project.total_hours);
    }

    Ok(())
}

async fn print_direct_reports(pool: &PgPool) -> Result<()> {
    println!("\nDirect reports of Franklin Wong");

    let reports = sqlx::query_as::<_, EmployeeRow>(
        r#"
        SELECT
            e.ssn,
            e.fname,
            e.lname,
            e.salary,
            supervisor.fname || ' ' || supervisor.lname AS supervisor
        FROM employee AS e
        JOIN employee AS supervisor ON supervisor.ssn = e.super_ssn
        WHERE supervisor.fname = $1
          AND supervisor.lname = $2
        ORDER BY e.lname, e.fname
        "#,
    )
    .bind("Franklin")
    .bind("Wong")
    .fetch_all(pool)
    .await?;

    for employee in reports {
        println!(
            "{} {} salary={}",
            employee.fname, employee.lname, employee.salary
        );
    }

    Ok(())
}

async fn print_department_employees(pool: &PgPool, dnumber: i32) -> Result<()> {
    println!("\nEmployees in department {dnumber}");

    let employees = sqlx::query_as::<_, EmployeeRow>(
        r#"
        SELECT
            e.ssn,
            e.fname,
            e.lname,
            e.salary,
            supervisor.fname || ' ' || supervisor.lname AS supervisor
        FROM employee AS e
        LEFT JOIN employee AS supervisor ON supervisor.ssn = e.super_ssn
        WHERE e.dno = $1
        ORDER BY e.lname, e.fname
        "#,
    )
    .bind(dnumber)
    .fetch_all(pool)
    .await?;

    if employees.is_empty() {
        println!("No employees found");
        return Ok(());
    }

    for employee in employees {
        println!(
            "{} {} {} salary={} supervisor={}",
            employee.ssn.trim_end(),
            employee.fname,
            employee.lname,
            employee.salary,
            employee.supervisor.unwrap_or_else(|| "none".to_string())
        );
    }

    Ok(())
}

async fn give_raise(pool: &PgPool, dnumber: i32, amount: i32) -> Result<()> {
    let mut transaction = pool.begin().await?;

    let updated = sqlx::query_as::<_, UpdatedEmployee>(
        r#"
        UPDATE employee
        SET salary = salary + $1
        WHERE dno = $2
        RETURNING ssn, fname, lname, salary
        "#,
    )
    .bind(amount)
    .bind(dnumber)
    .fetch_all(&mut *transaction)
    .await?;

    transaction.commit().await?;

    println!("Updated {} employees", updated.len());
    for employee in updated {
        println!(
            "{} {} {} new_salary={}",
            employee.ssn.trim_end(),
            employee.fname,
            employee.lname,
            employee.salary
        );
    }

    Ok(())
}
