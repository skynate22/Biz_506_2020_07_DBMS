-- 여기는 user1 사용자의 명령 공간입니다.
-- USER1은 DBA 권한을 부여받았으므로
-- Table 생성, CRUD 등의 명령을 사용할수 있다.
-- DB에 데이터를 저장하기
-- DB를 대상으로 업무를 수행할때 데이터가 있어야만 여러가지 일을 수행할수 있다.
-- CRUD 중에서 가장먼저 수행해야할 명령이 C (Create) 형 명령
-- DML CRUD Create는 DDL CREATE 명령과 구분을 해야한다.
-- DDL 의 CREATE : 생성이라는 개념이고 운영체제와 밀접한 관련이 있거나,
-- 물리적인 요소가 많다
-- CREATE TABLESPACE, 
-- CREATE USER 와 같이 저장공간 
-- CREATE USER 사용자 정도 이며 Scheama 등을
-- 생성하는 명령 절차
-- DML(Date Manuplation Lan, Data Management Lang.)에서 Create
-- 물리적 저장공간에 실제 발생된 Data를 추가 저장하기
-- 아직 저장되지 않은 논리적 개념의 데이터를 로컬스토리에 보관하는 개념
-- DML의 Create 형 명령 "INSERT"


-- RDBMS(Relationship Database Management System, 관계형데이터베이스 시스템)
-- 데이터를 추가하려면, 먼저 데이터 저장공간에 대한 정의를 수행해야 한다.
-- 데이터 저장공간을 논리적으로 Entity, 물리적으로 TABLE 이라고 한다.

-- TABLE : 표준 SQL(ANSI SQL)에서 데이터를 추가하는 저장공간
--      저장할 데이터의 각 필드(칼럼) 항목의 type 결정
--      (학생정보 : 학번, 이름, 학과, 전화번호, 주소, 나이)
--      저장할 데이터의 최대 길이(크기)를 결정
--      데이터의 Key라는 것을 지정


-- PRIMARY 데이터의 key 중에 가장 중요한 항목
-- 데이터를 조회할때 이 항목으로 조건을 부여하면 유일한 값이 추출되는 항목
-- PK는 절때!!!!! 중복값이 있어서는 안된다.
-- PK는절대 NULL값이 있어서는 안된다.


-- 학생 데이터를 저장하기 위해 테이블을 생성
-- Table 명명규칙 보통 tbl_ 접두사로 시작한다. snack case형식 이름 지정
CREATE TABLE tbl_student ( 
    st_num CHAR(5) PRIMARY KEY, 
    st_name VARCHAR2(20), 
    st_dept VARCHAR2(20), 
    st_grade NUMBER(1), 
    st_tel VARCHAR2(20), 
    st_addr VARCHAR2(125), 
    st_age NUMBER(3)
);

DROP TABLE tbl_student; 
--칼럼(Fieldl) 명명규칙 : 보통 table이름을 줄여서 접두사 시작
    -- snak case 형식 이름으로 지정
    -- CHAR, VARCHAR2 : 고정길이 문자열, 칼럼에 저장되는 데이터틔 길이가 모두 같은경우 
    -- 에 주로 사용된다.
    -- VARCHAR2 : 가변길이 문자열, 칼럼에 저장되는 데이터의 길이가 일정하지 않을때
    -- 저장되는 데이터가 설정한 크기보다 작으면 저장공간을 줄여서 저장
    -- 저장되는 데이터의 데이터가 설정한크기보다 크면 오류발생
  
    

-- DML 의 Create
INSERT INTO tbl_student  -- tbl_student 테이블에 데이터를 추가하겠다
(st_num, st_name, st_dept, st_grade, st_tel, st_addr, st_age) -- 칼럼들 나열
 VALUES
 ('10001','홍길동','무역학과',3,'010-111-1111','서울특별시',33); --데이터들

