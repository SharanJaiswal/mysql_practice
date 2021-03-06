SELECT 
    *
FROM
    emp;

SELECT DISTINCT
    job
FROM
    emp;

SELECT 
    *
FROM
    emp
ORDER BY sal ASC;

SELECT 
    *
FROM
    emp
ORDER BY deptno ASC , job DESC;

SELECT DISTINCT
    job
FROM
    emp
ORDER BY job DESC;

SELECT 
    *
FROM
    emp
WHERE
    empno IN (SELECT 
            mgr
        FROM
            emp);

SELECT 
    *
FROM
    emp
WHERE
    YEAR(hiredate) < '1981';

SELECT 
    empno, ename, sal, ROUND(sal / 30, 2) AS `Daily Sal`
FROM
    emp
ORDER BY ROUND(sal * 12, 2) ASC;

SELECT 
    empno,
    ename,
    job,
    hiredate,
    CONCAT(TIMESTAMPDIFF(MONTH,
                hiredate,
                CURDATE()),
            ' Months') AS `Experience`
FROM
    emp
WHERE
    empno IN (SELECT 
            mgr
        FROM
            emp);

SELECT 
    empno,
    ename,
    sal,
    CONCAT(TIMESTAMPDIFF(MONTH,
                hiredate,
                CURDATE()),
            ' Months') AS `Experience`
FROM
    emp
WHERE
    mgr = 7369;

SELECT 
    *
FROM
    emp
WHERE
    IFNULL(comm, 0) > sal;

SELECT 
    *
FROM
    emp
WHERE
    QUARTER(hiredate) > 2
        AND YEAR(hiredate) = '1981'
ORDER BY job ASC;

SELECT 
    *,
    CONCAT(TIMESTAMPDIFF(MONTH,
                hiredate,
                CURDATE()),
            ' Months') AS `Experience`
FROM
    emp
WHERE
    TRUNCATE(sal / 30, 2) > 100;

SELECT 
    *
FROM
    emp
WHERE
    job IN ('clerk' , 'analyst')
ORDER BY job DESC;

SELECT 
    *
FROM
    emp
WHERE
    hiredate IN (STR_TO_DATE('1-MAY-81', '%d-%b-%y') , STR_TO_DATE('3-DEC-81', '%d-%b-%y'),
        STR_TO_DATE('17-DEC-81', '%d-%b-%y'),
        STR_TO_DATE('19-JAN-80', '%d-%b-%y'))
ORDER BY TIMESTAMPDIFF(DAY, hiredate, CURDATE()) ASC;

SELECT 
    *
FROM
    emp
WHERE
    deptno IN (10 , 20);

SELECT 
    *
FROM
    emp
WHERE
    YEAR(hiredate) = YEAR(STR_TO_DATE('81', '%y'));		-- STR_TO_DATE('81', '%y') gives '1981-00-00' as an output.

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%b %Y') = 'Aug 1980';
-- STR_TO_DATE('Aug 1980', '%b %Y') cant be used as it gives '1980-08-00' as an output which can't get directly compared with the emp.hiredate, as their DAY part can't be '00'.
-- You can use BETWEEN CLAUSE also, if it is required===> ...WHERE hiredate BETWEEN CAST('1980-08-01' AS DATE) AND LAST_DAY(STR_TO_DATE('Aug 1980', '%b %Y'));
    
SELECT 
    *
FROM
    emp
WHERE
    sal * 12 BETWEEN 22000 AND 45000;

SELECT 
    ename
FROM
    emp
WHERE
    CHARACTER_LENGTH(ename) = 5;

SELECT 
    ename
FROM
    emp
WHERE
    ename RLIKE '^S.{4}$';	
-- Don't leave patter expression without $ at the end because it'll check for names for at least of length 5 which starts from S/s.
-- We can also use {ename LIKE '%S' AND CHARACTER_LENGTH(ename)=5} | {ename LIKE 'S____'} operator.

SELECT 
    *
FROM
    emp
WHERE
    ename RLIKE '^..r.$';

SELECT 
    *
FROM
    emp
WHERE
    ename RLIKE '^S.{3}H$';

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%M') = 'January';

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%b') RLIKE '^.a';

SELECT 
    *
FROM
    emp
WHERE
    (CHARACTER_LENGTH(TRUNCATE(sal, 0)) = 4)
        AND NOT (TRUNCATE(sal, 0) MOD 10);
-- If sal is not truncated, then it'll also measure the length of the decimal point as well the 2 digits of decimal

SELECT 
    *
FROM
    emp
WHERE
    ename RLIKE 'll';

SELECT 
    *
FROM
    emp
WHERE
    CONCAT(DATE_FORMAT(hiredate, '%y'), 's') = '80s';

SELECT 
    *
FROM
    emp
WHERE
    deptno <> 20;	-- != or NOT IN (20) will also work fine.

SELECT 
    *
FROM
    emp
WHERE
    job NOT IN ('PRESIDENT' , 'MANAGER')
ORDER BY sal ASC;

SELECT 
    *
FROM
    emp
WHERE
    YEAR(hiredate) <> '1981';

SELECT 
    *
FROM
    emp
WHERE
    empno NOT RLIKE '^78';

SELECT 
    CONCAT_WS(' ', e.ename, 'works for', m.ename)
FROM
    emp AS e
        INNER JOIN
    emp AS m ON e.mgr = m.empno;

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%M') <> 'March';

SELECT 
    *
FROM
    emp
WHERE
    (deptno = 20) AND (job = 'clerk');

SELECT 
    *
FROM
    emp
WHERE
    (deptno IN (30 , 10))
        AND YEAR(hiredate) = '1981';

SELECT 
    *
FROM
    emp
WHERE
    ename = 'SMITH';

SELECT 
    d.loc
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
WHERE
    e.ename = 'SMITH';

SELECT 
    e.*, d.dname AS `DNAME`, d.loc AS `Loc`
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
WHERE
    d.dname IN ('ACCOUNTING' , 'RESEARCH')
ORDER BY d.deptno ASC;

SELECT 
    e.empno, e.ename, e.sal, d.dname
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
WHERE
    (e.job IN ('MANAGER' , 'ANALYST'))
        AND (d.loc IN ('NEW YORK' , 'DALLAS'))
        AND (TIMESTAMPDIFF(YEAR,
        e.hiredate,
        CURDATE()) > 7)
        AND (IFNULL(e.comm, 0) = 0)
ORDER BY d.loc;

SELECT 
    e.empno, e.ename, e.sal, d.dname, d.loc, d.deptno, e.job
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
WHERE
    ((d.loc = 'CHICAGO')
        OR ((d.dname = 'ACCOUNTING')
        AND (e.sal * 12 > 28000)
        AND (e.sal NOT IN (3000 , 2800))))
        AND (e.empno RLIKE '^..[78]')
        AND e.job <> 'MANAGER'
