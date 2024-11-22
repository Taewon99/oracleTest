-- PL/SQL
-- 내용을 employee name, employee_id를 가져와서 출력하기
declare
    vfirst_name employees.first_name%type;
    vemployee_id employees.employee_id%type;
begin
    select first_name, employee_id into vfirst_name,vemployee_id
    from employees
    where first_name = 'Ellen';
    dbms_output.put_line('first_name = ' || vfirst_name);
    dbms_output.put_line('employee_id = ' || vemployee_id);
end;
/

-- 내용을 employee에 해당된 name, job_id, employee_id 를 출력해주는 프로그램 작성 하기
declare
    -- 배열타입 정의(테이블타입 정의) 
    type first_name_table_type is table of employees.first_name%type index by binary_integer;
    type job_id_table_type is table of employees.job_id%type index by binary_integer;
    type employee_id_table_type is table of employees.employee_id%type index by binary_integer;
    
    -- 배열타입변수 선언
    first_name_table first_name_table_type;
    job_id_table job_id_table_type;
    employee_id_table employee_id_table_type;
    row_table employees%rowtype;
    i binary_integer := 0;
    j binary_integer;
begin
    -- 향상된 포문을 통해서 result set값을 한개씩 가져와서 각 컬럼배열에 저장한다.
    for row_table in (select * from employees) loop
        i := i+1;
        first_name_table(i) := row_table.first_name;
        job_id_table(i) := row_table.job_id;
        employee_id_table(i) := row_table.employee_id;
    end loop;
    
    -- 향상된 for문을 이용해서 컬럼 배열값에 저장된 값을 가져와서 출력하시오.
    for j in 1..i loop
        dbms_output.put_line(first_name_table(j)||' / '|| job_id_table(j)||' / '||employee_id_table(j));
    end loop;
end;
/

-- 내용을 employee 'Susan' 이름을 갖는 사원의 employee_id, first_name, department_id를 출력하시오.
declare
    vemployee_id employees.employee_id%type;
    vfirst_name employees.first_name%type;
    vlast_name employees.last_name%type;
    vdepartment_id employees.department_id%type;
begin
    select employee_id, first_name, last_name, department_id into vemployee_id, vfirst_name, vlast_name, vdepartment_id
    from employees where first_name = 'Susan';
    
    dbms_output.put_line(vemployee_id||' / '|| vfirst_name||' / '||vlast_name||' / '||vdepartment_id);
end;
/

-- 내용을 employee 최고경영자 employee_id, name, job_id, department_id를 출력하시오. 레코드변수 활용
declare
    -- 레코드타입(사원번호, 이름, 담당업무, 부서번호)
    type emp_record_type is record(
        vemployee_id employees.employee_id%type,
        vfirst_name employees.first_name%type,
        vlast_name employees.last_name%type,
        vjob_id employees.job_id%type,
        vdepartment_id employees.department_id%type
    );
    
    -- 레코드 타입 변수 선언
    emp_record emp_record_type;
    
begin
    select employee_id, first_name, last_name, job_id, department_id into emp_record
    from employees where manager_id is null;
    dbms_output.put_line('사원번호: '||emp_record.vemployee_id);
    dbms_output.put_line('이름: '||emp_record.vfirst_name||' '||emp_record.vlast_name);
    dbms_output.put_line('담당업무: '||emp_record.vjob_id);
    dbms_output.put_line('부서번호: '||emp_record.vdepartment_id);
   
end;
/

-- 내용을 employee 최고경영자 employee_id, first_name, year_income(include commision)를 출력하시오. 레코드변수 활용
declare
    emp_record employees%rowtype;
    total_salary number(10,2);
begin
    select * into emp_record
    from employees where manager_id is null;
    
    if(emp_record.commission_pct is null) then
        emp_record.commission_pct := 0;
    end if;
    
    total_salary := emp_record.salary *12 + (emp_record.salary * emp_record.commission_pct);
    
    dbms_output.put_line('사원번호: '||emp_record.employee_id);
    dbms_output.put_line('이름: '||emp_record.first_name);
    dbms_output.put_line('연봉: '||ltrim(to_char(total_salary,'$999,999,999.99')));
end;
/

select round(dbms_random.value(1,5),0) from dual;

select dbms_random.string('x',5) from dual;

-- employee 테이블에서 임의이 부서번호를 랜덤으로 생성한 뒤, 해당부서번호 최고연봉을 출력하여 평가(낮음, 높음, 중간, 최고, 없음)
declare
    -- 부서번호, 최고연봉, 평가 결과 선언
    vno number(4);
    vtop_salary number(12,2);
    vresult varchar2(20);
begin
    -- 임의 부서번호 생성하기 (random)
    vno := round(dbms_random.value(10,110),-1);
    select salary into vtop_salary
    from (select salary from employees where department_id = vno order by salary desc)
    where rownum = 1;
    -- 평가 내리기 1-5000 낮음, 5000-10000 중간, 10000-20000 높음, 20000~ 최고, 없으면 예외 처리
    if (vtop_salary between 1 and 5000) then
        vresult := '낮음';
    elsif (vtop_salary between 5000 and 10000) then
        vresult := '중간';
    elsif (vtop_salary between 10000 and 20000) then
        vresult := '높음';
    else
        vresult := '최고';
    end if;
    
    dbms_output.put_line('부서번호: '||vno);
    dbms_output.put_line('최고연봉: '||vtop_salary);
    dbms_output.put_line('최고연봉평가: '||vresult);
    
    exception
        when no_data_found then
            dbms_output.put_line(vno||' 해당부서에 해당되는 사원이 없습니다.');
end;
/

-- 구구단 만들기
declare
    base number := 2;
    counts number := 1;
begin
    loop
        dbms_output.put_line('===== '||base||'단 =====');
        loop
            dbms_output.put_line(base||' * '||counts||' = '||base*counts);
            counts := counts+1;
            if counts > 9 then
                exit;
            end if;
        end loop;
        base := base+1;
        counts := 1;
        if base > 9 then
            exit;
        end if;
    end loop;
end;
/