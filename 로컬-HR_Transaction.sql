-- Transaction
drop table dep02;

-- 테이블복사 (구조만 복사)
create table dep02
as
select * from departments where 1=0;

-- 내용복사
insert into dep02 select * from departments;

select * from dep02;

savepoint c1;

Delete from dep02;

rollback to c1;