ORDER BY d.deptno ASC , e.job DESC;

SELECT 
    e.*, r.grade
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON e.sal BETWEEN r.losal AND r.hisal
ORDER BY r.grade ASC;

SELECT 
    e.*, r.grade
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON e.sal BETWEEN r.losal AND r.hisal
WHERE
    TRUNCATE(r.grade, 0) IN (2 , 3);

SELECT 
    e.*, r.grade
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON e.sal BETWEEN r.losal AND r.hisal
WHERE
    (e.job IN ('Analyst' , 'Manager'))
        AND (TRUNCATE(r.grade, 0) IN (4 , 5));

SELECT 
    e.empno,
    e.ename,
    e.sal,
    d.dname,
    r.grade,
    TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) AS `Exp`,
    sal * 12 AS `Annual Salaray`
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON e.deptno = d.deptno
        AND e.sal BETWEEN r.losal AND r.hisal
WHERE
    e.deptno IN (10 , 20);

SELECT 
    e.*, d.loc, r.grade
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON (e.deptno = d.deptno)
        AND (e.sal BETWEEN r.losal AND r.hisal)
WHERE
    (TRUNCATE(r.grade, 0) BETWEEN 2 AND 4)
        AND (d.dname NOT RLIKE '^OP.*S$')
        AND (e.job RLIKE 'A')
        AND (YEAR(hiredate) = '1981'
        AND DATE_FORMAT(hiredate, '%b') NOT IN ('Mar' , 'Sep'))
        AND NOT (e.sal MOD 100)
ORDER BY r.grade ASC;

SELECT 
    d.*, e.empno, e.ename
FROM
    dept AS d
        LEFT JOIN
    emp AS e ON d.deptno = e.deptno;

SELECT 
    *
FROM
    emp
WHERE
    sal > (SELECT 
            sal
        FROM
            emp
        WHERE
            ename = 'BLAKE');

SELECT 
    *
FROM
    emp
WHERE
    job = (SELECT 
            job
        FROM
            emp
        WHERE
            ename = 'ALLEN');

SELECT 
    *
FROM
    emp
WHERE
    TO_DAYS(hiredate) > (SELECT 
            TO_DAYS(hiredate)
        FROM
            emp
        WHERE
            ename = 'KING');

SELECT 
    e.*
FROM
    emp AS e
WHERE
    EXISTS( SELECT 
            *
        FROM
            emp
        WHERE
            (e.mgr = empno)
                AND (TO_DAYS(e.hiredate) > TO_DAYS(hiredate)));

SELECT 
    *
FROM
    emp
WHERE
    (deptno = 20)
        AND (job IN (SELECT 
            job
        FROM
            emp
        WHERE
            deptno = 10));

SELECT 
    *
FROM
    emp
WHERE
    sal IN (SELECT 
            sal
        FROM
            emp
        WHERE
            ename IN ('FORD' , 'SMITH'))
ORDER BY sal DESC;

SELECT 
    *
FROM
    emp
WHERE
    (job = (SELECT 
            job
        FROM
            emp
        WHERE
            ename = 'MILLER'))
        OR (sal > (SELECT 
            sal
        FROM
            emp
        WHERE
            ename = 'ALLEN'));

SELECT 
    *
FROM
    emp
WHERE
    sal > (SELECT 
            SUM(sal + IFNULL(comm, 0))
        FROM
            emp
        WHERE
            job = 'SALESMAN');

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
WHERE
    (TO_DAYS(e.hiredate) > (SELECT 
            TO_DAYS(hiredate)
        FROM
            emp
        WHERE
            ename = 'BLAKE'))
        AND (d.loc IN ('CHICAGO' , 'BOSTON'));

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.deptno = d.deptno)
        AND (e.sal BETWEEN r.losaL AND r.hisal))
WHERE
    (TRUNCATE(r.grade, 0) IN (3 , 4))
        AND (d.dname IN ('ACCOUNTING' , 'RESEARCH'))
        AND (e.sal > (SELECT 
            sal
        FROM
            emp
        WHERE
            ename = 'ALLEN'))
        AND (TIMESTAMPDIFF(MONTH,
        hiredate,
        CURDATE()) > (SELECT 
            TIMESTAMPDIFF(MONTH,
                    hiredate,
                    CURDATE())
        FROM
            emp
        WHERE
            ename = 'SMITH'))
ORDER BY TIMESTAMPDIFF(MONTH,
    hiredate,
    CURDATE());

SELECT 
    *
FROM
    emp
WHERE
    job IN (SELECT 
            job
        FROM
            emp
        WHERE
            ename IN ('SMITH' , 'ALLEN'));

SELECT 
    e.*
FROM
    emp AS e
WHERE
    EXISTS( SELECT 
            *
        FROM
            emp
        WHERE
            (e.empno <> empno) AND (e.sal = sal));.

SELECT 
    *
FROM
    emp
WHERE
    (3 / 4) * sal = ANY (SELECT 
            sal
        FROM
            emp
        WHERE
            empno IN (SELECT 
                    mgr
                FROM
                    emp));

SELECT 
    *
FROM
    emp
WHERE
    sal IN (SELECT 
            e.sal
        FROM
            emp AS e
                INNER JOIN
            dept AS d ON e.deptno = d.deptno
        WHERE
            (TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 5)
                AND (d.dname = 'SALES'));

SELECT 
    *
FROM
    emp
WHERE
    sal IN (SELECT 
            e.sal
        FROM
            emp AS e
                INNER JOIN
            salgrade AS r ON e.sal BETWEEN r.losal AND r.hisal
        WHERE
            TRUNCATE(r.grade, 0) = 2);

SELECT 
    *
FROM
    emp
WHERE
    sal IN (SELECT 
            e.sal
        FROM
            emp AS e
                INNER JOIN
            dept AS d
                INNER JOIN
            salgrade AS r ON ((e.sal BETWEEN r.losal AND r.hisal)
                AND (e.deptno = d.deptno))
        WHERE
            (TRUNCATE(r.grade, 0) IN (2 , 3))
                AND (d.dname IN ('SALES' , 'OPERATIONS'))
                AND (RIGHT(YEAR(hiredate), 2) = '89'));

SELECT 
    job
FROM
    emp
WHERE
    (deptno = 10)
        AND (job NOT IN (SELECT DISTINCT
            job
        FROM
            emp
        WHERE
            deptno = 20));

SELECT 
    *
FROM
    emp
WHERE
    empno NOT IN (SELECT DISTINCT
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL);	-- IMP QUERRY: see, we used IS NOT NULL for MGR in sub-query.

SELECT 
    MAX(sal)
FROM
    emp;

SELECT 
    *
FROM
    emp
