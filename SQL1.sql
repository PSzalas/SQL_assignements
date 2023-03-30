-- Rozdzia³ 2:

  -- Zadanie 3:
    SELECT last_name, salary
    FROM employees
    WHERE salary NOT BETWEEN 5000 AND 12000;

  -- Zadanie 4:
    SELECT last_name, job_ID, hire_date
    FROM employees
    WHERE last_name IN ('Matos', 'Taylor')
    ORDER BY hire_date ASC;

  -- Zadanie 5:
    SELECT last_name, department_ID
    FROM employees
    WHERE department_id IN (20, 50)
    ORDER BY last_name ASC;

  -- Zadanie 6:
    SELECT last_name "Employee", salary "Monthly Salary"
    FROM employees
    WHERE salary BETWEEN 5000 AND 12000
    AND department_ID IN (20, 50);

  -- Zadanie 7:
    SELECT last_name, hire_date
    FROM employees
    WHERE hire_date LIKE '94%';

  -- Zadanie 8:
    SELECT last_name, job_ID
    FROM employees
    WHERE manager_ID IS NULL;

  -- Zadanie 9:
    SELECT last_name, salary, commission_pct
    FROM employees
    WHERE commission_pct IS NOT NULL
    ORDER BY 2 DESC, 3 DESC;

  -- Zadanie 10:
    SELECT last_name, salary
    FROM employees
    WHERE salary > &salary;

  -- Zadanie 11:
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE manager_id = &manager_id
    ORDER BY &selected_column;

  -- Zadanie 12:
    SELECT last_name
    FROM employees
    WHERE last_name LIKE '__a%';

  -- Zadanie 13:
    SELECT last_name
    FROM employees
    WHERE last_name LIKE '%a%e%'
    OR last_name LIKE '%e%a%';

  -- Zadanie 14:
    SELECT last_name, job_id, salary
    FROM employees
    WHERE job_id IN ('SA_REP', 'ST_CLERK')
    AND salary NOT IN (2500, 3500, 7000);

  -- Zadanie 15:
    SELECT last_name "Employee", salary "Monthly Salary", commission_pct
    FROM employees
    WHERE commission_pct = 0.2;



-- Rozdzia³ 3:

  -- Zadanie 1:
    SELECT DISTINCT sysdate "Date"
    FROM countries;

  -- Zadanie 2:
    SELECT employee_id, last_name, salary, ROUND(salary+(salary*0.155), 0) "New Salary"
    FROM employees;

  -- Zadanie 3:
    -- Identyczne jak poprzednie
    SELECT employee_id, last_name, salary,
            ROUND(salary+(salary*0.155), 0) "New Salary"
    FROM employees;

  -- Zadanie 4:
    SELECT employee_id, last_name, salary,
            ROUND(salary+(salary*0.155), 0) "New Salary",
            ROUND(salary+(salary*0.155), 0)-salary "Increase"
    FROM employees;

  -- Zadanie 5:
    SELECT last_name "Name", LENGTH(last_name) "Length"
    FROM employees
    WHERE INITCAP(last_name) LIKE 'J%'
      OR INITCAP(last_name) LIKE 'A%'
      OR INITCAP(last_name) LIKE 'M%'
    ORDER BY last_name;
    -- 1 modyfikacja:
    SELECT last_name "Name", LENGTH(last_name) "Length"
    FROM employees
    WHERE INITCAP(last_name) LIKE '&first_letter%'
    ORDER BY last_name;
    -- 2 modyfikacja
    SELECT last_name "Name", LENGTH(last_name) "Length"
    FROM employees
    WHERE INITCAP(last_name) LIKE UPPER('&first_letter%')
    ORDER BY last_name;

  -- Zadanie 6:
    SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE,hire_date), 0) "MONTHS_WORKED"
    FROM employees
    ORDER BY 2;

  -- Zadanie 7:
    SELECT last_name, LPAD(salary, 15, '$') "SALARY"
    FROM employees;

  -- Zadanie 8:
    SELECT CONCAT(SUBSTR(last_name, 1, 8) || '  ', RPAD(' ',ROUND(salary/1000, 0),'*')) "EMPOLYEES_AND_THEIR_SALARIES"
    FROM employees
    ORDER BY salary DESC;

  -- Zadanie 9:
    SELECT last_name, TRUNC(((SYSDATE - hire_date)/7), 0) "TENURE"
    FROM employees
    WHERE department_id = 90
    ORDER BY 2 DESC;