-- 데이터를 INSRT 할떄 혹시 실수로 PK 칼럼에 이미 저장된 데이터를 
-- 또 INSERT 하려고 하면 UNIQUE 오류가 발생하면서 데이터를 저장하지 않는다
-- 이로서 PK 칼럼에 값이 중복되는 것을 방지하여 데이터 무결성을 유지한다.
DROP TABLE tbl_student;
CREATE TABLE tbl_student(

        st_num	CHAR(5)  PRIMARY KEY,	
        st_name	VARCHAR2(20) NOT NULL,	
        st_dept	VARCHAR2(10),		
        st_grade NUMBER(1),		
        st_tel	VARCHAR2(20),		
        st_addr	VARCHAR2(125),		
        st_age	NUMBER(3)		
);

INSERT INTO tbl_student (st_num, st_name) VALUES ('10001', '홍길동');
INSERT INTO tbl_student (st_num, st_name) VALUES ('10002', '이몽룡');
INSERT INTO tbl_student (st_num, st_name) VALUES ('10003', '성춘향');
INSERT INTO tbl_student (st_num, st_name) VALUES ('10004', '장보고');
INSERT INTO tbl_student (st_num, st_name) VALUES ('10005', '임꺽정');
INSERT INTO tbl_student (st_num, st_name) VALUES ('10006', '장길산');

-- 추출하여 확인 : 조회(Retrive), 읽기(Read)
SELECT *
FROM tbl_student;
-- 두개의 칼럼을 나열했는데 VALUES를 1개만 지정하면 INSERT 오류 발생
INSERT INTO tbl_student (st_num, st_name) VALUES ('10007');
-- 두개의 칼럼을 나열했는데 VALUES에 3개의 데이터를 지정하면 INSERT 오류 발생
INSERT INTO tbl_student (st_num, st_name) VALUES ('10007','장길산',33);

-- 학번만 데이터를 지정하고 INSERT 수행
-- st_name 칼럼이 NOT NULL constraint 설정이 되어 있기 때문에
-- st_name 칼럼과 데이터는 반드시 지정해서 INSERT를 수행해야 한다.
INSERT INTO tbl_student (st_num) VALUES ('10007');

-- PK 칼럼과 NOT NULL 칼럼은 반드시 데이터를 지정해서 INSERT를 수행해야 한다.
INSERT INTO tbl_student (st_num, st_name) VALUES ('10007','이자홍');


SELECT * FROM tbl_student;

-- CR<U>D에서 Update
-- tbl_student table에 있는 모든데이터(모든 행, row, recored)의
-- set_dept 칼럼의 값을 컴공과로 변경해라
-- 데이터의 개수에 관계없이 명령이 수행되어 버린다.
-- 아래의 UPDATE 명령은 매우 위험하니깐 신중하게 사용되어야 한다.
UPDATE tbl_student
SET st_dept = '컴공과'; --원래있던 값이 무엇이던지 간에 SET 한값으로 모두변경해줘라 

-- UPDATE 명령은 특별한 경우가 아니면 항상 PK를 기준으로 하라
UPDATE tbl_student
SET st_dept = '무역과'
WHERE st_num = '10004';


-- 학생이름(st_name) 칼럼의 값이 성춘향인 모든 데이터를 찾아서 
-- 그 데이터들의 st_dept 칼럼 값을 음악과로 변경해라
-- 이 명령의 결과로 만약 성춘향 학생의 데이터가 1개밖에 없어서
-- 원하는 결과를 얻었더라도, 가급적 사용하지 말아야 하는 명령이다.
-- 어떤 이유로 SELECT 문을 수행했을때 성춘향 데이터가 1개밖에 보이지 않았다 하더라도
-- 만약에 하나 감춰진(보이지 않은) 영역에 성춘향 데이터가 또 존재를 한다면
-- 이 명령을 수행하는 순간 이 table의 데이터는 무결성을 잃게 된다.
UPDATE tbl_student
SET st_dept = '음악과'
WHERE st_name = '성춘향';