WHERE
    sal = (SELECT 
            MAX(sal)
        FROM
            emp);

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno)
WHERE
    (e.sal = (SELECT 
            MAX(e.sal)
        FROM
            emp AS e
                INNER JOIN
            dept AS d ON e.deptno = d.deptno
        WHERE
            d.dname = 'SALES'))
        AND (d.dname = 'SALES');

WITH cte AS (SELECT e.sal AS `grd3_chic_sal`, e.empno AS `grd3_chic_empno` FROM emp AS e INNER JOIN salgrade AS r INNER JOIN dept AS d ON ((e.sal BETWEEN r.losal AND r.hisal) AND (e.deptno = d.deptno)) WHERE (TRUNCATE(r.grade, 0) = 3) AND (d.loc = 'CHICAGO')) SELECT * FROM emp WHERE empno = (SELECT `grd3_chic_empno` FROM cte WHERE `grd3_chic_sal` = (SELECT MAX(`grd3_chic_sal`) FROM cte));

SELECT 
    *
FROM
    emp
WHERE
    hiredate < (SELECT 
            MAX(hiredate)
        FROM
            emp
        WHERE
            mgr = (SELECT 
                    empno
                FROM
                    emp
                WHERE
                    ename = 'KING'));

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.deptno = d.deptno)
        AND (e.sal BETWEEN r.losal AND r.hisal))
WHERE
    (d.loc = 'NEW YORK')
        AND (TRUNCATE(r.grade, 0) BETWEEN 3 AND 5)
        AND (e.job <> 'PRESIDENT')
        AND (e.sal > (SELECT 
            MAX(`sal_chic_sales_manager_not_under_king`)
        FROM
            (SELECT 
                sal AS `sal_chic_sales_manager_not_under_king`
            FROM
                emp
            WHERE
                empno IN (SELECT 
                        `chic_s_m_eno`
                    FROM
                        (SELECT 
                        e.empno AS `chic_s_m_eno`, e.mgr AS `chic_s_m_mgr`
                    FROM
                        emp AS e
                    INNER JOIN dept AS d ON (e.deptno = d.deptno)
                    WHERE
                        (d.loc = 'CHICAGO')
                            AND (e.job IN ('SALESMAN' , 'MANAGER'))) AS `chic_sales_manager`
                    WHERE
                        `chic_sales_manager`.`chic_s_m_mgr` <> (SELECT 
                                empno
                            FROM
                                emp
                            WHERE
                                ename = 'KING'))) AS `max_sal`));

SELECT 
    *
FROM
    emp
WHERE
    YEAR(hiredate) = '1981'
ORDER BY hiredate ASC
LIMIT 1;

SELECT 
    *
FROM
    emp
WHERE
    job IN (SELECT 
            job
        FROM
            emp
        WHERE
            hiredate IN (SELECT 
                    MAX(hiredate)
                FROM
                    emp
                WHERE
                    YEAR(hiredate) = '1981'))
        AND YEAR(hiredate) = '1981';

SELECT 
    *
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
WHERE
    (e.mgr = (SELECT 
            empno
        FROM
            emp
        WHERE
            ename = 'KING'))
        AND (TRUNCATE(r.grade, 0) > 3)
ORDER BY e.hiredate ASC
LIMIT 1;
-- ANOTHER METHOD: make cte set of cond.s (under king, grade>3). From cte, take min hiredate. For that hiredate, refer cte for empno. For that empno, query emp table.

SELECT 
    SUM(sal)
FROM
    emp
WHERE
    empno IN (SELECT DISTINCT
            mgr
        FROM
            emp);

SELECT 
    job, SUM(sal * 12) AS `Annual Salary`
FROM
    emp
WHERE
    YEAR(hiredate) = '1981'
GROUP BY job;

SELECT 
    SUM(e.sal)
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
WHERE
    (r.grade = 3);

SELECT 
    ROUND(AVG(sal), 2) AS `Clerk Average Salary`
FROM
    emp
WHERE
    job = 'CLERK';

SELECT 
    *
FROM
    emp
WHERE
    (deptno = 20)
        AND (sal > (SELECT 
            AVG(sal)
        FROM
            emp
        WHERE
            deptno = 10));

SELECT 
    e.job, d.deptno, COUNT(e.deptno)
FROM
    emp AS e
        RIGHT JOIN
    dept AS d ON d.deptno = e.deptno
GROUP BY e.job , d.deptno WITH ROLLUP;
-- perfect question to demonstarate core cocept of JOINS and GROUP BY.
-- Remember , GROUP BY and DISTINCT on col containing NULL value(s) can return NULL as one DISTINCT grouped/distinct value.
-- Concept: make groups of valid possible values, then see what defines those groups from another table,
-- it'll generally be realted to joining points and in another table some null will bw present in that defining column.
-- So, instead of counting the row count for each group, count the no of values from null containing col, for each group.
-- Since  AGG functions consider 0 fro NULL values, count will give 0 even though group/distinct has row head as NULL.

SELECT 
    e.mgr, COUNT(*)
FROM
    (SELECT DISTINCT
        mgr
    FROM
        emp
    WHERE
        mgr IS NOT NULL) AS `mgrs_no`
        LEFT JOIN
    emp AS e ON `mgrs_no`.mgr = e.mgr
GROUP BY e.mgr
ORDER BY e.mgr;

SELECT 
    d.*
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
GROUP BY e.deptno
HAVING COUNT(*) > 1;

SELECT 
    TRUNCATE(r.grade, 0) AS `Salary Grade`,
    COUNT(e.sal) AS `Total Employees`,
    FORMAT(MAX(e.sal), 2) AS `Maximum Salary`
FROM
    salgrade AS r
        LEFT JOIN
    emp AS e ON e.sal BETWEEN r.losal AND r.hisal
GROUP BY TRUNCATE(r.grade, 0);

SELECT 
    d.dname, r.grade, COUNT(*)
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.deptno = d.deptno)
        AND (e.sal BETWEEN r.losal AND r.hisal))
WHERE d.deptno IN (SELECT deptno FROM emp WHERE job = 'CLERK' GROUP BY deptno HAVING COUNT(*) > 1)
GROUP BY d.dname , r.grade;

SELECT 
    *
FROM
    dept
WHERE
    deptno IN (SELECT 
            deptno
        FROM
            emp
        GROUP BY deptno
        HAVING COUNT(*) = (SELECT 
                MAX(`emp count`.`count per dept`)
            FROM
                (SELECT 
                    COUNT(*) AS `count per dept`
                FROM
                    emp
                GROUP BY deptno) AS `emp count`));

SELECT 
    e.*
FROM
    emp AS e
        RIGHT JOIN
    emp AS m ON e.mgr = m.empno
WHERE
    m.empno IN (SELECT 
            empno
        FROM
            emp
        WHERE
            ename = 'JONES');

