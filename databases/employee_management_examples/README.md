# Employee Management Database Examples

Three small application examples for PostgreSQL:

- `python_sqlalchemy` — Python + SQLAlchemy ORM
- `rust_sqlx` — Rust + SQLx with explicit SQL queries
- `rust_seaorm` — Rust + SeaORM ORM

All examples use this connection by default:

```text
postgres://postgres:postgres@localhost:5432/employee_management
```

## 1. Start PostgreSQL

Use local PostgreSQL or from `databases/`:

```bash
docker compose up -d db
```

## 2. Create database

Option A, with SQLAlchemy example:

```bash
cd databases/employee_management_examples/python_sqlalchemy
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python create_database.py
```

Option B, manually in pgAdmin/psql while connected to database `postgres`:

```sql
CREATE DATABASE employee_management;
```

## 3. Create tables and insert data

Connect to database `employee_management`, then run:

1. `sql/01_schema.sql`
2. `sql/02_seed.sql`

psql variant:

```bash
psql -h localhost -p 5432 -U postgres -d employee_management -f sql/01_schema.sql
psql -h localhost -p 5432 -U postgres -d employee_management -f sql/02_seed.sql
```

Optional teaching queries: `sql/03_example_queries.sql`.

## Schema theme

Recurring COMPANY / employee-management example:

- `employee`
- `department`
- `dept_locations`
- `project`
- `works_on`
- `dependent`

Foreign keys cover department membership, department managers, employee supervision, project ownership, project assignments, and dependents.

## Publication note

Code is original teaching scaffolding. Schema/data follow recurring course example. Before publishing publicly, check rights for exact sample data copied from slides/textbook examples.
