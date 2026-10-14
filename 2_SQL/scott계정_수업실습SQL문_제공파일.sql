
--  SQL문 주석문
-- MySQL SQL 문서: https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/
-- ////////////////////////////////////////////////////
-- /////// SELECT 문 실습//////
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/select.html
-- 1. 테이블내의 모든 데이터 보기

 use testdb;

 SELECT * FROM dept;
 
 SELECT * 
 FROM dept;
 
select * 
from dept;

select * 
from emp
limit 3;

SELECT *
FROM emp
limit  0 , 5;  -- 0 부터 5개 

-- 2. 특정 컬럼 데이터 보기

SELECT empno, ename, job, hiredate
FROM emp;
 
 SELECT ename, empno,  job, hiredate,  sal+10
 FROM emp;


-- 3. 연산 가능  ( +, - , *, /, %(나머지))

SELECT empno, ename,   sal,  sal + 10, sal-10, sal*1.1 , sal / 3,  sal % 3,  mod(sal, 3) 
FROM emp;

 
 -- 4. 별칭
 -- 컬럼헤더값을 별칭으로 출력
 -- 문법:  표현식 as  별칭,    as 생략 가능(권장안함)
 -- 필요시  "별칭" 사용

SELECT empno AS "사원 번호" , ename AS 성명, sal 급여 
FROM emp;

SELECT empno AS "사 번", ename AS "성명",  sal "급여" , sal * 12  as "연봉"
FROM emp;

-- 5.  null 값

SELECT empno, ename, sal, comm, comm + 10, (sal * 12) + comm as "연봉" 
FROM emp;


SELECT empno, ename,   sal,  comm,  (sal * 12) + comm as "연봉",  (sal*12) + ifnull(comm, 0) as "연봉" 
FROM emp;


-- 6. 중복제거 

SELECT job
FROM emp;

SELECT distinct job
FROM emp;
 
-- ////////////////////////////////////////////////////
-- /////// WHERE  실습//////
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/non-typed-operators.html

SELECT empno, ename, job, deptno
FROM emp
WHERE deptno = 30;

-- 1) 비교연산자 ( =, !=, >, >= , <, <= )

SELECT empno, ename, sal
FROM emp
WHERE sal <= 1000; 

SELECT empno, ename, job, deptno
FROM emp
WHERE job = 'salesman';

SELECT empno, ename, job, deptno , sal, hiredate 
FROM emp 
WHERE hiredate = '1980-12-17';

 -- 2) 비교연산자  : Between A and B , ISNULL, IN 연산자

 SELECT empno, ename, job, deptno
FROM emp
WHERE sal BETWEEN 800 AND 2000;

 SELECT empno, ename, sal, comm
FROM emp
WHERE comm IS NULL;

SELECT empno, ename, sal
FROM emp
WHERE empno IN (7369,7566,7698);

 
 -- 3) like 연산자 :   % ,  _  패턴문자(와일드 카드문자)와 같이 사용

SELECT empno, ename, sal
FROM emp
WHERE ename LIKE 'A%';

 SELECT empno, ename, sal
FROM emp
WHERE ename LIKE '%T%';

SELECT empno, ename, sal
FROM emp
WHERE ename LIKE '_L%';


SELECT empno, ename, sal
FROM emp
WHERE ename LIKE '%E_%' ESCAPE 'E';

  
-- 4) 논리 연산자;   and  , or  , not 

SELECT empno, ename, job, deptno, hiredate
FROM emp
WHERE job = 'salesman' AND sal >= 1500;

SELECT empno, ename, job, deptno, hiredate
FROM emp
WHERE job = 'salesman' OR sal >= 1500;

SELECT empno, ename, sal, comm
FROM emp
WHERE comm IS NOT NULL;

-- 5)  부정 연산자

SELECT empno, ename, job, deptno
FROM emp
WHERE sal NOT BETWEEN 800 AND 2000;