SELECT 
    *
FROM
    emp
WHERE
    (sal * 1.2) > 3000;

SELECT 
    e.*, d.dname
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno;

SELECT 
    e.*
FROM
    emp AS e
        RIGHT JOIN
    dept AS d ON (d.deptno = e.deptno)
WHERE
    (d.dname <> 'SALES');

SELECT 
    e.ename, d.deptno, d.dname, e.sal, IFNULL(comm, 0)
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
WHERE
    (e.sal BETWEEN 2000 AND 5000)
        AND (d.loc = 'CHICAGO');

SELECT 
    e.*
FROM
    emp AS e
        RIGHT JOIN
    emp AS m ON e.mgr = m.empno
WHERE
    e.sal > m.sal;

SELECT 
    TRUNCATE(r.grade, 0), e.ename
FROM
    emp AS e
        RIGHT JOIN
    salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
WHERE
    (e.deptno IN (10 , 30))
        AND (r.grade <> 4)
        AND (hiredate < STR_TO_DATE('31-dec-82', '%d-%b-%y'));

SELECT 
    e.ename, e.job, d.dname, d.loc
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno)
WHERE
    e.empno IN (SELECT 
            empno
        FROM
            emp
        WHERE
            job = 'MANAGER');

SELECT 
    e.*, m.ename AS `Manager`
FROM
    emp AS e
        INNER JOIN
    emp AS m ON (e.mgr = m.mgr)
WHERE
    (m.ename = 'JONES');

SELECT 
    e.ename, e.sal
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
WHERE
    (e.ename = 'FORD') AND (e.sal = r.hisal);

SELECT 
    e.ename, e.job, d.dname, e.sal, r.grade
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.deptno = d.deptno)
        AND (e.sal BETWEEN r.losal AND r.hisal))
ORDER BY d.deptno;

SELECT 
    e.ename, e.job, e.sal, r.grade, d.dname
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.deptno = d.deptno)
        AND (e.sal BETWEEN r.losal AND r.hisal))
WHERE
    (e.job <> 'CLERK')
ORDER BY e.sal DESC;

SELECT 
    ename, job
FROM
    emp
WHERE
    empno IN (SELECT 
            empno
        FROM
            emp
        WHERE
            mgr IS NULL);

SELECT 
    *
FROM
    emp
WHERE
    empno IN (SELECT 
            `eo`.empno
        FROM
            emp AS `eo`
                RIGHT JOIN
            (SELECT 
                d.deptno AS `deptno`, MAX(IFNULL(e.sal, 0.00)) AS `max sal`
            FROM
                emp AS e
            RIGHT JOIN dept AS d ON d.deptno = e.deptno
            GROUP BY d.deptno) AS `dept max sal` ON (`dept max sal`.`deptno` = `eo`.deptno)
        WHERE
            (IFNULL(`eo`.sal, 0.00) = `dept max sal`.`max sal`)
        GROUP BY `dept max sal`.`deptno` , `eo`.empno)
ORDER BY deptno;
-- this still needs some look, to display the info about deptno 40 in the final result. Below is the same answer with diferent approach
WITH cte (deptno, max_sal) AS (SELECT d.deptno, MAX(IFNULL(e.sal, 0)) FROM emp AS e RIGHT JOIN dept AS d ON (e.deptno = d.deptno) GROUP BY d.deptno) SELECT e.ename, e.sal, cte.deptno FROM emp AS e RIGHT JOIN cte ON (e.deptno = cte.deptno) WHERE (e.sal = cte.max_sal) order by e.deptno;

SELECT 
    *
FROM
    emp
WHERE
    sal = ROUND((SELECT 
                    (MAX(sal) + MIN(sal)) / 2
                FROM
                    emp),
            2);
SELECT 
    deptno, COUNT(*)
FROM
    emp
GROUP BY deptno
HAVING COUNT(*) > 3;

SELECT 
    d.dname, COUNT(*)
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
GROUP BY d.deptno
HAVING COUNT(*) > 2;

SELECT DISTINCT
    m.*, FORMAT(AVG(e.sal), 2) AS `Employee Average Salary`
FROM
    emp AS e
        INNER JOIN
    emp AS m ON e.mgr = m.empno
GROUP BY e.mgr
HAVING m.sal > AVG(e.sal);
-- there might be two cases. First, a manager may not have employee, but here its not possible because emp table is about emp and it tell if emp has manager or not.
-- There is no info table of managers which lists managers. Second, an employee may not have manager.
-- Here we will consider first case because for that case man.sal > emp.sal always since emp is null.
-- Dont use second case because sal.mgr is in predominantly in context.

SELECT 
    ename, sal, IFNULL(comm, 0.00)
FROM
    emp AS e
WHERE
    (sal + IFNULL(comm, 0.00)) >= ANY (SELECT 
            sal
        FROM
            emp
        WHERE
            e.empno <> empno);

SELECT 
    *
FROM
    emp AS e
        INNER JOIN
    emp AS m ON e.mgr = m.empno
WHERE
    (e.sal < m.sal)
        AND (e.sal > ANY (SELECT 
            sal
        FROM
            emp
        WHERE
            (empno IN (SELECT 
                    mgr
                FROM
                    emp
                WHERE
                    mgr IS NOT NULL))
                AND (e.mgr <> empno)));

SELECT 
    e.ename, `avg sal deptwise`.`avg sal`
FROM
    emp AS e
        INNER JOIN
    (SELECT 
        AVG(sal) AS `avg sal`, deptno AS `dept`
    FROM
        emp
    GROUP BY deptno) AS `avg sal deptwise` ON `avg sal deptwise`.`dept` = e.deptno;

SELECT 
    *
FROM
    emp AS e
        INNER JOIN
    (SELECT DISTINCT
        (ROUND(sal + IFNULL(comm, 0.00), 2)) AS `five min sal`
    FROM
        emp
    ORDER BY sal + IFNULL(comm, 0.00) ASC
    LIMIT 5) AS `min five sal tab` ON ROUND(e.sal + IFNULL(e.comm, 0.00), 2) = `min five sal tab`.`five min sal`;
-- SELECT e.* FROM emp AS e WHERE 5 > (SELECT COUNT(*) FROM emp WHERE e.sal > sal);
-- first is earneres of least 5 amount/sal. Second is 5 least earners; SUBQUERY will return 0(least salary (pk_indexed)),1,2,3,4

SELECT 
    *
FROM
    emp AS e
        INNER JOIN
    emp AS m ON e.mgr = m.empno
WHERE
    e.sal > m.sal;

SELECT 
    *
FROM
    emp
WHERE
    empno IN (SELECT 
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL)
        AND mgr NOT IN (SELECT 
            empno
        FROM
            emp
        WHERE
            job = 'PRESIDENT');

