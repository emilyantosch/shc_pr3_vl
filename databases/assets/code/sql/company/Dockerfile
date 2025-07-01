FROM postgres:17

WORKDIR /usr/local/pg

COPY employee.csv .
COPY department.csv .
COPY dependent.csv .
COPY works_on.csv .
COPY projects.csv .
COPY dept_locations.csv .


ENV POSTGRES_PASSWORD=postgres
ARG name=databases