SELECT empno, ename, sal
FROM emp
WHERE ename NOT LIKE 'A%';

SELECT empno, ename, sal
FROM emp
WHERE empno NOT IN (7369,7566,7698);

-- ////////////////////////////////////////////////////
-- /////// 정렬  실습//////

 -- 11. 정렬

SELECT empno, ename,  hiredate
FROM emp
ORDER BY hiredate;

 SELECT empno, ename,  hiredate
FROM emp
ORDER BY hiredate DESC ;

SELECT empno, ename,  sal * 12 AS Annual
FROM emp
ORDER BY Annual;

 SELECT empno, ename,  sal * 12 AS Annual
FROM emp
ORDER BY 3;
 
 -- 다중 정렬
SELECT empno, ename,  sal * 12 AS Annual
FROM emp
ORDER BY Annual, empno DESC;

 SELECT empno, ename,  sal * 12 AS Annual
FROM emp
ORDER BY 3, 1 DESC;

 -- ////////////////////////////////////////////////////
-- /////// 단일함수  실습//////
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/string-functions.html

 -- 1. 단일행함수 - 문자 데이터

SELECT empno, lower(ename),  LOWER('HeLLO')
FROM emp;

 
SELECT empno, UPPER(ename),  UPPER('HeLLO')
FROM emp;

 
SELECT empno, CONCAT(ename, ' ', sal)
FROM emp;

SELECT empno, CONCAT_WS(‘/’, ename, sal)
FROM emp;


SELECT empno, LPAD(ename,10, '*'),  LPAD(sal, 10, '*')
FROM emp;

SELECT empno, RPAD(ename,10, '*'),  RPAD(sal, 10, '*')
FROM emp;

SELECT LEFT('hello', 2);      

SELECT RIGHT('hello', 2);   

SELECT empno, ename, SUBSTR(ename,1,2),  SUBSTR(ename,3), SUBSTR(ename, -1)
FROM emp;

 
SELECT SUBSTRING_INDEX('www.mysql.com', '.', 2); 

 
--  length 는 byte 기준으로 길이를 반환 ( 한글은 글자당 3byte 처리)

SELECT empno, ename, LENGTH(ename), LENGTH('홍길동') 
FROM emp;


-- char_length 는 실제 글자수 길이를 반환 ( 한글/영문 모두 한글자로 처리 )

SELECT empno, ename, CHAR_LENGTH(ename)
FROM emp;

SELECT LENGTH('홍길동'), CHAR_LENGTH('홍길동'); 

SELECT empno, ename, sal, REPLACE(sal, '0','o')
FROM emp;

SELECT INSERT('Hello World', 7, 5, 'MySQL');

SELECT INSTR('foobarbar', 'bar'), INSTR('foobarbar', 'xbar');

SELECT LTRIM('     bar     '), LENGTH(LTRIM('     bar     '));

SELECT RTRIM('     bar     '), LENGTH(RTRIM('     bar     '));

SELECT TRIM('     bar     '),
       TRIM(BOTH FROM '     bar     '),
       TRIM(LEADING FROM '     bar     '),
       TRIM(TRAILING FROM '     bar     ');

SELECT TRIM('xxxbarxxx'),
       TRIM(BOTH 'x' FROM 'xxxbarxxx'),
       TRIM(LEADING 'x' FROM 'xxxbarxxx'),
       TRIM(TRAILING 'x' FROM 'xxxbarxxx');

SELECT ename, REVERSE(ename)       
FROM emp;

SELECT FORMAT(9876543.2145, 2);

-- 정규표현식

SELECT ename, REGEXP_LIKE(ename, '^M')
FROM emp;

SELECT REGEXP_REPLACE('a1b2', '[0-9]', '');

SELECT REGEXP_REPLACE('a1b2', '[0-9]', '' ,1 ,2);

