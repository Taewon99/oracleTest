-- Susan 부서 아이디 보기
select department_id from employees where first_name = 'Susan';

-- 부서테이블에서 40번 부서명 조회
select department_name from departments where department_id =40;

-- Susan 소속되어 있는 부서명을 검색하시오
select * from employees where first_name = 'Susan';
select * from departments where department_id = 40;

-- Inner join 사용 검색
select E.first_name, D.department_name
from departments D
inner join employees E
on D.department_id = E.department_id
where E.first_name = 'Susan';

-- 단일행은 비교, 크기, 연산이 가능하다.
-- 다중행은 비교, 크기, 연산이 불가능하다. (IN = OR, ANY = 1개이상, ALL = 모두, EXISTS = 존재하는지)

-- sub query 사용 검색
select department_name from departments where department_id = (select department_id from employees where first_name = 'Susan');

-- EMPLOYEES 테이블에서 LEX와 같은 부서에 있는 모든 사원의 이름과 입사일자(형식: 1981-11-17)를 출력하는 SELECT문 작성
select first_name, last_name, to_char(hire_date,'yyyy-mm-dd')as hire_date
from employees 
where department_id = (select department_id
                        from employees
                        where first_name = 'Lex');

-- EMPLOYEES 테이블에서 CEO에게 보고하는 직원의 모든 정보를 출력 
select * from employees where manager_id = (select employee_id from employees where manager_id is null);

-- 고용테이블에서 전체 연봉평균
select first_name, salary from employees where salary > (select round(avg(salary)) as "평균연봉" from employees);

-- EMPLOYEES 테이블에서 Susan 또는 Lex 월급
select first_name, salary from employees where first_name = 'Susan' or first_name = 'Lex';

select first_name, job_id, salary
from employees 
where salary in (select salary  
                from employees
                where first_name = 'Susan' or first_name = 'Lex') and 
                    (first_name <> 'Susan' and first_name <> 'Lex');
                    
select first_name, job_id, salary
from employees
where salary
    in (select salary  
        from employees
        where first_name = 'Susan' or first_name = 'Lex')
    and first_name not in('Susan', 'Lex');

-- 한명이상으로부터 보고를 받는다 = 나는 매니저로 등록되어있다. null = ceo
select employee_id, first_name, job_id, department_id
from employees
where manager_id in (select distinct manager_id from employees);

-- EMPLOYEES 테이블에서 Accounting 부서에서 근무하는 직원과 같은 업무를 하는 직원의 이름, 업무명을 출력하는 SELECT문을 작성하시오.
select first_name, job_id, department_id
from employees
where department_id = (select department_id 
                        from departments
                        where department_name = 'Accounting');

-- 직급이 'ST_MAN'인 직원이 받는 급여들의 최소 급여보다 많이 받는 직원들의 이름과 급여를 출력하되 부서번호가 20번인 직원은 제외한다.
select first_name, salary, department_id
from employees
where salary > any (select salary
                    from employees
                    where job_id = 'ST_MAN')
    and department_id not in (20);

-- EMPLOYEES 테이블에서 Valli라는 이름을 가진 직원과 업무명 및 월급이 같은 사원의 모든 정보 를 출력하는 SELECT문을 작성하시오. (결과에서 Valli는 제외)
select *
from employees
where (job_id,salary)in (select job_id, salary from employees where first_name = 'Valli') and
        first_name not in 'Valli';

-- EMPLOYEES 테이블에서 월급이 자신이(‘Valli’) 속한 부서의 평균 월급보다 높은 사원의 부서번호, 이름, 급여를 출력하는 SELECT문을 작성하시오
select department_id, first_name, salary
from employees
where salary > (select avg(salary)
                from employees
                where department_id = (select department_id
                                        from employees
                                        where first_name = 'Valli'));
                                        
-- HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. Tucker(last_name) 사원보다 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오.
select last_name||' '||first_name as "Name", job_id, salary
from employees
where salary > (select salary
                    from employees
                    where last_name = 'Tucker');
                    
-- 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여, 입사일을 출력하시오.
select last_name||' '||first_name as "Name", job_id, salary, hire_date
from employees
where (job_id, salary) in (select job_id, min(salary)
                            from employees
                            group by job_id);

-- 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오.
select last_name||' '||first_name as "Name", salary, department_id, job_id
from employees e
where salary > (select avg(salary) from employees where department_id = e.department_id);

-- 모든 사원의 소속부서 평균급여를 계산하여 사원별로 성과 이름(Name으로 별칭), 업무, 급여, 부서번호, 부서 평균급여(Department Avg Salary로 별칭)을 출력하시오.
select e.first_name || ' ' || e.last_name "Name", e.job_id, e.salary, e.department_id,
        (select ROUND(AVG(salary)) "Department Avg Salary"
         from employees
         where department_id = e.department_id) average
from employees e;