SELECT 
    e.*
FROM
    emp AS e
        LEFT JOIN
    dept AS d ON e.deptno = d.deptno
WHERE
    d.deptno IS NULL;
-- SELECT * FROM emp WHERE deptno NOT IN (SELECT deptno FROM dept); 

SELECT 
    ename,
    sal,
    IFNULL(comm, 0.00),
    FORMAT(sal + IFNULL(comm, 0.00), 2)
FROM
    emp
WHERE
    sal + IFNULL(comm, 0.00) > ANY (SELECT 
            sal + IFNULL(comm, 0.00)
        FROM
            emp);

SELECT 
    ename
FROM
    emp
WHERE
    TIMESTAMPDIFF(YEAR,
        hiredate,
        STR_TO_DATE('31-Dec-89', '%d-%b-%y')) < 20;

SELECT 
    *
FROM
    emp
WHERE
    ROUND(sal, 0) % 2 = 1;

SELECT 
    *
FROM
    emp
WHERE
    CHARACTER_LENGTH(ROUND(sal, 0)) = 3;

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%b') = 'Dec';

SELECT 
    *
FROM
    emp
WHERE
    ename RLIKE 'A';

SELECT 
    *
FROM
    emp
WHERE
    POSITION(deptno IN ROUND(sal, 0)) <> 0;

SELECT 
    *
FROM
    emp
WHERE
    LEFT(hiredate, 2) = RIGHT(ROUND(sal, 0), 2);

SELECT 
    *
FROM
    emp
WHERE
    sal * 0.1 = DATE_FORMAT(hiredate, '%y');

SELECT 
    CONCAT(LOWER(LEFT(ename,
                        CEIL(CHARACTER_LENGTH(ename) / 2))),
            UPPER(RIGHT(ename,
                        FLOOR(CHARACTER_LENGTH(ename) / 2))))
FROM
    emp;

SELECT 
    d.dname
FROM
    emp AS e
        RIGHT JOIN
    dept AS d ON e.deptno = d.deptno
GROUP BY d.deptno
HAVING COUNT(e.empno) = CHARACTER_LENGTH(d.dname);

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%d') < '15';

SELECT 
    d.dname
FROM
    dept AS d
WHERE
    CHARACTER_LENGTH(d.dname) IN (SELECT 
            COUNT(*)
        FROM
            emp
        WHERE
            d.deptno <> deptno
        GROUP BY deptno);

SELECT 
    *
FROM
    emp
WHERE
    (empno IN (SELECT 
            mgr
        FROM
            emp
        WHERE
            mgr IS NULL))
        OR (job = 'MANAGER');

SELECT 
    dname
FROM
    dept
WHERE
    deptno IN (SELECT 
            deptno
        FROM
            emp
        GROUP BY deptno
        HAVING COUNT(*) = (SELECT 
                MAX(`dept emp count`.`emp cnt deptwise`)
            FROM
                (SELECT 
                    COUNT(*) AS `emp cnt deptwise`
                FROM
                    emp
                GROUP BY deptno) AS `dept emp count`));

SELECT 
    COUNT(empno)
FROM
    emp
WHERE
    empno IN (SELECT DISTINCT
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL);

SELECT 
    hiredate, GROUP_CONCAT(ename)
FROM
    emp
GROUP BY hiredate;

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON e.sal BETWEEN r.losal AND r.hisal
WHERE
    TRUNCATE(r.grade, 0) = 0.1 * (SELECT 
            deptno
        FROM
            dept
        WHERE
            dname = 'SALES');

SELECT 
    d.dname
FROM
    emp AS e
        INNER JOIN
    dept AS d ON e.deptno = d.deptno
GROUP BY e.deptno
HAVING COUNT(*) > (SELECT 
        AVG(`emp cnt per dept tbl`.`emp cnt per dept`)
    FROM
        (SELECT 
            COUNT(*) AS `emp cnt per dept`
        FROM
            emp
        GROUP BY deptno) AS `emp cnt per dept tbl`);

SELECT 
    ename
FROM
    emp
WHERE
    empno IN (SELECT 
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL
        GROUP BY mgr
        HAVING COUNT(*) = (SELECT 
                MAX(`emp cnt per mgr tbl`.`emp cnt per mgr`)
            FROM
                (SELECT 
                    COUNT(*) AS `emp cnt per mgr`
                FROM
                    emp
                WHERE
                    mgr IS NOT NULL
                GROUP BY mgr) AS `emp cnt per mgr tbl`));

SELECT 
    ename, CONCAT('$', FORMAT(1.15 * sal, 2))
FROM
    emp;

SELECT 
    CONCAT_WS(' ', ename, 'is', job)
FROM
    emp;

SELECT 
    CONCAT(ename, ' (', job, ')')
FROM
    emp;

SELECT 
    empno, ename, DATE_FORMAT(hiredate, '%M %d, %Y')
FROM
    emp;

SELECT 
    ename,
    empno,
    CASE
        WHEN (sal > 1500.00) THEN 'JUST SALARY'
        WHEN (sal = 1500.00) THEN 'ON TARGET'
        ELSE 'BELOW 1500'
    END
FROM
    emp;

-- SELECT DAYOFWEEK(STR_TO_DATE(
SELECT 
    *,
    TIMESTAMPDIFF(MONTH,
        hiredate,
        CURDATE()) AS `Length of Service (in months)`
FROM
    emp;

SELECT 
    *,
    IF(DAY(hiredate) < 16,
        ADDDATE(LAST_DAY(hiredate),
            INTERVAL -((DAYOFWEEK(LAST_DAY(hiredate)) + 1) MOD 7) DAY),
        ADDDATE(LAST_DAY(hiredate),
            INTERVAL (((6 - DAYOFWEEK(LAST_DAY(hiredate))) + 7) % 7) DAY))
FROM
    emp;

SELECT 
    CHARACTER_LENGTH(REPLACE(ename, ' ', '')),
    CHARACTER_LENGTH(ename)
FROM
    emp;

SELECT 
    COUNT(*)
FROM
    emp
WHERE
    SUBSTRING_INDEX(sal, '.', - 1) <> 0;

SELECT 
    *
FROM
    emp
WHERE
    POSITION(MID(deptno, 1, 1) IN sal)
        AND POSITION(MID(deptno, 2, 1) IN sal);

SELECT DISTINCT
    m.*
FROM
    emp AS e
        INNER JOIN
    emp AS m ON e.mgr = m.empno
WHERE
    e.sal > m.sal;

SELECT 
    *
FROM
    emp
WHERE
    mgr IN (SELECT 
            empno
        FROM
            emp
        WHERE
            ename = 'BLAKE');

SELECT 
    *
FROM
    emp
WHERE
    empno IN (SELECT 
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL);

SELECT 
    e.*, m.ename AS `Manager Name`
FROM
    emp AS e
        INNER JOIN
    emp AS m ON e.mgr = m.empno
WHERE
    e.mgr IS NOT NULL AND m.ename = 'JONES';

SELECT 
    COUNT(*)
FROM
    emp
WHERE
    empno IN (SELECT DISTINCT
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL);	-- SELECT COUNT(*) FROM emp WHERE job = 'MANAGER';

SELECT 
    ROUND(AVG(sal), 2) AS `Average Salary`,
    ROUND(AVG(sal + IFNULL(comm, 0)), 2) AS `Average Total Renumeration`
FROM
    emp
GROUP BY job;

SELECT 
    empno, COUNT(*)
FROM
    emp
GROUP BY empno;

SELECT 
    *
FROM
    emp
WHERE
    sal < 1000
ORDER BY sal ASC;

SELECT 
    e.ename,
    e.job,
    e.sal * 12 AS `Annual Salary`,
    e.deptno,
    d.dname,
    TRUNCATE(r.grade, 0)
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.deptno = d.deptno)
        AND (e.sal BETWEEN r.losal AND r.hisal))
