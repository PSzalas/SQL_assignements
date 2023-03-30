-- Rozdzia³ 7:

  -- Zadanie 1:
    SELECT last_name, TO_CHAR(hire_date, 'DD-MON-YY') hire_date
    FROM employees
    WHERE last_name IN
    (SELECT e.last_name FROM employees e JOIN employees el
      ON (e.department_id = el.department_id)
      WHERE el.last_name = INITCAP('&last_name')
      AND el.last_name <> e.last_name);

  -- Zadanie 2:
    SELECT employee_id, last_name, salary
    FROM employees
    WHERE salary > (SELECT AVG(salary) FROM employees)
    ORDER BY salary ASC;

  -- Zadanie 3:
    SELECT employee_id, last_name
    FROM employees
    WHERE department_id IN
    (SELECT department_id FROM employees WHERE last_name LIKE '%u%');

  -- Zadanie 4:
    SELECT last_name, department_id, job_id
    FROM employees
    WHERE department_id IN
    (SELECT department_id FROM departments
      JOIN locations USING (location_id)
      WHERE location_id = 1700)
      ORDER BY department_id;

    SELECT last_name, department_id, job_id
    FROM employees
    WHERE department_id IN
    (SELECT department_id FROM departments
      JOIN locations USING (location_id)
      WHERE location_id = &location_id)
      ORDER BY department_id;

  -- Zadanie 5:
    SELECT last_name, salary
    FROM employees
    WHERE manager_id =
    (SELECT employee_id FROM employees WHERE last_name = 'King')

  -- Zadanie 6:
    SELECT department_id, last_name, job_id
    FROM employees
    WHERE department_id IN
    (SELECT department_id FROM departments WHERE department_name = 'Executive');

  -- Zadanie 7:
    SELECT employee_id, last_name, salary
    FROM employees
    WHERE department_id IN
    (SELECT department_id FROM employees WHERE last_name LIKE '%u%')
    AND salary > (SELECT AVG(salary) FROM employees);

-- Rozdzia³ 8:

  -- Zadanie 1:
    SELECT department_id
    FROM departments
    MINUS
    SELECT department_id
    FROM employees
    WHERE job_id = 'ST_CLERK';

  -- Zadanie 2:
    SELECT country_id, country_name
    FROM countries
    MINUS
    SELECT l.country_id, c.country_name
    FROM locations l JOIN countries c ON (l.country_id = c.country_id)
    WHERE l.location_id IN (SELECT d.location_id FROM departments d);

  -- Zadanie 3:
    SELECT DISTINCT job_id, department_id
    FROM employees
    WHERE department_id = 10
    UNION ALL
    SELECT DISTINCT job_id, department_id
    FROM employees
    WHERE department_id = 50
    UNION ALL
    SELECT DISTINCT job_id, department_id
    FROM employees
    WHERE department_id = 20;

  -- Zadanie 4:
    SELECT employee_id, job_id
    FROM employees
    INTERSECT
    SELECT j.employee_id, j.job_id
    FROM job_history j JOIN employees e ON (j.start_date = e.hire_date);

  -- Zadanie 5:
    SELECT last_name, department_id, TO_CHAR(NULL)
    FROM employees
    UNION ALL
    SELECT TO_CHAR(NULL), department_id, department_name
    FROM departments;

-- Rozdzia³ 9:

  -- Zadanie 1:
    CREATE TABLE MY_EMPLOYEE (
      id number(4) NOT NULL,
      last_name varchar2(25),
      first_name varchar2(25),
      userId varchar2(8),
      salary number(9,2));

    -- Zadanie 2:
      DESCRIBE my_employee;

    -- Zadanie 3:
      INSERT INTO my_employee
      VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);

    -- Zadanie 4:
      INSERT INTO my_employee (id, last_name, first_name, userId, salary)
      VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);

    -- Zadanie 5:
      SELECT * FROM my_employee;

    -- Zadanie 6:
      INSERT INTO my_employee
      VALUES (&enter_id, '&enter_last_name', '&enter_first_name', '&enter_userId', &enter_salary);

    -- Zadanie 7:
      -- 3x odpaliæ to co wy¿ej

    -- Zadanie 8:
      SELECT * FROM my_employee;

    -- Zadanie 9:
      COMMIT;

    -- Zadanie 10:
      UPDATE my_employee
      SET last_name = 'Drexler'
      WHERE id = 3;

    -- Zadanie 11:
      UPDATE my_employee
      SET salary = 1000
      WHERE salary < 900;

    -- Zadanie 12:
      SELECT * FROM my_employee;

    -- Zadanie 13:
      DELETE FROM my_employee
      WHERE last_name = 'Dancs';

    -- Zadanie 14:
      SELECT * FROM my_employee;

    -- Zadanie 15:
      COMMIT;

    -- Zadanie 16:
      INSERT INTO my_employee
      VALUES (&enter_id, '&enter_last_name', '&enter_first_name', '&enter_userId', &enter_salary);

    -- Zadanie 17:
      SELECT * FROM my_employee;

    -- Zadanie 18:
      SAVEPOINT save_1;

    -- Zadanie 19:
      DELETE FROM my_employee;

    -- Zadanie 20:
      SELECT * FROM my_employee;

    -- Zadanie 21:
      ROLLBACK TO save_1;

    -- Zadanie 22:
      SELECT * FROM my_employee;

    -- Zadanie 23:
      COMMIT;

    -- Zadanie 24, 25:
      INSERT INTO my_employee (id, last_name, first_name, salary)
      VALUES (&enter_id, '&enter_last_name', '&enter_first_name', &enter_salary);
      UPDATE my_employee
      SET userid = (
        SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 7)))
        FROM my_employee WHERE userid IS NULL)
      WHERE userid IS NULL;

    -- Zadanie 26:
      SELECT * FROM my_employee WHERE userid = 'manthony';
