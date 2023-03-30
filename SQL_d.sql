-- Additional Practices:

  -- Zadanie 1:
    SELECT * FROM employees
    WHERE job_id LIKE '%CLERK%'
    AND hire_date > TO_DATE('1997', 'YYYY');

  -- Zadanie 2:
    SELECT last_name, job_id, salary, commission_pct
    FROM employees WHERE commission_pct IS NOT NULL
    ORDER BY salary DESC;

  -- Zadanie 3:
    SELECT 'The salary of ' || last_name || ' after a 10% raise is ' || ROUND((salary*1.1), 0) AS "New salary"
    FROM employees WHERE commission_pct IS NULL;

  -- Zadanie 4:
    SELECT last_name, TRUNC((MONTHS_BETWEEN(SYSDATE, hire_date)/12)) years,
    TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, hire_date),12)) months FROM employees
    ORDER BY 2 DESC, 3 DESC;

  -- Zadanie 5:
    SELECT last_name FROM employees WHERE SUBSTR(last_name, 1,1) IN ('J' , 'K', 'L', 'M');

  -- Zadanie 6:
    SELECT last_name, salary, DECODE(TO_CHAR(NVL(commission_pct, 0)), 0, 'No', 'Yes') commission
    FROM employees;

  -- Zadanie 7:
    SELECT d.department_name, d.location_id, e.last_name, e.job_id, e.salary
    FROM employees e JOIN departments d USING (department_id)
    WHERE d.location_id = &enter_location_id;

  -- Zadanie 8:
    SELECT COUNT(*) FROM employees WHERE last_name LIKE '%n';

    SELECT COUNT(*) FROM employees
    WHERE SUBSTR(last_name,LENGTH(last_name),LENGTH(last_name)) IN ('n');

  -- Zadanie 9:
    SELECT d.department_id, d.department_name, d.location_id, COUNT(e.employee_id)
    FROM departments d LEFT OUTER JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_id, d.department_name, d.location_id;

  -- Zadanie 10:
    SELECT job_id FROM employees WHERE department_id IN (10, 20);

  -- Zadanie 11:
    SELECT job_id, COUNT(employee_id) frequency FROM employees
    WHERE department_id IN
    (SELECT department_id FROM departments
      WHERE department_name IN ('Administration', 'Executive'))
    GROUP BY job_id
    ORDER BY frequency DESC;

  -- Zadanie 12:
    SELECT last_name, hire_date FROM employees
    WHERE TO_NUMBER(TO_CHAR(hire_date, 'DD'), 99) < 16;

  -- Zadanie 13:
    SELECT last_name, salary, TRUNC(salary/1000) thousands FROM employees;

  -- Zadanie 14:
    SELECT e.last_name, el.last_name manager, el.salary,
    (SELECT grade_level FROM job_grades WHERE el.salary BETWEEN lowest_sal AND highest_sal)
    FROM employees e JOIN employees el ON e.manager_id = el.employee_id
    WHERE el.salary > 15000;

  -- Zadanie 15:
    SELECT d.department_id, d.department_name, COUNT(e.employee_id) "EMPLOYEES",
    NVL(TO_CHAR(AVG(e.salary), '99999.99'), 'No average') avg_sal,
    e2.last_name, e2.salary, e2.job_id FROM employees e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
    RIGHT OUTER JOIN employees e2 ON e2.department_id = d.department_id
    GROUP BY d.department_id, d.department_name, e2.last_name, e2.salary, e2.job_id
    ORDER BY 1;

  -- Zadanie 16:
    SELECT department_id, MIN(salary) FROM employees
    GROUP BY department_id
    HAVING AVG(salary) = (SELECT MAX(AVG(salary)) FROM employees GROUP BY department_id);

  -- Zadanie 17:
    SELECT * FROM departments WHERE department_id NOT IN
    (SELECT department_id FROM employees WHERE job_id = 'SA_REP'
      AND department_id IS NOT NULL);

  -- Zadanie 18:
    -- a:
      SELECT e.department_id, d.department_name, COUNT(*)
      FROM employees e JOIN departments d ON e.department_id = d.department_id
      GROUP BY e.department_id, d.department_name
      HAVING COUNT(*) < 3;

    -- b:
      SELECT e.department_id, d.department_name, COUNT(*)
      FROM employees e JOIN departments d ON e.department_id = d.department_id
      GROUP BY e.department_id, d.department_name
      HAVING COUNT(*) IN (SELECT MAX(COUNT(*)) FROM employees GROUP BY department_id);

    -- c:
      SELECT e.department_id, d.department_name, COUNT(*)
      FROM employees e JOIN departments d ON e.department_id = d.department_id
      GROUP BY e.department_id, d.department_name
      HAVING COUNT(*) IN (SELECT MIN(COUNT(*)) FROM employees GROUP BY department_id);

    -- Zadanie 19:
      SELECT e.employee_id, e.last_name, e.department_id, e.salary,   AVG(el.salary)
      FROM employees e JOIN employees el ON e.department_id = el.department_id
      GROUP BY e.employee_id, e.last_name, e.department_id, e.salary;

    -- Zadanie 20:
      SELECT last_name, TO_CHAR(hire_date, 'DAY') DAY FROM employees
      WHERE TO_CHAR(hire_date, 'DY') =
      (SELECT TO_CHAR(hire_date, 'DY') FROM employees GROUP BY TO_CHAR(hire_date, 'DY')
      HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM employees GROUP BY TO_CHAR(hire_date, 'DY')));

    -- Zadanie 21:
      SELECT last_name, TO_CHAR(hire_date, 'MONTH DD') birthday FROM employees
      ORDER BY TO_CHAR(hire_date, 'MM DD');

