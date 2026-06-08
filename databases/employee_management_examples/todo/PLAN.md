# Todo List App Plan

## Context
- Repo empty now.
- Goal: simple full-stack todo app.
- Backend: Java Spring Boot REST API.
- Frontend: React web page.
- Database: PostgreSQL 18 on `localhost:5432`, no password, new database.
- Todo item fields: `id`, `description`, `done`.
- User actions: add todo, delete todo, edit description, toggle done.

## Approach
- Create monorepo with `backend/` and `frontend/`.
- Backend Spring Boot app exposes REST API under `/api/todos` on port `8080`.
- Persist todos with Spring Data JPA + PostgreSQL driver.
- Configure backend for local PostgreSQL 18 database:
  - database: `todo_app`
  - host/port: `localhost:5432`
  - username: `emilylucia.antosch`
  - password: blank
- Use Maven for Spring Boot.
- Use Vite for React frontend on port `5173`.
- Use React app to call backend API with `fetch`.
- Keep UI minimal: text input, list, checkbox, edit/save, delete.
- Enable CORS for `http://localhost:5173` during development.

## Files to modify
- `backend/pom.xml`
- `backend/src/main/java/.../TodoApplication.java`
- `backend/src/main/java/.../todo/TodoItem.java`
- `backend/src/main/java/.../todo/TodoRepository.java`
- `backend/src/main/java/.../todo/TodoController.java`
- `backend/src/main/resources/application.properties`
- `frontend/package.json`
- `frontend/package-lock.json`
- `frontend/index.html`
- `frontend/vite.config.js`
- `frontend/src/main.jsx`
- `frontend/src/App.jsx`
- `frontend/src/App.css`
- `backend/mvnw`
- `backend/mvnw.cmd`
- `backend/.mvn/wrapper/maven-wrapper.properties`
- `.gitignore`
- `README.md`

## Reuse
- Existing code: none found; repo currently empty.
- Reuse standard Spring Boot starters: Web, Data JPA, PostgreSQL JDBC driver.
- Reuse Vite React template structure for frontend.

## Steps
- [x] Create Spring Boot backend project in `backend/`.
- [x] Add Todo JPA entity with `id`, `description`, `done`.
- [x] Add Spring Data repository.
- [x] Add REST controller endpoints:
  - `GET /api/todos` list todos
  - `POST /api/todos` create todo
  - `PUT /api/todos/{id}` update description/done
  - `DELETE /api/todos/{id}` delete todo
- [x] Add Postgres config in `application.properties`:
  - `spring.datasource.url=jdbc:postgresql://localhost:5432/todo_app`
  - `spring.datasource.username=emilylucia.antosch`
  - `spring.datasource.password=`
  - `spring.jpa.hibernate.ddl-auto=update`
- [x] Add local CORS config for React dev server.
- [x] Create Vite React app in `frontend/`.
- [x] Implement add, delete, edit, toggle done UI.
- [x] Add README setup commands, including database creation.
- [x] Add backend Maven wrapper so the backend can build even when system Maven is absent.

## Verification
- [x] Create local database via SQL through `psql`.
- [x] Build backend with `cd backend && ./mvnw test`.
- [x] Start backend and confirm it connects to Postgres.
- [x] Use API calls to confirm CRUD works.
- [x] Build frontend with `cd frontend && npm install && npm run build`.
- [x] Restart backend and confirm data persists.

## Decisions
- Database name: `todo_app`.
- PostgreSQL username: `emilylucia.antosch`.
- Backend: Maven + Spring Boot on port `8080`.
- Frontend: Vite React on port `5173`.
