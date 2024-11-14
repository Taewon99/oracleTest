-- 시퀸스 생성

create sequence emp_seq
start with 1
increment by 1
maxvalue 100000;
--minvalue 1
--nocycle
--cache 2;

select * from emp01;

create table emp01
as
select employee_id, first_name, hire_date
from employees
where 1 = 0;

-- emp_seq.nextval 입력하기
insert into emp01 values (emp_seq.nextval, 'KDJ', sysdate);

-- emp_seq.currval 입력하기
select emp_seq.currval from dual;

-- sequence dept_seq 생성하기, 시작값 10, 증가치 10, 결과치 30
create sequence dept_seq
start with 10
increment by 10
maxvalue 30;

select * from user_sequences;

-- dept02 테이블 구조 복사하기
create table dept02
as
select department_id, department_name, location_id
from departments
where 1 = 0;

select * from dept02;

insert into dept02 values(dept_seq.nextval, '인사과', 1);
insert into dept02 values(dept_seq.nextval, '총무과', 2);
insert into dept02 values(dept_seq.nextval, '서무과', 3);
insert into dept02 values(dept_seq.nextval, '교육과', 4);

-- sequence 수정
alter sequence dept_seq
maxvalue 100;

select * from user_sequences;

-- sequence 삭제
drop sequence dept_seq;

-- 데이터 딕셔너리에서 index 확인
select * from user_ind_columns where table_name = 'EMPLOYEES';

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100; 
DROP TABLE EMP10;
CREATE TABLE EMP10
AS
SELECT * FROM EMPLOYEES WHERE 1=1; 
SELECT * FROM EMP10 WHERE EMPLOYEE_ID = 100; 

-- 인덱스 생성하기 
SELECT * FROM user_ind_columns WHERE TABLE_NAME = 'EMP10';
CREATE UNIQUE INDEX EMP10_EMPLOYEE_IX
ON EMP10(EMPLOYEE_ID); 

-- 인덱스 삭제하기
DROP INDEX EMP10_EMPLOYEE_IX;
--
SELECT * FROM USER_SOURCE; 



-- 사원 번호와 사원명과 부서명과 부서의 위치를 출력하는 뷰(VIEW_LOC)를 작성하라
create view view_loc
as
select employee_id, first_name, department_name, location_id
from employees join departments on employees.department_id = departments.department_id;

select * from view_loc;

--  30번 부서 소속 사원의 이름과 입사일과 부서명을 출력하는 뷰(VIEW_DEPT30)를 작성하라.
create view view_dept30
as
select first_name, hire_date, department_name
from employees join departments on employees.department_id = departments.department_id
where employees.department_id = 30;

select * from view_dept30;

-- 부서별 최대 급여 정보를 가지는 뷰(VIEW_DEPT_MAXSAL)를 생성하라.
create view view_dept_maxsal
as
select department_id, max(salary) as max_salary
from employees
group by department_id
order by department_id;

select * from view_dept_maxsal;

-- 급여를 많이 받는 순서대로 3명만 출력하는 뷰(VIEW_SAL_TOP3)와 인라인 뷰로 작성하라.
select rownum, first_name, salary
from (select first_name, salary
        from employees
        order by salary desc)
where rownum <=3;        