SELECT REGEXP_SUBSTR('a1987b2c3', '[0-9]');               -- 1
SELECT REGEXP_SUBSTR('a1987b2765c3', '[0-9]+');           -- 1987
SELECT REGEXP_SUBSTR('a1987b2765c3', '[0-9]+', 1, 2);     -- 2765
SELECT REGEXP_SUBSTR('123Hello456', '[A-Za-z]+');         -- Hello

 -- 1. 단일행함수 - 수치 데이터
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/numeric-functions.html


SELECT ROUND(45.678), ROUND(45.678, 2) , ROUND(45.678, -1);

SELECT TRUNCATE(45.678, 0), TRUNCATE(45.678, 2) , TRUNCATE(45.678, -1); 

SELECT CEIL(45.178), CEIL(-45.178);

SELECT FLOOR(45.178), FLOOR(-45.178);

SELECT MOD(10, 3), 10%3 ;

SELECT SIGN(-1.200), SIGN(34.3), SIGN(0);

SELECT RAND();			   --  0 <= R < 1
SELECT FLOOR(7 + (RAND() * 5));  --  7 <= R < 12
SELECT FLOOR(1 + RAND() * 10);   --  1 <= R < 11 

 -- 1. 단일행함수 - 날짜 데이터
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/date-and-time-functions.html

SELECT SYSDATE(), NOW();

SELECT CURDATE(),  CURRENT_DATE(),  CURRENT_DATE;

SELECT CURTIME(),  CURRENT_TIME(),  CURRENT_TIME;

SELECT YEAR('2026-10-11');
SELECT MONTH('2026-10-11');
SELECT DAY('2026-10-11');
SELECT HOUR('14:35:20');
SELECT MINUTE('14:35:20');
SELECT SECOND('14:35:20');

