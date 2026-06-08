from __future__ import annotations

import argparse
import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, func, select
from sqlalchemy.orm import Session, selectinload

from models import Department, Employee, Project, WorksOn

load_dotenv()

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql+psycopg://emilylucia.antosch:@localhost:5432/employee_management",
)


def list_department_summary(session: Session) -> None:
    print("\nDepartments")
    statement = (
        select(Department)
        .options(
            selectinload(Department.manager),
            selectinload(Department.employees),
            selectinload(Department.locations),
        )
        .order_by(Department.dnumber)
    )

    for department in session.scalars(statement):
        manager = department.manager.full_name if department.manager else "none"
        locations = ", ".join(location.dlocation for location in department.locations)
        print(
            f"{department.dnumber:>2} {department.dname:<15} "
            f"manager={manager:<18} employees={len(department.employees)} "
            f"locations={locations}"
        )


def list_project_workload(session: Session) -> None:
    print("\nProject workload")
    statement = (
        select(Project.pname, func.coalesce(func.sum(WorksOn.hours), 0.0))
        .outerjoin(WorksOn, WorksOn.pno == Project.pnumber)
        .group_by(Project.pnumber, Project.pname)
        .order_by(Project.pnumber)
    )

    for project_name, total_hours in session.execute(statement):
        print(f"{project_name:<16} {total_hours:>5.1f} h/week")


def list_direct_reports(session: Session) -> None:
    print("\nDirect reports of Franklin Wong")
    supervisor = session.scalar(
        select(Employee).where(Employee.fname == "Franklin", Employee.lname == "Wong")
    )
    if supervisor is None:
        print("Supervisor not found")
        return

    statement = (
        select(Employee)
        .where(Employee.super_ssn == supervisor.ssn)
        .order_by(Employee.lname, Employee.fname)
    )
    for employee in session.scalars(statement):
        print(f"{employee.full_name:<18} salary={employee.salary}")


def list_department_employees(session: Session, department_number: int) -> None:
    department = session.get(Department, department_number)
    if department is None:
        print(f"No department with dnumber={department_number}")
        return

    print(f"\nEmployees in {department.dname}")
    statement = (
        select(Employee)
        .where(Employee.dno == department_number)
        .order_by(Employee.lname, Employee.fname)
    )
    for employee in session.scalars(statement):
        supervisor = employee.supervisor.full_name if employee.supervisor else "none"
        print(
            f"{employee.ssn} {employee.full_name:<18} salary={employee.salary:<6} supervisor={supervisor}"
        )


def give_raise(session: Session, department_number: int, amount: int) -> None:
    with session.begin():
        employees = session.scalars(
            select(Employee)
            .where(Employee.dno == department_number)
            .order_by(Employee.lname, Employee.fname)
            .with_for_update()
        ).all()

        for employee in employees:
            employee.salary += amount

    print(
        f"Updated {len(employees)} employees in department {department_number} by {amount}"
    )


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Employee management demo using SQLAlchemy"
    )
    subcommands = parser.add_subparsers(dest="command")

    department = subcommands.add_parser(
        "department", help="list employees in one department"
    )
    department.add_argument("dnumber", type=int)

    raise_command = subcommands.add_parser(
        "give-raise", help="add fixed salary amount to department"
    )
    raise_command.add_argument("dnumber", type=int)
    raise_command.add_argument("amount", type=int)

    return parser


def main() -> None:
    args = build_parser().parse_args()
    engine = create_engine(DATABASE_URL)

    with Session(engine) as session:
        if args.command == "department":
            list_department_employees(session, args.dnumber)
        elif args.command == "give-raise":
            give_raise(session, args.dnumber, args.amount)
        else:
            list_department_summary(session)
            list_project_workload(session)
            list_direct_reports(session)


if __name__ == "__main__":
    main()