WHERE
    (e.sal * 12 >= 36000)
        OR (e.job <> 'CLERK');

SELECT 
    j1.job
FROM
    emp AS j1
        INNER JOIN
    emp AS j2 ON j1.job = j2.job
WHERE
    YEAR(j1.hiredate) = '1983'
        AND YEAR(j2.hiredate) = '1984'
        AND QUARTER(j1.hiredate) IN (1 , 2)
        AND QUARTER(j2.hiredate) IN (1 , 2);

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    emp AS m ON e.mgr = m.empno
WHERE
    e.hiredate < m.hiredate;

SELECT 
    e.ename, e.empno, m.ename, m.empno
FROM
    emp AS e
        LEFT JOIN
    emp AS m ON e.mgr = m.empno;

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    (SELECT 
        job AS `job`, MIN(sal) AS `Min sal jobwise`
    FROM
        emp
    GROUP BY job) AS `Min sal jobwise tbl` ON ((`Min sal jobwise tbl`.`Min sal jobwise` = e.sal)
        AND (`Min sal jobwise tbl`.`job` = e.job))
ORDER BY e.job;

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    (SELECT 
        job AS `job`, MAX(sal) AS `Max sal jobwise`
    FROM
        emp
    GROUP BY job) AS `Max sal jobwise tbl` ON ((`Max sal jobwise tbl`.`Max sal jobwise` = e.sal)
        AND (`Max sal jobwise tbl`.`job` = e.job))
ORDER BY e.sal DESC;

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    (SELECT 
        deptno AS `dept`, MAX(hiredate) AS `recent hire per dept`
    FROM
        emp
    GROUP BY deptno) AS `recent hire per dept tbl` ON ((`recent hire per dept tbl`.`recent hire per dept` = e.hiredate)
        AND (`recent hire per dept tbl`.`dept` = e.deptno))
ORDER BY e.hiredate;

SELECT 
    e.ename, e.sal, e.deptno
FROM
    emp AS e
        INNER JOIN
    (SELECT 
        deptno AS `dept`, AVG(sal) AS `avg sal deptwise`
    FROM
        emp
    GROUP BY deptno) AS `avg sal deptwise tbl` ON ((`avg sal deptwise tbl`.`dept` = e.deptno)
        AND (e.sal > `avg sal deptwise tbl`.`avg sal deptwise`));

SELECT 
    d.deptno
FROM
    emp AS e
        RIGHT JOIN
    dept AS d ON (e.deptno = d.deptno)
GROUP BY d.deptno
HAVING COUNT(e.empno) = 0;

SELECT 
    d.deptno,
    e.job,
    IFNULL(COUNT(e.empno), 0) AS `No. of Employees`,
    FORMAT(AVG(IFNULL(e.sal, 0.00)), 2) AS `Average sal per dept per job wise`
FROM
    emp AS e
        RIGHT JOIN
    dept AS d ON (e.deptno = d.deptno)
GROUP BY d.deptno , e.job;

SELECT 
    FORMAT(MAX(`avg sal per job tbl`.`avg sal per job`),
        2) AS `Max Avg Salary`
FROM
    (SELECT 
        job AS `job`, AVG(sal) AS `avg sal per job`
    FROM
        emp
    WHERE
        job <> 'PRESIDENT'
    GROUP BY job) AS `Avg sal per job tbl`;

SELECT 
    e.ename, e.job
FROM
    emp AS e
        INNER JOIN
    (SELECT 
        MAX(sal + IFNULL(comm, 0)) AS `Max Earning`
    FROM
        emp) AS `Max Earning Record`
WHERE
    e.sal = `Max Earning Record`.`Max Earning`;

SELECT 
    ename, job, sal
FROM
    emp
WHERE
    (deptno <> 10)
        AND (job IN (SELECT 
            job
        FROM
            emp
        WHERE
            deptno = 10))
        AND (sal IN (SELECT 
            sal
        FROM
            emp
        WHERE
            deptno = 10));

SELECT 
    e.deptno,
    e.ename,
    e.job,
    e.sal,
    ROUND(e.sal + IFNULL(e.comm, 0), 2)
FROM
    emp AS e
        INNER JOIN
    (SELECT 
        MAX(ROUND(sal + IFNULL(comm, 0), 2)) AS `max sal of salesman`
    FROM
        emp
    WHERE
        job = 'SALESMAN') AS `max sal of salesman tbl` ON (`max sal of salesman tbl`.`max sal of salesman` = ROUND(e.sal + IFNULL(e.comm, 0), 2))
WHERE
    e.job = 'SALESMAN';

SELECT 
    e.deptno,
    e.ename,
    e.job,
    e.sal,
    ROUND(e.sal + IFNULL(e.comm, 0), 2)
FROM
    emp AS e
WHERE
    2 = (SELECT 
            COUNT(DISTINCT ROUND(sal + IFNULL(comm, 0), 2))
        FROM
            emp
        WHERE
            ROUND(e.sal + IFNULL(e.comm, 0), 2) > ROUND(sal + IFNULL(comm, 0), 2));

SELECT 
    d1.deptno, AVG(IFNULL(e1.sal, 0.00))
FROM
    emp AS e1
        RIGHT JOIN
    dept AS d1 ON (e1.deptno = d1.deptno)
GROUP BY d1.deptno
HAVING AVG(IFNULL(e1.sal, 0.00)) < (SELECT 
        AVG(IFNULL(e.sal, 0.00))
    FROM
        emp AS e
            RIGHT JOIN
        dept AS d ON (e.deptno = d.deptno));

SELECT 
    e.ename, e.sal, m.ename, m.sal
FROM
    emp AS e
        INNER JOIN
    emp AS m ON (e.mgr = m.empno)
