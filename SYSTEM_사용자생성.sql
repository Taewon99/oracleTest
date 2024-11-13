-- 사용자 계정 만들기 (시스템관리자 모드에서 진행해야됨)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER COUPANG CASCADE; -- 기존 사용자 삭제
CREATE USER COUPANG IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 123456
    DEFAULT TABLESPACE USERS -- 데이터 저장소
    TEMPORARY TABLESPACE TEMP; -- 임시 저장소
GRANT connect, resource, dba TO COUPANG; -- 권한 부여