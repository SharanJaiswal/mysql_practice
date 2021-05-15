CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

CREATE TABLE dept (
    deptno DECIMAL(2 , 0 ),
    dname VARCHAR(14),
    loc VARCHAR(13),
    CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

CREATE TABLE emp (
    empno DECIMAL(4 , 0 ),
    ename VARCHAR(10),
    job VARCHAR(9),
    mgr DECIMAL(4 , 0 ),
    hiredate DATE,
    sal DECIMAL(7 , 2 ),
    comm DECIMAL(7 , 2 ),
    deptno DECIMAL(2 , 0 ),
    CONSTRAINT pk_emp PRIMARY KEY (empno),
    CONSTRAINT fk_deptno FOREIGN KEY (deptno)
        REFERENCES dept (deptno)
);

CREATE TABLE salgrade (
    grade DECIMAL(7 , 2 ),
    losal DECIMAL(7 , 2 ),
    hisal DECIMAL(7 , 2 )
);

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO dept (deptno, dname, loc)
VALUES (10, 'ACCOUNTING', 'NEW YORK'),
		(20, 'RESEARCH', 'DALLAS'),
        (30, 'SALES', 'CHICAGO'),
        (40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp
VALUES (7839, 'KING', 'PRESIDENT', NULL, STR_TO_DATE('17-11-1981', '%d-%c-%Y'), 5000, NULL, 10),
		(7698, 'BLAKE', 'MANAGER', 7839,STR_TO_DATE('1-5-1981', '%d-%c-%Y'), 2850, NULL, 30),
		(7782, 'CLARK', 'MANAGER', 7839,STR_TO_DATE('9-6-1981', '%d-%c-%Y'), 2450, NULL, 10),
		(7566, 'JONES', 'MANAGER', 7839,STR_TO_DATE('2-4-1981', '%d-%c-%Y'), 2975, NULL, 20),
		(7788, 'SCOTT', 'ANALYST', 7566,STR_TO_DATE('13-07-1987', '%d-%c-%Y'),3000, NULL, 20),
		(7902, 'FORD', 'ANALYST', 7566,STR_TO_DATE('3-12-1981', '%d-%c-%Y'),3000, NULL, 20),
		(7369, 'SMITH', 'CLERK', 7902,STR_TO_DATE('17-12-1980', '%d-%c-%Y'),800, NULL, 20),
		(7499, 'ALLEN', 'SALESMAN', 7698,STR_TO_DATE('20-2-1981', '%d-%c-%Y'),1600, 300, 30),
		(7521, 'WARD', 'SALESMAN', 7698,STR_TO_DATE('22-2-1981', '%d-%c-%Y'),1250, 500, 30),
		(7654, 'MARTIN', 'SALESMAN', 7698,STR_TO_DATE('28-9-1981', '%d-%c-%Y'),1250, 1400, 30),
		(7844, 'TURNER', 'SALESMAN', 7698,STR_TO_DATE('8-9-1981', '%d-%c-%Y'),1500, 0, 30),
		(7876, 'ADAMS', 'CLERK', 7788,STR_TO_DATE('13-07-1987', '%d-%c-%Y'),1100, NULL, 20),
		(7900, 'JAMES', 'CLERK', 7698,STR_TO_DATE('3-12-1981', '%d-%c-%Y'),950, NULL, 30),
		(7934, 'MILLER', 'CLERK', 7782,STR_TO_DATE('23-1-1982', '%d-%c-%Y'),1300, NULL, 10);
        
INSERT INTO salgrade
VALUES	(1, 700, 1200),
		(2, 1201, 1400),
		(3, 1401, 2000),
		(4, 2001, 3000),
		(5, 3001, 9999);
        
SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM dept;
SELECT * FROM emp;
SELECT * FROM salgrade;

