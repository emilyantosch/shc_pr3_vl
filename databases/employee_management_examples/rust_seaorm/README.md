# Rust + SeaORM Employee Management

Shows Rust ORM-style entity structs with SeaORM.

Note: this project assumes “CRM” meant “ORM”. If you meant another Rust crate, replace this folder.

## Setup database

Create database, tables, and data from parent folder:

1. `../sql/00_create_database.sql` or Python creator in `../python_sqlalchemy`
2. `../sql/01_schema.sql`
3. `../sql/02_seed.sql`

## Run

```bash
cd databases/employee_management_examples/rust_seaorm
cp .env.example .env
cargo run
cargo run -- department 5
cargo run -- give-raise 5 1000
```

`give-raise` commits salary changes. Re-run `../sql/02_seed.sql` to reset sample data.