WHERE
    (e.sal > m.sal);

SELECT 
    *
FROM
    emp
WHERE
    deptno IN (SELECT 
            deptno
        FROM
            emp
        GROUP BY deptno
        HAVING ROUND(AVG(sal), 2) = (SELECT 
                ROUND(MAX(`avg sal deptwise tbl`.`avg sal deptwise`),
                            2)
            FROM
                (SELECT 
                    AVG(sal) AS `avg sal deptwise`
                FROM
                    emp
                GROUP BY deptno) AS `avg sal deptwise tbl`));
                
SELECT 
    empno, sal, IFNULL(comm, 0.00)
FROM
    emp;

SELECT 
    *
FROM
    emp
ORDER BY sal ASC;

SELECT 
    deptno, empno, ename
FROM
    emp
ORDER BY job ASC , empno DESC , ename DESC;

SELECT DISTINCT
    *
FROM
    dept
WHERE
    deptno IN (SELECT 
            deptno
        FROM
            emp);

SELECT 
    deptno, job
FROM
    emp
GROUP BY deptno , job
ORDER BY deptno , job;

SELECT 
    *
FROM
    emp
WHERE
    ename = 'BLAKE';

SELECT 
    *
FROM
    emp
WHERE
    job = 'CLERK';

SELECT 
    *
FROM
    emp
WHERE
    hiredate = STR_TO_DATE('01-MAY-81', '%d-%b-%y');

SELECT 
    empno, ename, sal, deptno
FROM
    emp
WHERE
    deptno = 10
ORDER BY sal ASC;

SELECT 
    *
FROM
    emp
WHERE
    sal < 3500;

SELECT 
    empno, ename, sal
FROM
    emp
WHERE
    hiredate < STR_TO_DATE('1 apr 81', '%d %b %y');

SELECT 
    *
FROM
    emp
WHERE
    sal * 12 < 25000
ORDER BY sal ASC;

SELECT 
    empno, ename, sal * 12, sal / 30
FROM
    emp
WHERE
    job = 'SALESMAN'
ORDER BY sal * 12 ASC;

SELECT 
    empno,
    ename,
    hiredate,
    CURDATE(),
    TIMESTAMPDIFF(MONTH,
        hiredate,
        CURDATE()) AS `Experience`
FROM
    emp
ORDER BY TIMESTAMPDIFF(MONTH,
    hiredate,
    CURDATE()) ASC;

SELECT 
    *
FROM
    emp
WHERE
    TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 10;

-- =========> 181

SELECT 
    *
FROM
    emp
WHERE
    job = 'MANAGER'
        OR empno IN (SELECT 
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL);

SELECT 
    *
FROM
    emp
WHERE
    job IN ('CLERK' , 'MANAGER');

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%e %b %y') IN ('1 MAY 81' , '17 nov 81', '30 dec 81');

SELECT 
    *
FROM
    emp
WHERE
    YEAR(hiredate) = '1981';

SELECT 
    *
FROM
    emp
WHERE
    sal * 12 BETWEEN 23000 AND 40000;

SELECT 
    *
FROM
    emp
WHERE
    mgr IN (7369 , 7890, 7654, 7900);

SELECT 
    *
FROM
    emp
WHERE
    QUARTER(hiredate) IN (3 , 4)
        AND DATE_FORMAT(hiredate, '%y') = '82';

SELECT 
    *
FROM
    emp
WHERE
    CHARACTER_LENGTH(ename) = 4;

SELECT 
    ename
FROM
    emp
WHERE
    ename RLIKE '^M.{4}$';

SELECT 
    *
FROM
    emp
WHERE
    ename RLIKE '^.{4}H$';

SELECT 
    ename
FROM
    emp
WHERE
    ename LIKE 'M%';

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%y') = '81';

SELECT 
    *
FROM
    emp
WHERE
    ROUND(sal, 0) RLIKE '00$';

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%b') = 'Jan';

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%M') RLIKE 'a';

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%M') RLIKE '^.a';

SELECT 
    *
FROM
    emp
WHERE
    CHARACTER_LENGTH(ROUND(sal, 0)) = 4;

SELECT 
    *
FROM
    emp
WHERE
    CONCAT(DATE_FORMAT(hiredate, '%y'), 's') = '80s';

SELECT 
    *
FROM
    emp
WHERE
    job = 'CLERK'
        AND TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 8;

SELECT 
    *
FROM
    emp
WHERE
    ((job = 'MANAGER')
        OR (empno IN (SELECT 
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL)))
        AND (deptno IN (10 , 20));

SELECT 
    *
FROM
    emp
WHERE
    DATE_FORMAT(hiredate, '%b') = 'Jan'
        AND (sal BETWEEN 1500 AND 4000);

SELECT DISTINCT
    job
FROM
    emp
WHERE
    deptno IN (20 , 30)
ORDER BY job DESC;

-- ========>204 SELECT *, TIMESTAMPDIFF(MONTH, hiredate, CURDATE()) AS `Experience In Months` FROM emp WHERE mgr RLIKE '^7.*[^9]' AND DATE_FORMAT(hiredate, '%y') < 83;
-- ====> 204>   SELECT empno, ename, TIMESTAMPDIFF('month', hiredate, NOW()) AS 'Exp' FROM emp WHERE mgr IN (SELECT empno FROM emp WHERE empno IN (SELECT mgr FROM emp WHERE mgr IS NOT NULL) AND empno RLIKE '^7.*[^9]' AND DATE_FORMAT(hiredate, '%Y') < 1983);

SELECT 
    *
FROM
    emp
WHERE
    (job IN ('MANAGER' , 'ANALYST'))
        AND (sal BETWEEN 2000 AND 5000)
        AND (IFNULL(comm, 0.00) = 0.00);

SELECT 
    empno, ename, sal, job
FROM
    emp
WHERE
    (sal * 12 < 34000)
        AND (IFNULL(comm, 0.00) <> 0.00)
        AND (IFNULL(comm, 0.00) <= sal)
        AND (job = 'SALESMAN')
        AND (deptno = 30);

SELECT 
    *
FROM
    emp
WHERE
    (deptno IN (10 , 20))
        AND (job IN ('CLERK' , 'ANALYST'))
        AND (CHARACTER_LENGTH(ROUND(sal, 0)) IN (3 , 4))
        AND (TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 8)
        AND (DATE_FORMAT(hiredate, '%b') NOT IN ('mar' , 'apr', 'sep'))
        AND (mgr IS NOT NULL)
        AND (RIGHT(empno, 2) NOT IN (88 , 56));

-- =====> 208 SELECT emono, ename, sal, job, TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) AS `Experience` WHERE (deptno IN (10, 20)) AND (TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) BETWEEN 6 AND 10) AND (IFNULL(comm, 0.00) = 0.00) AND ()

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno)
WHERE
    (d.loc = 'CHICAGO');

