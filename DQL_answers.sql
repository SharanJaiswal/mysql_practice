SELECT * FROM emp;
SELECT DISTINCT job FROM emp;
SELECT * FROM emp ORDER BY sal ASC;
SELECT * FROM emp ORDER BY deptno ASC, job DESC;
SELECT DISTINCT job FROM emp ORDER BY job DESC;
SELECT * FROM emp WHERE empno IN (SELECT mgr FROM emp);
SELECT * FROM emp WHERE YEAR(hiredate) < '1981';
SELECT empno, ename, sal, ROUND(sal/30, 2) AS `Daily Sal` FROM emp ORDER BY ROUND(sal*12, 2) ASC;
SELECT empno, ename, job, hiredate, CONCAT(TIMESTAMPDIFF(MONTH, hiredate, CURDATE()), " Months") AS `Experience` FROM emp WHERE empno IN (SELECT mgr FROM emp);
SELECT empno, ename, sal, CONCAT(TIMESTAMPDIFF(MONTH, hiredate, CURDATE()), " Months") AS `Experience` FROM emp WHERE mgr = 7369;
SELECT * FROM emp WHERE IFNULL(comm, 0) > sal;
SELECT * FROM emp WHERE QUARTER(hiredate) > 2 AND YEAR(hiredate)='1981' ORDER BY job DESC;
SELECT *, CONCAT(TIMESTAMPDIFF(MONTH, hiredate, CURDATE()), " Months") AS `Experience` FROM emp WHERE TRUNCATE(sal/30, 2) > 100;
SELECT * FROM emp WHERE job IN ('clerk', 'analyst') ORDER BY job DESC;
SELECT * FROM emp WHERE hiredate IN (STR_TO_DATE('1-MAY-81', '%d-%b-%y'), STR_TO_DATE('3-DEC-81', '%d-%b-%y'), STR_TO_DATE('17-DEC-81', '%d-%b-%y'), STR_TO_DATE('19-JAN-80', '%d-%b-%y')) ORDER BY TIMESTAMPDIFF(DAY, hiredate, CURDATE()) ASC;
SELECT * FROM emp WHERE deptno IN (10, 20);
SELECT * FROM emp WHERE YEAR(hiredate) = YEAR(STR_TO_DATE('81', '%y'));		-- STR_TO_DATE('81', '%y') gives '1981-00-00' as an output.
SELECT * FROM emp WHERE DATE_FORMAT(hiredate, '%b %Y') = 'Aug 1980';	-- STR_TO_DATE('Aug 1980', '%b %Y') cant be used as it gives '1980-08-00' as an output which can't get directly compared with the emp.hiredate, as their DAY part can't be '00'. You can use BETWEEN CLAUSE also, if it is required===> ...WHERE hiredate BETWEEN CAST('1980-08-01' AS DATE) AND LAST_DAY(STR_TO_DATE('Aug 1980', '%b %Y'));
SELECT * FROM emp WHERE sal*12 BETWEEN 22000 AND 45000;
SELECT ename FROM emp WHERE CHARACTER_LENGTH(ename) = 5;
SELECT ename FROM emp WHERE ename RLIKE '^S.{4}$';	-- Don't leave patter expression without $ at the end because it'll check for names for at least of length 5 which starts from S/s. We can also use {ename LIKE '%S' AND CHARACTER_LENGTH(ename)=5} | {ename LIKE 'S____'} operator.
SELECT * FROM emp WHERE ename RLIKE '^..r.$';
SELECT * FROM emp WHERE ename RLIKE '^S.{3}H$';
SELECT * FROM emp WHERE DATE_FORMAT(hiredate, '%M') = 'January';
SELECT * FROM emp WHERE DATE_FORMAT(hiredate, '%b') RLIKE '.a';
SELECT * FROM emp WHERE (CHARACTER_LENGTH(TRUNCATE(sal, 0)) = 4) AND NOT (TRUNCATE(sal, 0) MOD 10);		-- If sal is not truncated, then it'll also measure the length of the decimal point as well the 2 digits of decimal
SELECT * FROM emp WHERE ename RLIKE 'll';
SELECT * FROM emp WHERE CONCAT(DATE_FORMAT(hiredate, '%y'), 's') = '80s';
SELECT * FROM emp WHERE deptno <> 20; 	-- != or NOT IN (20) will also work fine.
SELECT * FROM emp WHERE job NOT IN ('PRESIDENT', 'MANAGER') ORDER BY sal ASC;
SELECT * FROM emp WHERE YEAR(hiredate) <> '1981';
SELECT * FROM emp WHERE empno RLIKE '^78';
SELECT CONCAT_WS(' ', e.ename, 'works for', m.ename) FROM emp AS e INNER JOIN emp AS m ON e.mgr = m.empno;
SELECT * FROM emp WHERE DATE_FORMAT(hiredate, '%M') <> 'March';
SELECT * FROM emp WHERE (deptno = 20) AND (job = 'clerk');
SELECT * FROM emp WHERE (deptno IN (30, 10)) AND YEAR(hiredate) = '1981';
SELECT * FROM emp WHERE ename = 'SMITH';
SELECT d.loc FROM emp AS e INNER JOIN dept AS d ON e.deptno = d.deptno WHERE e.ename = 'SMITH';
SELECT e.*, d.dname AS `DNAME`, d.loc AS `Loc` FROM emp AS e INNER JOIN dept AS d ON e.deptno = d.deptno WHERE d.dname IN ('ACCOUNTING', 'RESEARCH') ORDER BY d.deptno ASC;
SELECT e.empno, e.ename, e.sal, d.dname FROM emp AS e INNER JOIN dept AS d ON e.deptno = d.deptno WHERE( e.job IN ('MANAGER', 'ANALYST')) AND (d.loc IN ('NEW YORK', 'DALLAS')) AND (TIMESTAMPDIFF(YEAR, e.hiredate, CURDATE()) > 7) AND (IFNULL(e.comm, 0) = 0) ORDER BY d.loc;
SELECT e.empno, e.ename, e.sal, d.dname, d.loc, d.deptno, e.job FROM emp AS e INNER JOIN dept AS d ON e.deptno = d.deptno WHERE ((d.loc = 'CHICAGO') OR ((d.dname = 'ACCOUNTING') AND (e.sal*12 > 28000) AND (e.sal NOT IN (3000, 2800)))) AND (e.empno RLIKE '^..[78]') AND e.job <> 'MANAGER' ORDER BY d.deptno ASC, e.job DESC;
SELECT e.*, r.grade FROM emp AS e INNER JOIN salgrade AS r ON e.sal BETWEEN r.losal AND r.hisal ORDER BY r.grade ASC;
SELECT e.*, r.grade FROM emp AS e INNER JOIN salgrade AS r ON e.sal BETWEEN r.losal AND r.hisal WHERE truncate(r.grade, 0) IN (2, 3);
SELECT e.*, r.grade FROM emp AS e INNER JOIN salgrade AS r ON e.sal BETWEEN r.losal AND r.hisal WHERE (e.job IN ('Analyst', 'Manager')) AND (truncate(r.grade, 0) IN (4, 5));