# dataEm

A SQL database project for managing employees, departments, projects, and employee project assignments.

## Contents

- [SQLQuery1.sql](./SQLQuery1.sql) - database setup, sample data, and queries

## Database schema

The script defines four related tables:

- **departments** - department names and locations
- **employees** - employee details, salaries, hire dates, departments, and managers
- **projects** - projects associated with departments, including budgets and status
- **employee_projects** - many-to-many assignments between employees and projects

Foreign keys connect employees and projects to departments, managers to employees, and employee assignments to both employees and projects.

## Getting started

1. Open SQLQuery1.sql in a SQL database client that supports the SQL syntax used in the script.
2. Run the script to create or recreate the tables and load the included data.
3. Execute the example queries at the end of the script to explore the data.

> The script begins by dropping the project, employee, department, and assignment tables before recreating them. Run it only when resetting the database objects is acceptable.
