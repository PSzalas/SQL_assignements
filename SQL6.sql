-- Fundamentals II Rozdzia³ 6:

  -- Zadanie 1:
    SELECT last_name, department_id, salary FROM employees
    WHERE (department_id, salary) IN
    (SELECT e.department_id, e.salary FROM employees e
    WHERE e.commission_pct IS NOT NULL)
    ORDER BY salary;

  -- Zadanie 2:
    SELECT e.last_name, d.department_name, e.salary
    FROM employees e JOIN departments d ON e.department_id = d.department_id
    WHERE (NVL(e.commission_pct, 0), e.salary) IN
    (SELECT NVL(el.commission_pct, 0), el.salary FROM employees el JOIN departments dp
    ON el.department_id = dp.department_id WHERE el.department_id IN
    (SELECT dp2.department_id FROM departments dp2 WHERE dp2.location_id = 1700));

  -- Zadanie 3:
    SELECT e.last_name, e.hire_date, e.salary FROM employees e
    WHERE (NVL(e.commission_pct, 0), e.salary) IN
    (SELECT NVL(el.commission_pct, 0), el.salary FROM employees el
    WHERE last_name LIKE 'Kochhar')
    AND e.last_name NOT LIKE 'Kochhar';

  -- Zadanie 4:
    SELECT e.last_name, e.job_id, e.salary FROM employees e
    WHERE e.salary >
    (SELECT MAX(el.salary) FROM employees el WHERE el.job_id LIKE 'SA_MAN')
    ORDER  BY e.salary DESC;

  -- Zadanie 5:
    SELECT e.employee_id, e.last_name, e.department_id FROM employees e
    WHERE e.department_id IN
    (SELECT d.department_id FROM departments d WHERE d.location_id IN
    (SELECT l.location_id FROM locations l WHERE l.city LIKE 'T%'));

  -- Zadanie 6:
    WITH dept_avg_salary AS (SELECT ROUND(AVG(el.salary),2) dept_avg, el.department_id  FROM employees el GROUP BY el.department_id)
    SELECT e.last_name ename, e.salary, e.department_id deptno, das.dept_avg
    FROM employees e JOIN dept_avg_salary das  ON e.department_id = das.department_id
    WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id)
    ORDER BY 4;

  -- Zadanie 7:
    -- a:
      SELECT e.last_name FROM employees e
      WHERE NOT EXISTS (SELECT 'X' FROM employees WHERE manager_id = e.employee_id);

    -- b:
      SELECT e.last_name FROM employees e
      WHERE e.employee_id NOT IN (SELECT NVL(manager_id, 0) FROM employees);

  -- Zadanie 8:
    SELECT e.last_name FROM employees e
    WHERE e.salary < (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

  -- Zadanie 9:
    WITH co_dept AS (SELECT hire_date, salary, department_id FROM employees)
    SELECT e.last_name FROM employees e JOIN co_dept c ON e.department_id = c.department_id
    WHERE NVL(e.department_id, 0) = NVL(c.department_id, 0)
    AND e.hire_date < c.hire_date AND e.salary < c.salary;

  -- Zadanie 10:
    -- Sposób 1:
      SELECT e.employee_id, e.last_name,
      (SELECT d.department_name FROM departments d WHERE e.department_id = d.department_id) department FROM employees e;

    -- Sposób 2:
      SELECT e.employee_id, e.last_name,
      (CASE WHEN e.department_id = (SELECT d.department_id FROM departments d
      WHERE e.department_id = d.department_id) THEN (SELECT dl.department_name FROM departments dl WHERE e.department_id = dl.department_id)
      ELSE 'Nieznany' END) department FROM employees e;

  -- Zadanie 11:
    WITH summary AS (SELECT SUM(salary) dept_total, department_id FROM employees GROUP BY department_id)
    SELECT d.department_name, s.dept_total FROM departments d JOIN summary s ON d.department_id = s.department_id
    WHERE s.dept_total > (SELECT SUM(salary)/8 FROM employees);

-- Fundamentals II Rozdzia³ 6 (dodatkowe):
  -- Zadanie 1:

    SELECT * FROM employees WHERE salary IN
    (SELECT MIN(salary) FROM employees GROUP BY department_id);

  -- Zadanie 2:

    WITH dept_min_salary AS
    (SELECT department_id, MIN(salary) AS min_salary FROM employees GROUP BY department_id)
    SELECT e.first_name, e.last_name, e.salary, d.min_salary, (e.salary-d.min_salary)
    FROM employees e JOIN dept_min_salary d
    ON e.department_id = d.department_id;

  -- Zadanie 3:

    SELECT e.last_name, d.department_name, e.salary FROM employees e JOIN departments d
    ON e.department_id = d.department_id
    WHERE (e.salary, NVL(e.commission_pct, 0)) IN
    (SELECT e1.salary, NVL(e1.commission_pct, 0) FROM employees e1 JOIN departments d1
    ON e1.department_id = d1.department_id JOIN locations l ON d1.location_id = l.location_id
    WHERE l.city = 'Seattle');
