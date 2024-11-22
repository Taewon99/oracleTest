-- 사용자 계정 만들기 (시스템관리자 모드에서 진행해야됨)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER SAMPLE CASCADE; -- 기존 사용자 삭제
CREATE USER SAMPLE IDENTIFIED BY 123456 -- 사용자 이름: SAMPLE, 비밀번호 : 123456
    DEFAULT TABLESPACE USERS -- 데이터 저장소
    TEMPORARY TABLESPACE TEMP; -- 임시 저장소
GRANT connect, resource, dba TO SAMPLE; -- 권한 부여