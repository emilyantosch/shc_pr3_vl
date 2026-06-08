"""Create the demo database from Python via SQLAlchemy.

Run this while PostgreSQL is reachable on localhost:5432 with user/password
postgres/postgres. It connects to maintenance database "postgres" and creates
"employee_management" if missing.
"""

from __future__ import annotations

import os
import re

from dotenv import load_dotenv
from sqlalchemy import create_engine, text

load_dotenv()

ADMIN_DATABASE_URL = os.getenv(
    "ADMIN_DATABASE_URL",
    "postgresql+psycopg://emilylucia.antosch:@localhost:5432/postgres",
)
APP_DATABASE_NAME = os.getenv("APP_DATABASE_NAME", "employee_management")


def quote_identifier(identifier: str) -> str:
    if not re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", identifier):
        raise ValueError(f"Unsafe database name: {identifier!r}")
    return f'"{identifier}"'


def main() -> None:
    engine = create_engine(ADMIN_DATABASE_URL, isolation_level="AUTOCOMMIT")

    with engine.connect() as connection:
        exists = connection.execute(
            text("SELECT 1 FROM pg_database WHERE datname = :database_name"),
            {"database_name": APP_DATABASE_NAME},
        ).scalar_one_or_none()

        if exists:
            print(f"Database already exists: {APP_DATABASE_NAME}")
            return

        connection.execute(
            text(f"CREATE DATABASE {quote_identifier(APP_DATABASE_NAME)}")
        )
        print(f"Created database: {APP_DATABASE_NAME}")


if __name__ == "__main__":
    main()