SELECT ADDDATE('2008-01-02', 30), ADDDATE('2008-01-02’, -30);

SELECT DATE_ADD('2008-01-02', INTERVAL 1 DAY) as A1,
       DATE_ADD('2008-01-02', INTERVAL 1 MONTH) as A2,
       DATE_ADD('2008-01-02', INTERVAL 1 YEAR) as A3,
       NOW() as A4,
       DATE_ADD(NOW(), INTERVAL 10 MINUTE) as A5,
       DATE_ADD(NOW(), INTERVAL 2 HOUR) as  A6;

SELECT DATE_SUB('2008-01-02', INTERVAL 1 DAY) as B1,
       DATE_SUB('2008-01-02', INTERVAL 1 MONTH) as B2,
       DATE_SUB('2008-01-02', INTERVAL 1 YEAR) as B3,
       NOW() as B4,
       DATE_SUB(NOW(), INTERVAL 10 MINUTE) as B5,
       DATE_SUB(NOW(), INTERVAL 2 HOUR) as B6;


SELECT DATEDIFF('2023-01-04', '2022-01-04'); 

SELECT TIMESTAMPDIFF(HOUR, '2020-3-1', '2020-3-3') AS C1,
       TIMESTAMPDIFF(DAY, '2020-3-1', '2020-3-3') AS C2,
       TIMESTAMPDIFF(MONTH, '2020-2-1', '2020-6-3') AS C3,
       TIMESTAMPDIFF(YEAR, '2020-3-1', '2022-3-3') AS C4;

SELECT LAST_DAY('2003-02-05'), LAST_DAY(NOW());

SELECT NOW(),
       EXTRACT(SECOND FROM NOW()),
       EXTRACT(MINUTE FROM NOW()),
       EXTRACT(HOUR FROM NOW()),
       EXTRACT(DAY FROM NOW()),
       EXTRACT(MONTH FROM NOW()),
       EXTRACT(YEAR FROM NOW()),
       EXTRACT(YEAR_MONTH FROM NOW());

SELECT NOW(),
       DATE_FORMAT(NOW(),'%Y%m%d'),
       DATE_FORMAT(NOW(),'%Y/%m/%d'),
       DATE_FORMAT(NOW(),'%Y년%m월 %d일'),
       DATE_FORMAT(NOW(),'%H:%i:%S'),
       DATE_FORMAT(NOW(),'%Y');

SELECT STR_TO_DATE('2020-03-04','%Y-%m-%d'),
       STR_TO_DATE('01,5,2013','%d,%m,%Y'),
       STR_TO_DATE('2020년03월05일','%Y년%m월%d일’),
       STR_TO_DATE('2020-03-04 12:23:32','%Y-%m-%d %H:%i:%S');

 -- 1. 단일행함수 - 조건함수

SELECT empno, ename, sal, job,
       CASE job WHEN 'ANALYST' THEN sal * 1.1
                WHEN 'CLERK' THEN sal * 1.2
                WHEN 'MANAGER' THEN sal * 1.3
                WHEN 'PRESIDENT' THEN sal * 1.4
                WHEN 'SALESMAN' THEN sal * 1.5
                ELSE sal 
       END AS 실수령
FROM emp;

SELECT empno, ename, sal, 
       CASE     WHEN sal > 3500 THEN '이사급'
                WHEN sal > 2500 THEN '과장급'
                ELSE '사원급’ 
       END AS 직급연봉
FROM emp;

SELECT sal, IF(sal > 2500 , '과장이상급', '사원급')
FROM emp;


 -- 1. 단일행함수 - 형변환 함수

select '10',        
       cast('123' as SIGNED ),        
       cast(100 as char ),        
       cast('12.34' as float ),        
       cast('24-03-29' as DATE ),        
       cast('240329' as DATE ),        
       cast('24-03-29 03:23:34' as DATETIME );



 -- ////////////////////////////////////////////////////
-- /////// 그룹함수  실습//////
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/aggregate-functions.html


SELECT AVG(sal), MAX(sal), MIN(sal), SUM(sal)
FROM emp
WHERE job = 'SALESMAN';

SELECT COUNT(*), COUNT(comm),
       AVG(comm), AVG(IFNULL(comm,0)),
       COUNT(deptno), COUNT(DISTINCT deptno)
FROM emp;


SELECT deptno, group_concat(ename) 
FROM emp 
group by deptno; 

SELECT deptno, group_concat(ename ORDER BY ename DESC) 
FROM emp 
group by deptno; 

SELECT deptno, group_concat(ename ORDER BY ename DESC SEPARATOR '-') FROM emp 
group by deptno;


-- group by 문법

SELECT deptno, COUNT(*), ROUND(AVG(sal)), MIN(sal), MAX(sal), SUM(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, COUNT(*), ROUND(AVG(sal)), MIN(sal), MAX(sal), SUM(sal)
FROM emp
GROUP BY deptno
ORDER BY SUM(sal) DESC;

SELECT deptno, job, COUNT(*), ROUND(AVG(sal)), SUM(sal)
FROM emp
GROUP BY deptno,job
ORDER BY 1;

-- having 문법

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 7000;

SELECT deptno, SUM(sal)
FROM emp
WHERE sal > 1500
GROUP BY deptno
HAVING SUM(sal) > 7000;

SELECT deptno, ROUND(AVG(sal)), SUM(sal)
FROM emp
GROUP BY deptno
HAVING MAX(sal) > 2900;


SELECT job, ROUND(AVG(sal)), SUM(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) > 2000;

SELECT job, SUM(sal)
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY SUM(sal) DESC;


 -- ////////////////////////////////////////////////////
-- /////// 조인(JOIN)  실습//////
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/join.html


SELECT empno, ename, dname
FROM emp CROSS JOIN dept;

SELECT empno, ename, dname
FROM emp NATURAL JOIN dept;

SELECT empno, ename, dname, deptno
FROM emp e NATURAL JOIN dept d;

SELECT e.empno, e.ename, d.dname, e.deptno
FROM emp e NATURAL JOIN dept d;

-- using 절 
SELECT empno, ename, dname
FROM emp JOIN dept USING(deptno);

SELECT e.empno, e.ename, d.dname, e.deptno
FROM emp e JOIN dept d USING(deptno);

-- # 에러 
SELECT e.empno, e.ename, d.dname, e.deptno
FROM emp e JOIN dept d USING(e.deptno);

-- ON 절
SELECT empno, ename, dname, loc , e.deptno
FROM emp e JOIN dept d ON e.deptno = d.deptno;

SELECT empno, ename, dname, loc , sal,  e.deptno
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE sal > 2500;

SELECT empno, ename, dname,  sal, grade
FROM emp e JOIN dept d ON e.deptno = d.deptno
           JOIN salgrade s ON e.sal BETWEEN s.LOSAL AND s.HISAL;


-- self 조인
SELECT e.ename 사원, m.ename 관리자
FROM emp e JOIN emp m ON e.mgr = m.empno;

-- outer 조인

SELECT empno, ename, dname, d.deptno
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;

--  # 신입사원 추가
INSERT INTO emp VALUES ( 9000, 'TEST','SALESMAN', 7499, '90/01/01', 600, NULL, NULL );

SELECT empno, ename, dname, d.deptno
FROM emp e LEFT OUTER JOIN dept d ON e.deptno = d.deptno;



 -- ////////////////////////////////////////////////////
-- /////// 서브쿼리(Subquery)  실습//////
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/subqueries.html

SELECT empno, ename, job, sal
FROM emp
WHERE sal > ( SELECT sal 
              FROM emp 
              WHERE ename = 'scott');


SELECT empno, ename, job, sal
FROM emp
WHERE job = ( SELECT job
              FROM emp
              WHERE empno = 7521 )
AND
      sal > ( SELECT sal
              FROM emp
              WHERE empno = 7934 );


SELECT empno, ename, job, sal, deptno
FROM emp
WHERE sal < (SELECT AVG(sal)
             FROM emp );


SELECT deptno, MIN(sal)
FROM emp 
GROUP BY deptno
HAVING MIN(sal) > ( SELECT MIN(sal)
                    FROM emp
                    WHERE deptno = 20 );


-- # 복수행 서브쿼리

-- # IN 연산자
SELECT empno, ename, job, hiredate, sal, deptno
FROM emp
WHERE sal IN ( SELECT MIN(sal)
               FROM emp
               GROUP BY job );


-- #  ALL, ANY 연산자
-- #가.  < all  :  서브쿼리의 최소값 보다 작은 값을 반환함.
              :  min(sal) 로도 구현 가능

SELECT empno, ename, sal
FROm emp
WHERE  sal < ALL ( SELECT sal
                        FROM emp
			WHERE job = 'MANAGER');

SELECT empno, ename, sal
FROm emp
WHERE  sal < ( SELECT min(sal)
                        FROM emp
			WHERE job = 'MANAGER');

-- #  나. > all :   서브쿼리의 최대값 보다  큰  값을 반환함.
            :   max(sal) 으로도 구현 가능

SELECT empno, ename, sal
FROm emp
WHERE  sal > ALL ( SELECT sal
                        FROM emp
			WHERE job = 'MANAGER');


SELECT empno, ename, sal
FROm emp
WHERE  sal > ( SELECT max(sal)
                        FROM emp
			WHERE job = 'MANAGER');



-- #다.  < any  : 서브쿼리의 최대값 보다 작은 값을 반환함.
              :  max(sal)

SELECT empno, ename, sal
FROm emp
WHERE  sal < any ( SELECT sal
                        FROM emp
			WHERE job = 'MANAGER');


SELECT empno, ename, sal
FROm emp
WHERE  sal < ( SELECT max(sal)
                        FROM emp
			WHERE job = 'MANAGER');

       

 -- #라.   > any:  서브쿼리의 최소값 보다 큰값을 반환함.
              :  min(sal)

  

SELECT empno, ename, sal
FROm emp
WHERE  sal > any ( SELECT sal
                        FROM emp
			WHERE job = 'MANAGER');


SELECT empno, ename, sal
FROm emp
WHERE  sal > ( SELECT min(sal)
                        FROM emp
			WHERE job = 'MANAGER');


    > all:  최대값보다 큰 값 반환    ( > (select max(sal) )
    < all:  최소값보다 작은 값 반환  ( < (select min(sal) )
    > any:  최소값보다 큰 값 반환    ( > (select min(sal) )
    < any:  최대값보다 작은 값 반환   ( > (select max(sal) )


-- #  EXISTS 연산자

SELECT empno, ename, job, hiredate, sal, deptno
FROM emp
WHERE EXISTS ( SELECT empno
               FROM emp
               WHERE comm IS NOT NULL );


-- # 다중컬럼 
SELECT deptno, empno, ename,  sal
FROM emp
WHERE (deptno, sal ) IN ( SELECT deptno, MAX(sal)
                          FROM emp
                          GROUP BY deptno);


-- # 스칼라 서브쿼리
SELECT ename, sal,       
      (SELECT ROUND(AVG(sal)) FROM emp) AS avg_salary 
FROM emp;

-- # 인라인 뷰 서브쿼리
SELECT e.deptno, total_sum, total_avg, cnt
FROM ( SELECT deptno, SUM(sal) total_sum, ROUND(AVG(sal)) total_avg,
              COUNT(*) cnt
       FROM emp
       GROUP BY deptno ) e JOIN dept d ON e.deptno = d.deptno;


select  e.deptno, sum(sal), ROUND(avg(sal)), count(*)
	from emp e join dept d on e.deptno = d.deptno  
	group by deptno;


 -- ////////////////////////////////////////////////////
-- ///////  DML  실습//////
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/sql-data-manipulation-statements.html
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/sql-transactional-statements.html

-- auto commit 확인
 show variables like 'autocommit%';
 
-- auto commit 비활성화
set autocommit=false;         

-- # INSERT 문
DESC dept; 

INSERT INTO dept (deptno, dname, loc )
VALUES (90, '인사과','서울');

INSERT INTO dept (deptno, dname ) # loc 컬럼에 null 저장
VALUES (91, '인사과');

INSERT INTO dept (loc, dname, deptno )
VALUES ('서울', '인사과', 80);

INSERT INTO dept 
VALUES (70, '인사과','서울');

-- # 다중행 저장 

-- # CTAS 이용한 테이블 생성
CREATE TABLE copy_emp
AS
SELECT empno, ename, sal FROM emp
WHERE 1=2;

INSERT INTO copy_emp (empno, ename, sal)
SELECT empno, ename, sal 
FROM emp;

INSERT INTO copy_emp (empno, ename, sal)
VALUES (71, '홍길동',800), (72, '이순신',900), (73, '유관순',950);


-- # UPDATE 문
UPDATE dept
SET dname ='경리과', loc='부산'
WHERE deptno = 90;

UPDATE emp
SET sal = 1000
ORDER BY sal DESC
LIMIT 2;

-- # DELETE 문

DELETE FROM dept
WHERE deptno = 90;

DELETE FROM copy_emp
WHERE sal = 3000
ORDER BY empno desc
LIMIT  1;

-- # MERGE 문 (UPSERT)
INSERT INTO dept (deptno, dname, loc )
VALUES (90, '인사과','서울’);

INSERT INTO dept (deptno, dname, loc )
VALUES (90, '인사과','서울') ON DUPLICATE KEY UPDATE loc='제주';


 -- ////////////////////////////////////////////////////
-- ///////  DDL  실습//////
-- https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/sql-data-definition-statements.html


CREATE TABLE IF NOT EXISTS  dept_2
( deptno INT,
  dname VARCHAR(10),
  loc VARCHAR(10) );

CREATE TABLE IF NOT EXISTS  dept_3
( deptno INT,
  dname VARCHAR(10),
  loc VARCHAR(10) DEFAULT '서울' );

CREATE TABLE IF NOT EXISTS board
( num INT PRIMARY KEY AUTO_INCREMENT,
  author VARCHAR(10) NOT NULL,
  title VARCHAR(20) NOT NULL,
  content VARCHAR(100) NOT NULL,
  writeday DATE DEFAULT (CURRENT_DATE),
  readcnt INT DEFAULT 0 );


-- # 제약조건 확인 

DESC information_schema.table_constraints;

SELECT * 
FROM information_schema.table_constraints
WHERE TABLE_NAME = 'EMP';

-- # 컬럼레벨
CREATE TABLE student
( no INT  PRIMARY KEY,
  name VARCHAR(10) UNIQUE ,
  address VARCHAR(10) NOT NULL,  # 컬럼레벨만 가능
  age INT CHECK( age IN ( 10,20,30 )));



-- # 테이블 레벨
CREATE TABLE student2
( no INT,
  name VARCHAR(10),
  address VARCHAR(10) NOT NULL,
  age INT ,
  CONSTRAINT  PRIMARY KEY(NO),
  CONSTRAINT  UNIQUE(NAME),
  CONSTRAINT  CHECK( age IN ( 10,20,30 ))); 

-- # FK 
CREATE TABLE MASTER1
( NO INT PRIMARY KEY ,
  NAME VARCHAR(10) NOT NULL );

CREATE TABLE SLAVE1
( num INT PRIMARY KEY,
  NO2 INT,
  CONSTRAINT FOREIGN KEY(NO2) REFERENCES master1(NO));


CREATE TABLE SLAVE2
( num INT PRIMARY KEY,
  NO INT,
  CONSTRAINT FOREIGN KEY(NO) REFERENCES master1(NO) ON DELETE CASCADE );

CREATE TABLE SLAVE3
( num INT PRIMARY KEY,
  NO INT,
  CONSTRAINT FOREIGN KEY(NO) REFERENCES master1(NO) ON DELETE SET NULL );

-- # 테이블 삭제
DROP TABLE IF EXISTS  SLAVE1; 
DROP TABLE IF EXISTS  SLAVE2, SLAVE3; 

-- # 테이블 절삭
TRUNCATE TABLE copy_emp;

-- # 테이블변경 ( 컬럼추가)
CREATE TABLE scott_t
( num INT,
  NAME VARCHAR(10) );

DESC scott_t;

ALTER TABLE scott_t
ADD ( address VARCHAR(30)); 


-- # 테이블변경 (컬럼변경)
ALTER TABLE scott_t
MODIFY address VARCHAR(5); 

ALTER TABLE scott_t
MODIFY address INT; 


-- # 테이블변경 (컬럼 이름 변경)
ALTER TABLE scott_t
RENAME COLUMN address TO addr;



-- # 테이블변경 (컬럼삭제)
ALTER TABLE scott_t
DROP address;

-- # 테이블변경 (제약조건 추가)
CREATE TABLE scott_t2
( num INT,
  NAME VARCHAR(10),
  age INT,
  address VARCHAR(20) );

ALTER TABLE scott_t2
ADD CONSTRAINT PRIMARY KEY(num);  

ALTER TABLE scott_t2
ADD CONSTRAINT UNIQUE(NAME);

ALTER TABLE scott_t2
ADD CONSTRAINT CHECK(age>20);

-- # NOT NULL은 modify 명령어 사용
ALTER TABLE scott_t2
MODIFY address VARCHAR(20) NOT NULL;


CREATE TABLE IF NOT EXISTS scott_t2_child
( no INT PRIMARY KEY,
  num INT );

ALTER TABLE scott_t2_child
ADD CONSTRAINT FOREIGN KEY(num) 
               REFERENCES scott_t2(num);



 
