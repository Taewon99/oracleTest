-- 오라클에서 성적처리 테이블을 생성하라
CREATE TABLE GRADING(
    NO NUMBER(4) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    KOR NUMBER(4) NOT NULL,
    ENG NUMBER(4) NOT NULL,
    MAT NUMBER(4) NOT NULL,
    TOT NUMBER(4),
    AVG NUMBER(5,1),
    RANK NUMBER(4),

    CONSTRAINT GRADING_GRADE_PK PRIMARY KEY(GRADE)
);

-- 테이블에 학번, 이름, 국어, 영어, 수학 점수를 입력하면 총점과 평균이 자동 계산되도록 프로시저를 작성하라

-- 테이블에 학번, 이름, 국어, 영어, 수학 점수를 입력하면 총점과 평균이 자동 계산되도록 트리거를 작성하라
CREATE OR REPLACE TRIGGER GRADING_TRG
    AFTER INSERT
    ON GRADING
    BEGIN
        UPDATE GRADING
            SET TOT = :NEW.KOR + :NEW.ENG + :NEW.MAT;
        UPDATE GRADING
            SET AVG = (:NEW.KOR + :NEW.ENG + :NEW.MAT)/3;
    END;
/

-- 등수를 구하는 저장프로시저를 작성하고 이를 호출하여 등수가 제대로 구해지는지 확인