-- Rozdia³ 2:

  -- Zadanie 1:
    -- a:
      CREATE TABLE member (
        member_id number(10) PRIMARY KEY NOT NULL,
        last_name varchar2(25) NOT NULL,
        first_name varchar2(25),
        address varchar2(100),
        city varchar2(30),
        phone varchar2(15),
        join_date date DEFAULT SYSDATE NOT NULL
      );

    -- b:
      CREATE TABLE title (
        title_id number(10) PRIMARY KEY NOT NULL,
        title varchar2(60) NOT NULL,
        description varchar2(400) NOT NULL,
        rating varchar2(4) CHECK (rating IN ('G', 'PG', 'NC17', 'NR')),
        category varchar2(20)
        CHECK (category IN ('DRAMA', 'COMEDY', 'ACTION', 'CHILD', 'SCIFI', 'DOCUMENTARY')),
        release_date date
      );

    -- c:
      CREATE TABLE title_copy (
        copy_id number(10),
        title_id number(10),
        status varchar2(15) NOT NULL
        CHECK (status IN ('AVAILABLE', 'DESTROYED', 'RENTED', 'RESERVED')),
        PRIMARY KEY (copy_id, title_id),
        FOREIGN KEY (title_id) REFERENCES title(title_id)
      );

    -- d:
      CREATE TABLE rental (
        book_date date DEFAULT SYSDATE,
        member_id number(10),
        copy_id number(10),
        act_ret_date date,
        exp_ret_date date DEFAULT (SYSDATE+2),
        title_id number(10),
        PRIMARY KEY (book_date, member_id, copy_id, title_id),
        FOREIGN KEY (member_id) REFERENCES member(member_id),
        FOREIGN KEY (copy_id, title_id) REFERENCES title_copy(copy_id, title_id)
      );

    -- e:
      CREATE TABLE reservation (
        res_date date,
        member_id number(10),
        title_id number(10),
        PRIMARY KEY (res_date, member_id, title_id),
        FOREIGN KEY (member_id) REFERENCES member(member_id),
        FOREIGN KEY (title_id) REFERENCES title(title_id)
      );

    -- Zadanie 2:

      -- a:
        CREATE SEQUENCE member_id_seq
        START WITH 101
        NOCACHE;

      -- b:
        CREATE SEQUENCE title_id_seq
        START WITH 92
        NOCACHE;

      -- c:
       -- verified;

    -- Zadanie 4:

      -- a:
        INSERT INTO title VALUES (
          TITLE_ID_SEQ.nextval, 'Willie and Christmas Too',
          'All of Willie'+"'"+'s friendsd make a Christmas list for Santa, but Willies has yet to add hist own wish list.',
          'G', 'CHILD', TO_DATE('05-10-1995','DD-MM-YYYY'));
        INSERT INTO title VALUES (
          TITLE_ID_SEQ.nextval, 'Alien Again',
          'Yet another installation of science fiction history. Can the heroine save the planet from the alien life form?',
          'R', 'SCIFI', TO_DATE('19-05-1995','DD-MM-YYYY'));
        INSERT INTO title VALUES (
          TITLE_ID_SEQ.nextval, 'The Glob',
          'A meteor crashes near a small American town and unleashes carnivorous goo in this classic.',
          'NR', 'SCIFI', TO_DATE('12-08-1995','DD-MM-YYYY'));
        INSERT INTO title VALUES (
          TITLE_ID_SEQ.nextval, 'My Day Off',
          'With a little luck and a lot of ingenuity, a teenager skips school for a day in New York.',
          'PG', 'COMEDY', TO_DATE('12-07-1995','DD-MM-YYYY'));
        INSERT INTO title VALUES (
          TITLE_ID_SEQ.nextval, 'Miracles on Ice',
          'A six-year-old has doubts about Santa Claus, but she discovers that miracles really do exist.',
          'PG', 'DRAMA', TO_DATE('12-09-1995','DD-MM-YYYY'));
        INSERT INTO title VALUES (
          TITLE_ID_SEQ.nextval, 'Soda Gang',
          'After discovering a cache of drugs, a young couple find themselves pitted against a vicious gang.',
          'NR', 'ACTION', TO_DATE('01-06-1995','DD-MM-YYYY'));

      -- b:
        INSERT INTO member VALUES (
          MEMBER_ID_SEQ.nextval, 'Velasquez', 'Carmen', '283 King Street',
          'Seattle', '206-899-6666', TO_DATE('08-03-1990','DD-MM-YYYY'));
        INSERT INTO member VALUES (
          MEMBER_ID_SEQ.nextval, 'Nago', 'LaDoris', '5 Modrany',
          'Bratislava', '586-355-8882', TO_DATE('08-03-1990','DD-MM-YYYY'));
        INSERT INTO member VALUES (
          MEMBER_ID_SEQ.nextval, 'Nagayama', 'Midori', '68 Via Centrale',
          'Sao Paolo', '254-852-5764', TO_DATE('17-06-1991','DD-MM-YYYY'));
        INSERT INTO member VALUES (
          MEMBER_ID_SEQ.nextval, 'Quick-to-See', 'Mark', '6921 King Way',
          'Lagos', '63-559-7777', TO_DATE('07-04-1990','DD-MM-YYYY'));
        INSERT INTO member VALUES (
          MEMBER_ID_SEQ.nextval, 'Ropeburn', 'Audry', '86 Chu Street',
          'Hong Kong', '41-559-87', TO_DATE('18-01-1991','DD-MM-YYYY'));
        INSERT INTO member VALUES (
          MEMBER_ID_SEQ.nextval, 'Urguhart', 'Molly', '3035 Laurier',
          'Quebec', '418-542-9988', TO_DATE('18-01-1991','DD-MM-YYYY'));

      -- c:
        INSERT INTO title_copy VALUES (1, 93, 'AVAILABLE');
        INSERT INTO title_copy VALUES (1, 95, 'AVAILABLE');
        INSERT INTO title_copy VALUES (2, 95, 'RENTED');
        INSERT INTO title_copy VALUES (1, 96, 'AVAILABLE');
        INSERT INTO title_copy VALUES (1, 97, 'AVAILABLE');
        INSERT INTO title_copy VALUES (2, 97, 'AVAILABLE');
        INSERT INTO title_copy VALUES (3, 97, 'RENTED');
        INSERT INTO title_copy VALUES (1, 98, 'AVAILABLE');
        INSERT INTO title_copy VALUES (1, 99, 'AVAILABLE');

      -- d:
        INSERT INTO rental VALUES ((SYSDATE-3), 103, 1, NULL, (SYSDATE-1), 93);
        INSERT INTO rental VALUES ((SYSDATE-1), 103, 2, NULL, (SYSDATE+1), 95);
        INSERT INTO rental VALUES ((SYSDATE-2), 104, 3, NULL, (SYSDATE), 97);
        INSERT INTO rental VALUES ((SYSDATE-4), 108, 1, NULL, (SYSDATE-2), 99);

    -- Zadanie 5:
      CREATE OR REPLACE VIEW title_avail AS
      SELECT DISTINCT t.title, c.copy_id, c.status, r.exp_ret_date
      FROM title t JOIN title_copy c ON t.title_id = c.title_id
      JOIN rental r ON t.title_id = r.title_id ORDER BY title;

    -- Zadanie 6:

      -- a:
        INSERT INTO title VALUES (
          TITLE_ID_SEQ.nextval, 'Interstellar Wars',
          'Futuristic interstellar aaction movie. Can the rebels save the humans from the evil empire?',
          'PG', 'SCIFI', TO_DATE('07-07-1977','DD-MM-YYYY'));
        INSERT INTO title_copy VALUES (1, 100, 'AVAILABLE');
        INSERT INTO title_copy VALUES (2, 100, 'AVAILABLE');

      -- b:
        INSERT INTO reservation VALUES ((SYSDATE+30), 103, 100);
        INSERT INTO reservation VALUES ((SYSDATE+15), 106, 99);

    -- Zadanie 7:

      -- a:
        ALTER TABLE title
        ADD price number(8,2);

      -- b:
        UPDATE title
        SET price = 25 WHERE title_id = 93;
        UPDATE title
        SET price = 35 WHERE title_id = 95;
        UPDATE title
        SET price = 35 WHERE title_id = 96;
        UPDATE title
        SET price = 35 WHERE title_id = 97;
        UPDATE title
        SET price = 30 WHERE title_id = 98;
        UPDATE title
        SET price = 35 WHERE title_id = 99;
        UPDATE title
        SET price = 29 WHERE title_id = 100;

      -- Zadanie 8:
        SELECT m.first_name ||' '|| m.last_name member, t.title, r.book_date,
        (r.exp_ret_date - r.book_date) duration FROM rental r JOIN title t
        ON r.title_id = t.title_id JOIN member m ON r.member_id = m.member_id;
