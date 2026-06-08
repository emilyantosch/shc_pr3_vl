# Todo List App

Simple todo list app with a Spring Boot backend, React frontend, and PostgreSQL database.

## Prerequisites

- Java 17+
- Maven, or use the included backend Maven wrapper
- Node.js/npm
- PostgreSQL 18 running on `localhost:5432`

## Database setup

Create the database with SQL through `psql`:

```bash
psql -h localhost -p 5432 -U "emilylucia.antosch" -d postgres -c "CREATE DATABASE todo_app;"
```

If the database already exists, you can skip this step.

The backend is configured for:

- Database: `todo_app`
- Username: `emilylucia.antosch`
- Password: blank

## Run the backend

```bash
cd backend
./mvnw spring-boot:run
```

If you already have Maven installed, `mvn spring-boot:run` also works.

The backend runs at `http://localhost:8080` and exposes:

- `GET /api/todos`
- `POST /api/todos`
- `PUT /api/todos/{id}`
- `DELETE /api/todos/{id}`

## Run the frontend

In a second terminal:

```bash
cd frontend
npm install
npm run dev
```

Open `http://localhost:5173`.

## Todo shape

```json
{
  "id": 1,
  "description": "Buy groceries",
  "done": false
}
```
