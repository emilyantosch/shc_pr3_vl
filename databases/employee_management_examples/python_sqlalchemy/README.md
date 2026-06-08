# Python + SQLAlchemy Employee Management

Shows SQLAlchemy ORM mappings on top of existing PostgreSQL tables.

## Setup

```bash
cd databases/employee_management_examples/python_sqlalchemy
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
```

## Create database (built-in example)

```bash
python create_database.py
```

Then connect to `employee_management` and run:

1. `../sql/01_schema.sql`
2. `../sql/02_seed.sql`

## Run

```bash
python app.py
python app.py department 5
python app.py give-raise 5 1000
```

`give-raise` commits salary changes. Re-run `../sql/02_seed.sql` to reset sample data.
