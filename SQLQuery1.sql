DROP TABLE IF EXISTS employee_projects;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
 
CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location        VARCHAR(50)
);
 
CREATE TABLE employees (
    employee_id     INT PRIMARY KEY,
    employee_name   VARCHAR(80) NOT NULL,
    department_id   INT REFERENCES departments(department_id),
    salary          NUMERIC(10,2),
    hire_date       DATE,
    manager_id      INT REFERENCES employees(employee_id)
);
 
CREATE TABLE projects (
    project_id      INT PRIMARY KEY,
    project_name    VARCHAR(80) NOT NULL,
    department_id   INT REFERENCES departments(department_id),
    budget          NUMERIC(12,2),
    status          VARCHAR(20)
);
 
CREATE TABLE employee_projects (
    employee_id     INT REFERENCES employees(employee_id),
    project_id      INT REFERENCES projects(project_id),
    hours_worked    INT DEFAULT 0,
    PRIMARY KEY (employee_id, project_id)
);
 
INSERT INTO departments VALUES
    (1, 'Engineering',     'Lahore'),
    (2, 'Analytics',       'Islamabad'),
    (3, 'Human Resources', 'Lahore'),
    (4, 'Marketing',       'Karachi'),
    (5, 'Finance',         'Islamabad');
 
INSERT INTO employees VALUES
    (101, 'Ayesha',  1,    95000, '2023-02-10', NULL),
    (102, 'Bilal',   1,    72000, '2024-06-15', 101),
    (103, 'Hira',    2,    88000, '2022-09-01', NULL),
    (104, 'Usman',   2,    61000, '2025-01-20', 103),
    (105, 'Noor',    3,    54000, '2024-03-12', NULL),
    (106, 'Hamza',   1,    68000, '2025-07-07', 101),
    (107, 'Zara',    4,    59000, '2023-11-25', NULL),
    (108, 'Daniyal', 4,    64000, '2022-05-30', 107),
    (109, 'Maham',   NULL, 50000, '2025-04-18', NULL),
    (110, 'Saad',    2,    NULL,  '2024-12-02', 103),
    (111, 'Iqra',    5,    78000, '2021-08-09', NULL),
    (112, 'Farhan',  1,    72000, '2023-07-14', 101);
 
INSERT INTO projects VALUES
    (201, 'Customer Data Platform',  1, 450000, 'Active'),
    (202, 'Sales Dashboard',         2, 180000, 'Active'),
    (203, 'Recruitment Tracker',     3,  90000, 'Completed'),
    (204, 'Campaign Analytics',      4, 125000, 'Active'),
    (205, 'Budget Forecasting',      5, 210000, 'Planned'),
    (206, 'Data Quality Initiative', 2, 150000, 'Completed');
 
INSERT INTO employee_projects VALUES
    (101, 201, 35), (102, 201, 28), (106, 201, 22),
    (103, 202, 40), (104, 202, 18), (110, 206, 12),
    (105, 203, 25), (107, 204, 30), (108, 204, 26),
    (111, 205, 20), (112, 201, 16);
GO
 SELECT * FROM employees;
 
SELECT employee_name, salary FROM employees;

SELECT DISTINCT employee_name, hire_date FROM employees;

SELECT employee_id, employee_name, salary
FROM employees
WHERE salary > 70000;

SELECT employee_id, employee_name, hire_date
FROM employees
WHERE hire_date >= '2024-01-01';
 
SELECT employee_id, employee_name, salary
FROM employees
WHERE salary BETWEEN 60000 AND 80000;
 
SELECT employee_id, employee_name
FROM employees
WHERE department_id IS NULL;
 
SELECT employee_id, employee_name, salary
FROM employees
WHERE salary IS NOT NULL;
 
SELECT employee_name
FROM employees
WHERE employee_name LIKE 'A%';
 
SELECT employee_name
FROM employees
WHERE employee_name LIKE '%a%';
 
SELECT employee_id, employee_name, department_id
FROM employees
WHERE department_id IN (1, 2);
 
SELECT employee_name, salary
FROM employees
ORDER BY salary DESC;
 
SELECT TOP 5 employee_name, hire_date
FROM employees
ORDER BY hire_date DESC;
 
SELECT employee_name AS name,
       salary        AS monthly_salary
FROM employees;

SELECT employee_name, salary, department_id
FROM employees
WHERE salary >= 60000
  AND department_id = 1;
 
SELECT employee_name, salary, department_id
FROM employees
WHERE department_id = 1
   OR salary < 60000;
 
SELECT employee_name, salary
FROM employees
WHERE salary IS NOT NULL
  AND salary < 70000;
 
SELECT employee_name, hire_date
FROM employees
WHERE hire_date >= '2023-01-01'
  AND hire_date <  '2025-01-01';
 
SELECT employee_name
FROM employees
WHERE employee_name LIKE '%a';
 
SELECT employee_name, department_id
FROM employees
WHERE department_id <> 1
   OR department_id IS NULL;

SELECT employee_name, manager_id
FROM employees
WHERE manager_id IS NOT NULL;
 
