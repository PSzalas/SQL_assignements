-- Rozdzia³ 4:

  -- Zadanie 1:
    SELECT last_name || ' earsn' || TO_CHAR(salary, '$99,999.99') || ' monthly but wants' || TO_CHAR(salary*3, '$99,999.99') AS "Dream Salaries"
    FROM employees;

  -- Zadanie 2:
    SELECT last_name, TO_CHAR(hire_date, 'DD-MON-YY ') hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 1), 'fmDay", the" Ddspth "of" Month", "YYYY') REVIEW
    FROM employees;

  -- Zadanie 3:
    --narzucenie edytowania formatu daty:
    SELECT last_name, TO_CHAR(hire_date, 'DD-MON-YY ') AS "hire_date", TO_CHAR(hire_date, 'DAY') DAY
    FROM employees
    ORDER BY TO_CHAR(hire_date, 'D') ASC;
    --bez narzucenia:
    SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') DAY
    FROM employees
    ORDER BY TO_CHAR(hire_date, 'D') ASC;

  -- Zadanie 4:
    SELECT last_name, NVL(TO_CHAR(commission_pct, '.99'), 'No Commission') COMM
    FROM employees;

  -- Zadanie 5:
    SELECT job_id,
      DECODE (job_id,
          'AD_PRES', 'A',
          'ST_MAN', 'B',
          'IT_PROG', 'C',
          'SA_REP', 'D',
          'ST_CLERK', 'E',
          0) GRADE
    FROM employees;

    -- Zadanie 6:
    SELECT job_id,
    CASE job_id
        WHEN 'AD_PRES' THEN 'A'
        WHEN 'ST_MAN' THEN 'B'
        WHEN 'IT_PROG' THEN 'C'
        WHEN 'SA_REP' THEN 'D'
        WHEN 'ST_CLERK' THEN 'E'
        ELSE '0' END GRADE
    FROM employees;

-- Rozdzia³ 5:

  -- Zadanie 1:
    -- TRUE

  -- Zadanie 2:
    -- FALSE

  -- Zadanie 3:
    -- TRUE

  -- Zadanie 4:
    SELECT ROUND(MAX(salary),0) AS "Maximum", ROUND(MIN(salary),0) AS "Minimum", ROUND(SUM(salary),0) AS "Sum", ROUND(AVG(salary),0) AS "Average"
    FROM employees;

  -- Zadanie 5:
    SELECT job_id, ROUND(MAX(salary),0) AS "Maximum", ROUND(MIN(salary),0) AS "Minimum", ROUND(SUM(salary),0) AS "Sum", ROUND(AVG(salary),0) AS "Average"
    FROM employees
    GROUP BY job_id;

  -- Zadanie 6:
    SELECT job_id, COUNT(*)
    FROM employees
    GROUP BY job_id;

    SELECT job_id, COUNT(*)
    FROM employees
    WHERE job_id = '&job_id'
    GROUP BY job_id;

  -- Zadanie 7:
    SELECT COUNT(DISTINCT manager_id) AS "Number of Managers"
    FROM employees;

  -- Zadanie 8:
    SELECT (MAX(salary)-MIN(salary)) DIFFERENCE
    FROM employees;

  -- Zadanie 9:
    SELECT manager_id, MIN(salary)
    FROM employees
    WHERE manager_id IS NOT NULL
    GROUP BY manager_id
    HAVING MIN(salary)>6000
    ORDER BY MIN(salary) DESC;

  -- Zadanie 10:
    SELECT COUNT(*) TOTAL,
    SUM(DECODE (TO_CHAR(hire_date, 'YYYY'), '1995', 1, 0)) "1995",
    SUM(DECODE (TO_CHAR(hire_date, 'YYYY'), '1996', 1, 0)) "1996",
    SUM(DECODE (TO_CHAR(hire_date, 'YYYY'), '1997', 1, 0)) "1997",
    SUM(DECODE (TO_CHAR(hire_date, 'YYYY'), '1998', 1, 0)) "1998"
    FROM employees
    GROUP BY 1;

  -- Zadanie 11:
    SELECT DISTINCT job_id AS "Job",
    SUM(DECODE (department_id, 20, salary)) AS "Dept 20",
    SUM(DECODE (department_id, 50, salary)) AS "Dept 50",
    SUM(DECODE (department_id, 80, salary)) AS "Dept 80",
    SUM(DECODE (department_id, 90, salary)) AS "Dept 90",
    SUM(salary) AS "Total"
    FROM employees
    GROUP BY job_id;

-- Rozdzia³ 6:

  -- Zadanie 1:
    SELECT location_id, street_address, city, state_province, country_name
    FROM locations NATURAL JOIN countries;

  -- Zadanie 2:
    SELECT last_name, department_id, department_name
    FROM employees JOIN departments
    USING (department_id);

  -- Zadanie 3:
    SELECT last_name, job_id, department_id, department_name
    FROM employees JOIN departments USING (department_id)
    JOIN locations USING (location_id)
    WHERE city='Toronto';

  -- Zadanie 4:
    SELECT w.last_name AS "Employee", w.employee_id AS "EMP#", m.last_name AS "Manager", m.employee_id AS "Mgr#"
    FROM employees w JOIN employees m
    ON (w.manager_id = m.employee_id)
    ORDER BY w.employee_id;

  -- Zadanie 5:
    SELECT w.last_name AS "Employee", w.employee_id AS "EMP#", m.last_name AS "Manager", m.employee_id AS "Mgr#"
    FROM employees w LEFT OUTER JOIN employees m
    ON (w.manager_id = m.employee_id)
    ORDER BY w.employee_id;

  -- Zadanie 6:
    SELECT e.department_id department, e.last_name employee, el.last_name colleague
    FROM employees e JOIN employees el ON e.department_id = el.department_id
    WHERE e.last_name != el.last_name
    ORDER BY 1, 2;

  -- Zadanie 7:
    SELECT e.last_name, e.job_id, d.department_name, e.salary, g.grade_level
    FROM employees e JOIN departments d USING (department_id)
    JOIN job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal
    ORDER BY e.salary;

  -- Zadanie 8:
    SELECT e.last_name, TO_CHAR(e.hire_date, 'DD-MON-YY') hire_date
    FROM employees e JOIN employees el
    ON (e.hire_date > el.hire_date)
    WHERE el.last_name = 'Davies';

  -- Zadanie 9:
    SELECT e.last_name, TO_CHAR(e.hire_date, 'DD-MON-YY') hire_date, m.last_name, TO_CHAR(m.hire_date, 'DD-MON-YY') hire_date_1
    FROM employees e JOIN employees m ON e.manager_id = m.employee_id
    WHERE e.hire_date < m.hire_date;