--학번이 10004, 10007, 10001 인 학생의 학과를 물리학 으로 변경하고 싶을때
--PK를 기준으로 가능하면 1번에 1개씩 데이터를 변경하는 명령을 수행하는 것이 좋다.
UPDATE tbl_student
SET st_dept = '물리학'
WHERE st_num = '10004';

UPDATE tbl_student
SET st_dept = '물리학'
WHERE st_num = '10007';

UPDATE tbl_student
SET st_dept = '물리학'
WHERE st_num = '10001';

-- 학번이 10002, 10003, 10005, 10006 인 학생의 학과를 화학과로 변경하고싶다.
-- 여러번의 명령 수행하지 않고 변경할수 있는 방볍
UPDATE tbl_student
SET st_dept = '화학과'
WHERE st_num = '10002'OR
    st_num ='1003' OR
    st_num ='1005' OR
    st_num ='1006' ;



-- WHERE 칼럼 IN(값들)
-- 칼럼의 값이 값들 중에 나타나면 SET 명령을 수행하라
UPDATE tbl_student
SET st_dept = '화학과'
WHERE st_num IN ( '10002','10003','10005' ,'10006') ;

SELECT * FROM tbl_student;

-- tbl_student 테이블에 저장된 학생정보가 있는데
-- 장보고 학생의 데이터가 필요가 없어서 삭제를 하려고 한다.

-- 실무에서는 Master Table의 데이터는 함부로 삭제를 하지 않는다.
-- 필요가 없어진 데이터는 특정 칼럼에 값을 세팅하여 
-- 칼럼 값을 기준으로 필요한데이터, 필요없는 데이터를 구분한다.

-- table 에서 데이터를 삭제하기 CRUD 마지막 Delete 명령
-- DELETE 명령도 UPDATE 명령과 마찬가지로 <반드시!!! WHERE 절을 동반>하는 형태로
-- 명령을 수행해야 한다.
-- 그렇지 않으면 최수 1주일간 지옥을 맛보게 된다 ㅋㅋ.
DELETE FROM tbl_student 
WHERE st_num ='10004';

--INSERT, UPDATE, DELETE 명령 수행 한 후 명령을 확정짓는 명령
-- COMMIT 이후에는 ROLLBACK으로 해당 명령을 취소할 수 없다.
COMMIT;


-- 명령취소
-- INSERT, UPDATE, DELETE 명령 수행을 취소하는 명령
ROLLBACK;

-- 데이터를 Table 형식으로 보여줄때 모든 칼럼을 다 포함하여 보여달라
-- SELSCTION type 으로 table보기
SELECT*FROM tbl_student;

-- 데이터를 테이블 형식으로 보여줄때 나열된 칼럼들만 보여달라
--  projection 지정 : SELECT 문을 수행할때 보고자하는 칼럼들을 나열하는 것
SELECT
    st_num,
    st_dept,
    st_name,
    st_age
FROM tbl_student;

SELECT st_name FROM tbl_student;

--특정 칼럼에 조건을 부여하여 레코드를 제한 하는것
-- SELECTION type 조회

SELECT * FROM tel_student
WHERE st_name = '장길산'

UPDATE tbl_student
SET st_dept = '음악과'
WHER st_num IN('10001','10003','10006')

SELECT st_name, st_name, st_name
FROM tbl_student
WHERE st_dept = '음악과'

-- st_name + "는" + st_dept + "학과 학생입니다."
SELECT st_name||'는'||st_dept|| '학과 학생입니다.'
FROM tbl_studen
WHERE st_dept = '음악과'


-- SELECT 문을 이용한 사칙연산
SELECT 3 + 4 FROM DUAL;
SELECT 30 * 40 FROM DUAL;
SELECT 30 / 2 FROM DUAL;
SELECT 30 - 10 FROM DUAL;


-- LIKE 연산자
-- 문자열 칼럼에서 특정한 문자를 포함한 검색기능을 구현할때 사용하는 연산자
SELECT *
FROM tbl_student
WHERE st_name LIKE '%몽%';

