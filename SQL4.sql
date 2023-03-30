-- Rozdzia³ 10:

  -- Zadanie 1:
    CREATE TABLE DEPT (
      id NUMBER(7) CONSTRAINT dept_dept_id_pk PRIMARY KEY,
      name VARCHAR2(25));

  -- Zadanie 2:
    INSERT INTO DEPT (id, name)
    SELECT department_id, department_name FROM departments;

  -- Zadanie 3:
    CREATE TABLE EMP (
      id NUMBER(7),
      last_name VARCHAR2(25),
      first_name VARCHAR2(25),
      dept_id NUMBER (7) CONSTRAINT emp_deptid_fk REFERENCES DEPT(id));

  -- Zadanie 4:
    CREATE TABLE employees2 AS
    (SELECT employee_id id, first_name, last_name, salary, department_id dept_id
      FROM employees);

  -- Zadanie 5:
    ALTER TABLE employees2 READ ONLY;

  -- Zadanie 6:
    INSERT INTO employees2 VALUES (34, 'Grant', 'Marcie', 5678, 10);

  -- Zadanie 7:
    ALTER TABLE employees2 READ WRITE;

  -- Zadanie 8:
    DROP TABLE employees2;

-- Rozdzia³ 11:

  -- Zadanie 1:
    CREATE OR REPLACE VIEW employees_vu AS
    SELECT employee_id,last_name employee, department_id
    FROM employees;

  -- Zadanie 2:
    SELECT * FROM employees_vu;

  -- Zadanie 3:
    SELECT employee, department_id FROM employees_vu;

  -- Zadanie 4:
    CREATE OR REPLACE VIEW dept50 AS
    SELECT employee_id empno, last_name employee, department_id deptno
    FROM employees WHERE department_id = 50 WITH READ ONLY;

  -- Zadanie 5:
    SELECT * FROM dept50;

  -- Zadanie 6:
    UPDATE dept50
    SET deptno = 80 WHERE employee = 'Matos';

  -- Zadanie 7:
    CREATE SEQUENCE dept_id_seq
    INCREMENT BY 10
    START WITH 200
    MAXVALUE 1000
    NOCACHE
    NOCYCLE;

  -- Zadanie 8:
    INSERT INTO dept VALUES (DEPT_ID_SEQ.NEXTVAL, 'Education');
    INSERT INTO dept VALUES (DEPT_ID_SEQ.NEXTVAL, 'Administration');

  -- Zadanie 9:
    CREATE INDEX dept_dept_name_ix
    ON dept(name);

  -- Zadanie 10:
    CREATE SYNONYM emp
    FOR employees;