SELECT 
    e.empno, e.ename, e.deptno, d.loc
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno);

SELECT 
    e.empno, e.ename, d.loc, d.dname
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno)
WHERE
    (d.deptno IN (10 , 20));

SELECT 
    e.empno, e.ename, e.sal, d.loc
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno)
WHERE
    (d.loc IN ('CHICAGO' , 'DALLAS'))
        AND (TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 6);

SELECT 
    e.empno, e.ename, e.deptno, d.loc
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno)
WHERE
    (d.loc IN ('NEW YORK' , 'DALLAS'))
        AND (e.sal BETWEEN 2000 AND 5000)
        AND (DATE_FORMAT(hiredate, '%y') = 81);

SELECT 
    e.empno, e.ename, e.sal, r.grade
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal);

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    salgrade AS r
        INNER JOIN
    dept AS d ON ((e.sal BETWEEN r.losal AND r.hisal)
        AND (e.deptno = d.deptno))
WHERE
    (r.grade IN (2 , 3))
        AND (d.loc = 'CHICAGO');

SELECT 
    e.*, d.loc, r.grade
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.sal BETWEEN r.losal AND r.hisal)
        AND (e.deptno = d.deptno))
WHERE
    ((d.dname = 'ACCOUNTING')
        OR (d.loc IN ('DALLAS' , 'CHICAGO')))
        AND (r.grade BETWEEN 3 AND 5)
        AND (TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 6);

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.sal BETWEEN r.losal AND r.hisal)
        AND (e.deptno = d.deptno))
WHERE
    (d.dname IN ('RESEARCH' , 'OPERATION'))
        AND (r.grade = 3)
        AND (YEAR(e.hiredate) > 1987)
        AND (e.ename NOT IN ('MILLER' , 'ALLEN'));

SELECT 
    *
FROM
    emp
WHERE
    job = (SELECT 
            job
        FROM
            emp
        WHERE
            ename = 'SMITH');

SELECT 
    *
FROM
    emp
WHERE
    hiredate < (SELECT 
            hiredate
        FROM
            emp
        WHERE
            ename = 'MILLER');

SELECT 
    *
FROM
    emp
WHERE
    (job = (SELECT 
            job
        FROM
            emp
        WHERE
            ename = 'ALLEN'))
        OR (sal > (SELECT 
            sal
        FROM
            emp
        WHERE
            ename = 'ALLEN'));

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    emp AS m ON (e.mgr = m.empno)
WHERE
    (e.hiredate < m.hiredate);

SELECT 
    *
FROM
    emp
WHERE
    sal > (SELECT 
            sal
        FROM
            emp
        WHERE
            ename = 'BLAKE');

SELECT 
    *
FROM
    emp
WHERE
    (deptno = 10)
        AND (sal > (SELECT 
            sal
        FROM
            emp
        WHERE
            ename = 'ALLEN'));

SELECT 
    *
FROM
    emp
WHERE
    (hiredate BETWEEN (SELECT 
            hiredate
        FROM
            emp
        WHERE
            ename = 'SMITH') AND (SELECT 
            hiredate
        FROM
            emp
        WHERE
            ename = 'KING'))
        AND (empno IN (SELECT 
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL));

SELECT 
    e.empno, e.ename, e.sal, d.dname, d.loc
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno)
WHERE
    e.deptno = (SELECT 
            deptno
        FROM
            emp
        WHERE
            ename = 'KING');

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
WHERE
    (r.grade > (SELECT 
            r.grade
        FROM
            emp AS e
                INNER JOIN
            salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
        WHERE
            (e.ename = 'MILLER')));

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    dept AS d
        INNER JOIN
    salgrade AS r ON ((e.sal BETWEEN r.losal AND r.hisal)
        AND (e.deptno = d.deptno))
WHERE
    (d.loc IN ('DALLAS' , 'CHICAGO'))
        AND ((r.grade = (SELECT 
            r.grade
        FROM
            emp AS e
                INNER JOIN
            salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
        WHERE
            (e.ename = 'ADAM')))
        OR (TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > (SELECT 
            TIMESTAMPDIFF(YEAR, hiredate, CURDATE())
        FROM
            emp
        WHERE
            ename = 'SMITH')));

SELECT 
    *
FROM
    emp
WHERE
    sal IN (SELECT 
            sal
        FROM
            emp
        WHERE
            ename IN ('FORD' , 'BLAKE'));

SELECT 
    e.*
FROM
    emp AS e
WHERE
    sal = ANY (SELECT 
            sal
        FROM
            emp
        WHERE
            e.empno <> empno);

SELECT 
    sal
FROM
    emp
WHERE
    job = 'CLERK';

SELECT 
    *
FROM
    emp
WHERE
    (empno IN (SELECT 
            mgr
        FROM
            emp
        WHERE
            mgr IS NOT NULL))
        AND (DATE_FORMAT(hiredate, '%y') < 82);

SELECT 
    e.empno,
    e.ename,
    FORMAT((e.sal + IFNULL(e.comm, 0.00)),
        2)
FROM
    emp AS e
        INNER JOIN
    dept AS d ON (e.deptno = d.deptno)
WHERE
    (d.dname = 'SALES')
        AND (e.job = 'SALESMAN');

SELECT 
    *
FROM
    emp AS e
        INNER JOIN
    salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
        AND (r.grade = 4);

SELECT 
    FORMAT(sal, 2)
FROM
    emp;

SELECT 
    *
FROM
    emp
WHERE
    sal = (SELECT 
            MAX(sal)
        FROM
            emp);

SELECT 
    *
FROM
    emp
WHERE
    hiredate = (SELECT 
            MAX(hiredate)
        FROM
            emp
        WHERE
            deptno = 30)
        AND deptno = 30;

SELECT 
    *
FROM
    emp AS e1
        INNER JOIN
    dept AS d1 ON (e1.deptno = d1.deptno)
WHERE
    (d1.loc = 'CHICAGO')
        AND (e1.hiredate < (SELECT 
            MAX(hiredate)
        FROM
            emp AS e
                INNER JOIN
            salgrade AS r ON (e.sal BETWEEN r.losal AND r.hisal)
        WHERE
            (r.grade = 2)));

SELECT 
    e.*
FROM
    emp AS e
        INNER JOIN
    (SELECT 
        mgr AS `Manager`, MAX(sal) AS `Maximum Salary`
    FROM
        emp
    WHERE
        mgr = (SELECT 
                empno
            FROM
                emp
            WHERE
                ename = 'KING')) AS `Maximum Salary Data` ON (`Maximum Salary Data`.`Maximum Salary` = e.sal)
WHERE
    (`Maximum Salary Data`.`Manager` = e.mgr);