--테이블의 구조 확인하는 명령어
DESC tbl_student;

INSERT INTO tbl_student(st_num, st_name, st_dept)
VALUES ('10007','임사홍','컴퓨터공학');

DROP TABLE tbl_student;
--문자열데이터를 저장하는 칼럼
-- CHAR : 데이터의 길이가 고정된 칼럼, 코드(검색하는 용도의 칼럼)등을 저장하는 칼럼
-- VARCHAR2 : 가변문자열, 데이터의 길이가 일정하지 않은 칼럼
-- 크기를 지정할때 가장 길이가 긴 데이터를 기준으로 삼아서 정한다.
-- nVARCHAR2 : 가변문자열, 유니코드 문자열을 수용하는 칼럼
-- 영문자 1글자, 한글등 1글자를 같은 크기로 취급한다.
CREATE TABLE tbl_student (
        st_num	CHAR(5)	 PRIMARY KEY,		
        st_name	nVARCHAR2(20)	NOT NULL,		
        st_dept	nVARCHAR2(10),			
        st_grade	NUMBER(1),			
        st_tel	VARCHAR2(20),			
        st_addr	nVARCHAR2(125)	,		
        st_age	NUMBER(3)			

);
INSERT INTO tbl_student(st_num, st_name, st_dept)
VALUES ('10007','임사홍','컴퓨터공학');
SELECT * FROM tbl_student;

DESC tabl_student;

SELECT * FROM tbl_student;

-- SELECT TYPE 으로 제한하여 보기

-- 학과가 컴퓨터 공학인 학생들만 보여달라
SELECT * 
FROM tbl_student
WHERE st_dept = '컴퓨터공학';


-- 학과가 컴퓨터공학 이고(AND) 학년이 3학년인 학생들만 보여달라
SELECT * 
FROM tbl_student
WHERE st_dept = '컴퓨터공학' AND st_grade = 3;


-- 학과가 컴퓨터 공학 이거나(OR) 학과가 법학인 학생들만 보여라
SELECT * 
FROM tbl_student
WHERE st_dept = '컴퓨터공학' or st_dept = '법학';


-- 학과가 컴퓨터공학이고 또는 법학인 학생들의 정보중 이름과 학과만 나열하라
-- SELECTION 으로 레코드를 제한하고  PROJECTION 으로 칼럼을 제한하여 보여주기
-- IN(포함) 연산자를 사용하여 칼럼에 다수의 조건을 부여하여 값을 가져오기
--상단의 내용과 똑같은 내용 or일 경우 사용가능하다.
SELECT st_name, st_dept 
FROM tbl_student
WHERE st_dept IN ('컴퓨터공학', '법학');


-- 학년이 2학년 ~~ 3학년인 학생들
SELECT st_name, st_dept, st_grade
FROM tbl_student
WHERE st_grade >= 2 AND st_grade <= 3;

SELECT st_name, st_dept, st_grade
FROM tbl_student
WHERE st_grade > 1 AND st_grade < 4;



--시작값과 종료값을 포함한 범위 데이터 조회
SELECT st_name, st_dept, st_grade
FROM tbl_student
WHERE st_grade BETWEEN 2 AND 3;

-- 문자열 칼럼에 저장된 데이터가 모두 길이가 같고 format이 같은경우
-- 부등호(범위연산자)를 포함하여 값을 조회할수 있다.
-- 일반 프로그래밍 코드에서는 문자일 경우는 사용불가
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student
WHERE st_num >= '20010' AND st_num <= '20020';


-- 칼럼에 날짜가 문자열로 저장되어 있을경우
-- 날짜 범위를 설정하여 데이터를 조회할수 있다.
-- WHERE st_num >= '2020-01-01' AND st_num <= '2020-10-31';

-- 시작값과 종료값이 포함된 범위를 조회하는 코드는
-- BETWEEN 연산자를 사용하여 조회하는 코드로 변환하여 사용할 수 있다.
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student
WHERE st_num BETWEEN '20010' AND '20020';