SELECT employee_name
FROM employees
WHERE manager_id IS NULL;
 
SELECT employee_name,
       salary,
       CASE
           WHEN salary IS NULL    THEN 'Unknown'
           WHEN salary >= 80000   THEN 'High'
           WHEN salary >= 60000   THEN 'Medium'
           ELSE 'Entry'
       END AS salary_band
FROM employees;
 
SELECT employee_name,
       COALESCE(salary, 0) AS salary_display
FROM employees;
 
SELECT COUNT(*) AS total_employees FROM employees;
 
SELECT COUNT(salary) AS employees_with_salary FROM employees;
 
SELECT MIN(salary)           AS min_salary,
       MAX(salary)           AS max_salary,
       CAST(AVG(salary) AS DECIMAL(12,2)) AS avg_salary
FROM employees;
 
SELECT SUM(salary) AS total_salary FROM employees;
 
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY department_id;
 
SELECT department_id, CAST(AVG(salary) AS DECIMAL(12,2)) AS avg_salary
FROM employees
GROUP BY department_id
ORDER BY department_id;
 
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 3;
 
SELECT YEAR(hire_date) AS hire_year,
       COUNT(*)                          AS employees_hired
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;
 
SELECT COUNT(*) AS earning_above_70k
FROM employees
WHERE salary > 70000;
 
SELECT e.employee_name, d.department_name
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id;
 
SELECT e.employee_name,
       COALESCE(d.department_name, 'No department') AS department_name
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id;
 
SELECT d.department_name, e.employee_name
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
ORDER BY d.department_id, e.employee_name;
 
SELECT e.employee_name, p.project_name, ep.hours_worked
FROM employee_projects ep
JOIN employees e ON e.employee_id = ep.employee_id
JOIN projects  p ON p.project_id  = ep.project_id
ORDER BY p.project_name, e.employee_name;
 
SELECT e.employee_id, e.employee_name
FROM employees e
LEFT JOIN employee_projects ep ON ep.employee_id = e.employee_id
WHERE ep.employee_id IS NULL;
 
SELECT p.project_name, SUM(ep.hours_worked) AS total_hours
FROM projects p
JOIN employee_projects ep ON ep.project_id = p.project_id
GROUP BY p.project_id, p.project_name
ORDER BY total_hours DESC;
 
SELECT e.employee_name AS employee,
       COALESCE(m.employee_name, 'No manager') AS manager
FROM employees e
LEFT JOIN employees m ON m.employee_id = e.manager_id
ORDER BY e.employee_id;
 
SELECT d.department_name,
       CAST(AVG(e.salary) AS DECIMAL(12,2)) AS avg_salary
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;
 
SELECT d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

DROP TABLE IF EXISTS interns;
CREATE TABLE interns (
    intern_id    INT PRIMARY KEY,
    full_name    VARCHAR(80) NOT NULL,
    email        VARCHAR(120) UNIQUE,
    joining_date DATE
);
GO
 
INSERT INTO interns (intern_id, full_name, email, joining_date) VALUES
    (1, 'Ali Raza',   'ali.raza@example.com',   '2026-06-01'),
    (2, 'Sana Malik', 'sana.malik@example.com', '2026-06-15');
 
SELECT * FROM interns;
 
UPDATE interns
SET email = 'ali.raza.new@example.com'
WHERE intern_id = 1;
 
SELECT * FROM interns WHERE intern_id = 1;
 
SELECT * FROM interns WHERE intern_id = 2;
 
DELETE FROM interns WHERE intern_id = 2;
 
SELECT * FROM interns WHERE intern_id = 2;
 
ALTER TABLE interns ADD internship_track VARCHAR(50);
 
SELECT * FROM interns;
 
DROP TABLE IF EXISTS salary_test;
SELECT employee_id, employee_name, salary
INTO salary_test
FROM employees
WHERE employee_id IN (101, 102);
GO
 
SELECT * FROM salary_test ORDER BY employee_id;
 
BEGIN TRANSACTION;
UPDATE salary_test SET salary = salary + 5000 WHERE employee_id = 101;
SELECT * FROM salary_test ORDER BY employee_id;
ROLLBACK TRANSACTION;
 
SELECT * FROM salary_test ORDER BY employee_id;
 
DROP TABLE salary_test;

SELECT employee_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
 
SELECT employee_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);
 
SELECT employee_name
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name = 'Engineering'
);

SELECT project_name, budget
FROM projects
WHERE budget > (SELECT AVG(budget) FROM projects);
 
WITH avg_salary AS (
    SELECT AVG(salary) AS avg_sal FROM employees
)
SELECT e.employee_name, e.salary
FROM employees e
CROSS JOIN avg_salary a
WHERE e.salary > a.avg_sal;
 
WITH project_hours AS (
    SELECT project_id, SUM(hours_worked) AS total_hours
    FROM employee_projects
    GROUP BY project_id
)
SELECT p.project_name, ph.total_hours
FROM project_hours ph
JOIN projects p ON p.project_id = ph.project_id
WHERE ph.total_hours > 30
ORDER BY ph.total_hours DESC;
 
WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_sal
    FROM employees
    WHERE department_id IS NOT NULL
      AND salary IS NOT NULL
    GROUP BY department_id
)
SELECT e.employee_name, e.department_id, e.salary,
       CAST(d.avg_sal AS DECIMAL(12,2)) AS dept_avg_salary
FROM employees e
JOIN dept_avg d ON d.department_id = e.department_id
WHERE e.salary > d.avg_sal
ORDER BY e.department_id, e.salary DESC;
 
SELECT employee_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
 
SELECT department_id, employee_name, salary,
       ROW_NUMBER() OVER (
           PARTITION BY department_id
           ORDER BY salary DESC, employee_id
       ) AS row_num
FROM employees
ORDER BY department_id, row_num;
 
SELECT employee_name, department_id, salary,
       CAST(AVG(salary) OVER (PARTITION BY department_id) AS DECIMAL(12,2))
           AS dept_avg_salary
FROM employees
ORDER BY department_id, employee_name;
 
SELECT employee_name, hire_date, salary,
       LAG(salary) OVER (ORDER BY hire_date, employee_id) AS previous_salary
FROM employees
ORDER BY hire_date, employee_id;
 
SELECT department_id, employee_name, salary,
       SUM(salary) OVER (
           PARTITION BY department_id
           ORDER BY salary
       ) AS running_total
FROM employees
ORDER BY department_id, salary, employee_id;
SELECT TOP 3 e.employee_name, e.salary,
       COALESCE(d.department_name, 'No department') AS department_name
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
ORDER BY e.salary DESC;
SELECT COALESCE(d.department_name, 'No department') AS department_name,
       SUM(e.salary) AS known_salary_cost
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY known_salary_cost DESC;

SELECT status, COUNT(*) AS project_count
FROM projects
GROUP BY status
ORDER BY project_count DESC;

SELECT project_name, budget
FROM projects
WHERE budget = (SELECT MAX(budget) FROM projects);
 
SELECT employee_id, employee_name
FROM employees
WHERE department_id IS NULL;
 
SELECT employee_id, employee_name
FROM employees
WHERE salary IS NULL;
 
SELECT e.employee_id, e.employee_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM employee_projects ep
    WHERE ep.employee_id = e.employee_id
);

SELECT e.employee_id, e.employee_name
FROM employees e
WHERE e.manager_id IS NULL
  AND NOT EXISTS (
      SELECT 1 FROM employees r WHERE r.manager_id = e.employee_id
  );
 
SELECT p.project_id, p.project_name
FROM projects p
LEFT JOIN employee_projects ep ON ep.project_id = p.project_id
WHERE ep.project_id IS NULL;
 
SELECT employee_id, employee_name, hire_date
FROM employees
WHERE hire_date > CAST(GETDATE() AS DATE);
 
SELECT d.department_name,
       COUNT(e.employee_id)    AS employee_count,
       CAST(AVG(e.salary) AS DECIMAL(12,2)) AS avg_salary
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;
 
SELECT p.project_name,
       COALESCE(SUM(ep.hours_worked), 0) AS total_hours
FROM projects p
LEFT JOIN employee_projects ep ON ep.project_id = p.project_id
GROUP BY p.project_id, p.project_name
ORDER BY total_hours DESC;
 
SELECT e.employee_name, SUM(ep.hours_worked) AS total_hours
FROM employee_projects ep
JOIN employees e ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.employee_name
ORDER BY total_hours DESC;
 
SELECT d.department_name, SUM(p.budget) AS active_budget
FROM projects p
JOIN departments d ON d.department_id = p.department_id
WHERE p.status = 'Active'
GROUP BY d.department_id, d.department_name
ORDER BY active_budget DESC;
 
SELECT p.project_name,
       p.budget,
       SUM(ep.hours_worked) AS total_hours,
       CAST(p.budget / NULLIF(SUM(ep.hours_worked), 0) AS DECIMAL(12,2))
           AS budget_per_hour
FROM projects p
JOIN employee_projects ep ON ep.project_id = p.project_id
GROUP BY p.project_id, p.project_name, p.budget
ORDER BY budget_per_hour DESC;
 
WITH emp_stats AS (
    SELECT department_id,
           COUNT(*)                AS employee_count,
           CAST(AVG(salary) AS DECIMAL(12,2))   AS avg_salary
    FROM employees
    WHERE department_id IS NOT NULL
    GROUP BY department_id
),
proj_stats AS (
    SELECT department_id,
           SUM(budget) AS total_project_budget
    FROM projects
    GROUP BY department_id
)
SELECT d.department_name,
       COALESCE(es.employee_count, 0) AS employee_count,
       es.avg_salary,
       COALESCE(ps.total_project_budget, 0)  AS total_project_budget
FROM departments d
LEFT JOIN emp_stats  es ON es.department_id = d.department_id
LEFT JOIN proj_stats ps ON ps.department_id = d.department_id
ORDER BY d.department_id;
 