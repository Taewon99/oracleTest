--영화를 시청한 사람들만 리뷰를 작성할 수 있도록 설계하려면 영화, 사용자, 시청 기록, 리뷰의 테이블 관계를 설정해야 합니다. 아래는 이를 구현할 수 있는 DDL과 각 테이블의 기능 설명입니다.
--테이블 1: Users (사용자 테이블)
--설명: 사용자 정보를 저장하는 테이블입니다.

CREATE TABLE Users (
    user_id VARCHAR2(20),
    username VARCHAR2(50) NOT NULL,
    password VARCHAR2(255) NOT NULL,
    email VARCHAR2(100)
);
ALTER TABLE USERS ADD CONSTRAINT USERS_USER_ID_PK PRIMARY KEY(USER_ID);
ALTER TABLE USERS ADD CONSTRAINT USERS_EMAIL_UK UNIQUE(EMAIL);

--Create: 사용자 등록 (회원가입).
--Read: 사용자 정보 조회.
--Update: 사용자 정보 수정 (예: 비밀번호 변경).
--Delete: 사용자 계정 삭제.

--테이블 2: Movies (영화 테이블)
--설명: 영화 정보를 저장하는 테이블입니다.

CREATE TABLE Movies (
    movie_id NUMBER,
    title VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    duration NUMBER, -- 상영 시간(분)
    genre VARCHAR(50),
);
ALTER TABLE MOVIES ADD CONSTRAINT MOVIES_MOVIE_ID_PK PRIMARY KEY(MOVIE_ID);

--Movies 테이블 주요 기능
--Create: 새로운 영화 추가.
--Read: 영화 목록 및 상세 정보 조회.
--Update: 영화 정보 수정 (예: 제목, 상영 시간).
--Delete: 특정 영화 삭제.

CREATE SEQUENCE MOVIE_SEQ
    START WITH 1
    INCREMENT BY 1;


--테이블 3: WatchHistory (시청 기록 테이블)
--설명: 사용자가 시청한 영화 기록을 저장하는 테이블입니다.

CREATE TABLE Watch_History (
    watch_id NUMBER,
    user_id NUMBER NOT NULL,
    movie_id NUMBER NOT NULL,
    watch_date DATE DEFAULT SYSDATE
);
ALTER TABLE WATCH_HISTORY ADD CONSTRAINT WATCH_HISTORY_WATCH_ID_PK PRIMARY KEY(WATCH_ID);
ALTER TABLE WATCH_HISTORY ADD CONSTRAINT WATCH_HISTORY_USER_ID_FK FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE;
ALTER TABLE WATCH_HISTORY ADD CONSTRAINT WATCH_HISTORY_MOVIE_ID_FK FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID) ON DELETE CASCADE;

--WatchHistory 테이블 주요 기능
--Create: 사용자가 영화를 시청하면 기록 추가.
--Read: 사용자가 시청한 영화 목록 조회.
--Update: 시청 날짜 수정 (필요 시).
--Delete: 특정 시청 기록 삭제.
CREATE SEQUENCE WATCH_HISTORY_SEQ
    START WITH 1
    INCREMENT BY 1;


--테이블 4: Reviews (리뷰 테이블)
--설명: 사용자가 시청한 영화에 한해 리뷰를 작성할 수 있도록 설정된 테이블입니다.

CREATE TABLE Reviews (
    review_id NUMBER,
    watch_id NUMBER,
    rating NUMBER , -- 평점 1~5
    comment varchar2(255)
);
ALTER TABLE REVIEWS ADD CONSTRAINT REVIEWS_REVIEW_ID_PK PRIMARY KEY(REVIEW_ID);
ALTER TABLE REVIEWS ADD CONSTRAINT REVIEWS_RAITING_CK CHECK (rating BETWEEN 1 AND 5); -- 평점 1~5
ALTER TABLE REVIEWS ADD CONSTRAINT REVIEWS_WATCH_HISTORY_FK FOREIGN KEY (watch_id)
        REFERENCES Watch_History(watch_id) ON DELETE CASCADE;
        
--Reviews 테이블 주요 기능
--Create: 사용자가 시청한 영화에 대해 리뷰 작성.
--Read: 영화별 리뷰 목록 조회.
--Update: 리뷰 내용 수정 (예: 평점, 코멘트).
--Delete: 특정 리뷰 삭제.
--영화 본 시간 조인해서 넣을 것

CREATE SEQUENCE Reviews_SEQ
    START WITH 1
    INCREMENT BY 1;


--테이블 간 관계
--
--Movies는 WatchHistory와 Reviews에서 참조됩니다.
--Users는 WatchHistory와 Reviews에서 참조됩니다.
--
--WatchHistory는 사용자가 영화를 시청한 기록을 저장하며, Reviews에서 이를 참조하여 시청한 사용자만 리뷰를 작성하도록 보장합니다.
--
--리뷰 작성 제한 규칙
--
--Reviews 테이블의 CONSTRAINT FK_Review_Watch를 통해 사용자가 시청 기록이 없으면 리뷰를 작성할 수 없게 설정합니다.
--리뷰 작성 시 user_id와 movie_id가 WatchHistory 테이블에 존재해야만 데이터 삽입이 가능합니다.
--CRUD 시나리오
--1. Users (사용자 테이블)
--사용자 등록, 정보 조회 및 수정.
--2. Movies (영화 테이블)
--영화 등록, 조회 및 관리.
--3. WatchHistory (시청 기록 테이블)
--사용자가 영화를 시청한 후 기록 추가.
--4. Reviews (리뷰 테이블)
--Create: 시청한 영화에 한해 리뷰 작성.
--Read: 리뷰 조회 (영화별 또는 사용자별).
--Update: 리뷰 수정 (평점, 코멘트).
--Delete: 리뷰 삭제.