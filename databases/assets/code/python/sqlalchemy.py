from sqlalchemy import (
    Integer,
    Column,
    Numeric,
    String,
    Boolean,
    create_engine,
    Table,
    MetaData,
)
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.schema import CreateTable


Base = declarative_base()


class Department(Base):
    __tablename__ = "department"
    id = Column(Integer, primary_key=True)
    dept_name = Column("dept_name", String(64))
    dept_num = Column("dept_num", Integer)


class Employee(Base):
    __tablename__ = "employee"
    id = Column(Integer, primary_key=True)
    first_name = Column("first_name", String(32))
    last_name = Column("last_name", String(32))
    employed = Column("employed", Boolean)
    salary = Column("salary", Numeric)
    department = relationship(Department)

    # CREATE TABLE employee (
    # ...
    #     first_name VARCHAR(32)
    # ...
    # FOREIGN_KEY "..." (department) REFERENCES department(department_id)
    # )


def main():
    engine = create_engine(
        "postgresql://postgres:postgres@localhost:5431/databases_python"
    )
    try:
        Base.metadata.create_all(engine)
        print("Tables created successfully")
    except Exception as e:
        print("Exception occurred during table creation: {}", e)

    Session = sessionmaker(bind=engine)

    it_dept = Department(id=100, dept_name="IT", dept_num=1)
    rachel_emp = Employee(
        id=100,
        first_name="Rachel",
        last_name="Smith",
        employed=True,
        salary=1000.0,
        department=100,
    )

    with Session() as session:
        session.add(it_dept)
        session.add(rachel_emp)
        session.commit()


if __name__ == "__main__":
    main()
