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
