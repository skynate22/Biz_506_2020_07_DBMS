-- 여기는 user1 화면입니다
-----------------------------------------------------------
-- 외래키(FOREIGN KEY)
-----------------------------------------------------------
-- 두개(이상)의 테이블간에 Replation 을 강제로 설정하여
-- 테이블에 추가되는 데이터의 무결성을 보증하는 제약조건 설정
-- JOIN을 사용하여 2개의 테이블간의 Relation 을 설정하기도 하는데
--차이점
-- JOIN은 단순히 View 의 편리함(필요한 정보를 Projection 포함)을 위헤서 사용하기
-- FK 는 데이터를 추가하는 단계부터 잘못된 데이터가 추가되는 것을 방지하는 목적
-- FK 는 테이블을 생성할때 만들기도 하지만
-- 일반적으로 테이블을 생성한 후 테이블 변경을 통해 만드는 것이 좋다.

-- 가장 좋은 경우는 테이블을 생성하고 데이터를 한개도 추가하지 않은 상태로
-- 설정하는 것이다.
-- 하지만 App을 사용하기 시작하는 초기단계에서는 다량의 데이터를 추가해야하는 
-- 일들이 많아서 이때 FK가 설정이 되어 있으면 Sub Table에 데이터를 추가하는데
-- 많은 애로 사항이 발생한다.
-- 이런경우 초기에 FK를 설정하지 않거나 , FK를 제거하고 데이터를 입력(추가) 하도록
-- 하는경우가 많다.


-- 현재 스키마에 있는 학생정보 와 성적정보 테이블을 FK(외래키)관계로 설정을 한다.
-- FK관계에 있는 테이블을 부모테이블과 자식테이블로 분류를 하는데, 
-- FK 설정은 자식테이블에서 실시한다.

-- 학생정보 테이블에 학생정보가 없으면, 성적정보를 입력할 수 없도록 설정한다.
-- 학생정보 테이블을 부모테이블이라고 하고, 성적정보 테이블을 자식 테이블이라고 한다.

SELECT * FROM tbl_score;



-- 사후(테이블 생성후) FK 설정
ALTER TABLE tbl_score -- tbl_score(자식) 테이블에 설정을 변경하겠다
ADD CONSTRAINT fk_st_sc   -- 제약조건(정책)을 추가(ADD)하겠다 
FOREIGN KEY(sc_num)  --외래키를(누구를) : sc_num칼럼을 기준으로
REFERENCES tbl_student(st_num);  --부모는 누군데 : tlb_student,
--                                  연동(연결)할 부모 칼럼은 어떤것인데? : st_num
--생성된 FK 제약 조건을 삭제
ALTER TABLE tbl_score
DROP CONSTRAINT fk_st_sc CASCADE;

-- 학생정보에 없는 20200 학생의 국어 성적을 추가했다.
-- 20200 학생의 국어점수가 정상적인 학적정보가 이상이 없는 학생의 성적인지 
-- 확신할수 있는 방법이 없다
-- 따라서 이데이터는 무결성 원칙에 위배되는 데이터 일수도 있다.
INSERT INTO tbl_scre(sc_num,sc_kor) VALUES ('20200,100');
DELETE FROM tbl_score WHERE sc_num = 20200;

---------------------------------------------------------------------------
-- FK 설정이 된 두 테이블간의 관계
---------------------------------------------------------------------------
-- 학생정보 st_num 데이터                 성적정보 st_num 데이터
--  값이 추가(있다)           >>                 있다(추가할수 있다)
--  값이 없다                 >>                절대없다(추가할수 없다)
--  있어야 한다               <<                있더라(추가 되어 있다.)
--
--
-- 만약 학생정보 데이터가 필요가 없어서 삭제를 할경우
-- 먼저 성적정보에서 삭제하고자 하는 학번에 성적데이터를 모두 삭제해야 한다.

-- 아주 특별하게 학생의 학번(st_num)변경할 경우
--  1. 먼저 성적정보에서 변경할  학번의 성적데이터를 모두 삭제하고
--  2. 학생정보의 학번을 변경하고
--  3. 변경된 학번으로 성적데이터를 추가해야 한다.

-- ALTER TABLE 명령을 수행하게 되면 명령이 시작된 순간 table의 모든 데이터는 접근이 금지된다.
-- 만약에 저장된 데이터가 매우 많다면
-- 상당한 시간이 소요될 것이고, 그 동안 table의 데이터를 필요로 하는 
-- App은 실행이 중단된다.
-- 칼럼추가, 칼럼삭제, 칼럼명 변경, 칼럼 타입 변경, 등을 수행할수 있다.
-- 칼럼을 삭제, 변경, 하는경우 기존 데이터가 손상되는 위험이 있다.
--




-- 사후 (테이블 생성후) FK 설정
ALTER TABLE tbl_score 
DROP CONSTRAINT fk_st_sc CASCADE;

ALTER TABLE tbl_score 
ADD CONSTRAINT fk_st_sc   
FOREIGN KEY(sc_num)  
REFERENCES tbl_student(st_num)

                    -- 만약 부모테이블에서 데이터를 삭제하면
ON DELETE CASCADE;  -- 삭제되는 키값의 데이터가 자식테이블에 있으면 
                    -- 같이 삭제하라                   


DELETE FROM tbl_student WHERE st_num = '20001';
      
                    
                    -----오라클에서 지원 x 인 매서드------
-- ON DELETE CASCADE SET NULL ; >> 무인도로 만들어라
-- ON UPDATE CASCADE ; >> 만약 부모테이블에서 키 값이 변경이 되면 
                        --자식테이블의 모든 데이터를 찾아서 같은 값으로 바꿔라

ALTER TABLE tbl_score
DROP CONSTRAINT fk_st_sc CASCADE;

-- FK 를 설정하는 대상
-- 테이블간의 데이터가 1:N 인경우 N상태의 테이블에 설정을 저장한다.
--      REFERRENS : 1상태의 테이블

-- 테이블간의 데이터가 1:1인 경우 Work Table에 설정을 한다.
--      REFFERRENS : Master Table에 설정을 한다.


-- 학생정보, 학과 정보간에 FK 설정하려고 한다.
-- 학과정보는 학과명(코드)이 유일한 값으로 정해져 있다. 같은 이름의 학과는 존재할수 없다.
-- 학생정보에는 학생마다 학과가 다르거나 같을 수 있어서 수없이 많은 중복데이터가 있다.
-- 부모테이블 : 학과정보 학과 1인경우
-- 자식테이블 : 학생정보중의 학과는 N인 경우

ALTER TABLE tbl_student
ADD CONSTRAINT FK_D_ST  -- 한스키마내에서 이름은 유일해야 한다.
FOREIGN KEY (st_dept)
REFERENCES tbl_dept(d_code);

ALTER TABLE tbl_student
DROP CONSTRAINT FK_D_ST CASCADE;

