from __future__ import annotations

from datetime import date

from sqlalchemy import CheckConstraint, Date, Float, ForeignKey, Integer, String
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship as orm_relationship


class Base(DeclarativeBase):
    pass


class Department(Base):
    __tablename__ = "department"

    dnumber: Mapped[int] = mapped_column(Integer, primary_key=True)
    dname: Mapped[str] = mapped_column(String(30), nullable=False, unique=True)
    mgr_ssn: Mapped[str | None] = mapped_column(
        String(9),
        ForeignKey("employee.ssn", ondelete="SET NULL", onupdate="CASCADE"),
    )
    mgr_start_date: Mapped[date | None] = mapped_column(Date)

    manager: Mapped[Employee | None] = orm_relationship(
        "Employee",
        foreign_keys=[mgr_ssn],
        post_update=True,
    )
    employees: Mapped[list[Employee]] = orm_relationship(
        "Employee",
        back_populates="department",
        foreign_keys="Employee.dno",
    )
    locations: Mapped[list[DeptLocation]] = orm_relationship(
        "DeptLocation",
        back_populates="department",
        cascade="all, delete-orphan",
    )
    projects: Mapped[list[Project]] = orm_relationship(
        "Project",
        back_populates="department",
    )

    def __repr__(self) -> str:
        return f"Department(dnumber={self.dnumber!r}, dname={self.dname!r})"


class Employee(Base):
    __tablename__ = "employee"
    __table_args__ = (
        CheckConstraint("sex IN ('M', 'F') OR sex IS NULL", name="employee_sex_check"),
        CheckConstraint("salary >= 0", name="employee_salary_check"),
    )

    ssn: Mapped[str] = mapped_column(String(9), primary_key=True)
    fname: Mapped[str] = mapped_column(String(20), nullable=False)
    minit: Mapped[str | None] = mapped_column(String(1))
    lname: Mapped[str] = mapped_column(String(20), nullable=False)
    bdate: Mapped[date | None] = mapped_column(Date)
    address: Mapped[str | None] = mapped_column(String(80))
    sex: Mapped[str | None] = mapped_column(String(1))
    salary: Mapped[int] = mapped_column(Integer, nullable=False)
    super_ssn: Mapped[str | None] = mapped_column(
        String(9),
        ForeignKey("employee.ssn", ondelete="SET NULL", onupdate="CASCADE"),
    )
    dno: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("department.dnumber", ondelete="RESTRICT", onupdate="CASCADE"),
        nullable=False,
    )

    department: Mapped[Department] = orm_relationship(
        "Department",
        back_populates="employees",
        foreign_keys=[dno],
    )
    supervisor: Mapped[Employee | None] = orm_relationship(
        "Employee",
        remote_side=[ssn],
        back_populates="direct_reports",
        foreign_keys=[super_ssn],
    )
    direct_reports: Mapped[list[Employee]] = orm_relationship(
        "Employee",
        back_populates="supervisor",
        foreign_keys=[super_ssn],
    )
    work_assignments: Mapped[list[WorksOn]] = orm_relationship(
        "WorksOn",
        back_populates="employee",
        cascade="all, delete-orphan",
    )
    dependents: Mapped[list[Dependent]] = orm_relationship(
        "Dependent",
        back_populates="employee",
        cascade="all, delete-orphan",
    )

    @property
    def full_name(self) -> str:
        return f"{self.fname} {self.lname}"

    def __repr__(self) -> str:
        return f"Employee(ssn={self.ssn!r}, name={self.full_name!r})"


class DeptLocation(Base):
    __tablename__ = "dept_locations"

    dnumber: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("department.dnumber", ondelete="CASCADE", onupdate="CASCADE"),
        primary_key=True,
    )
    dlocation: Mapped[str] = mapped_column(String(30), primary_key=True)

    department: Mapped[Department] = orm_relationship("Department", back_populates="locations")


class Project(Base):
    __tablename__ = "project"

    pnumber: Mapped[int] = mapped_column(Integer, primary_key=True)
    pname: Mapped[str] = mapped_column(String(30), nullable=False, unique=True)
    plocation: Mapped[str | None] = mapped_column(String(30))
    dnum: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("department.dnumber", ondelete="RESTRICT", onupdate="CASCADE"),
        nullable=False,
    )

    department: Mapped[Department] = orm_relationship("Department", back_populates="projects")
    work_assignments: Mapped[list[WorksOn]] = orm_relationship(
        "WorksOn",
        back_populates="project",
        cascade="all, delete-orphan",
    )


class WorksOn(Base):
    __tablename__ = "works_on"
    __table_args__ = (
        CheckConstraint("hours IS NULL OR hours >= 0", name="works_on_hours_check"),
    )

    essn: Mapped[str] = mapped_column(
        String(9),
        ForeignKey("employee.ssn", ondelete="CASCADE", onupdate="CASCADE"),
        primary_key=True,
    )
    pno: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("project.pnumber", ondelete="CASCADE", onupdate="CASCADE"),
        primary_key=True,
    )
    hours: Mapped[float | None] = mapped_column(Float)

    employee: Mapped[Employee] = orm_relationship("Employee", back_populates="work_assignments")
    project: Mapped[Project] = orm_relationship("Project", back_populates="work_assignments")


class Dependent(Base):
    __tablename__ = "dependent"
    __table_args__ = (
        CheckConstraint("sex IN ('M', 'F') OR sex IS NULL", name="dependent_sex_check"),
    )

    essn: Mapped[str] = mapped_column(
        String(9),
        ForeignKey("employee.ssn", ondelete="CASCADE", onupdate="CASCADE"),
        primary_key=True,
    )
    dependent_name: Mapped[str] = mapped_column(String(30), primary_key=True)
    sex: Mapped[str | None] = mapped_column(String(1))
    bdate: Mapped[date | None] = mapped_column(Date)
    relationship: Mapped[str | None] = mapped_column(String(30))

    employee: Mapped[Employee] = orm_relationship("Employee", back_populates="dependents")
