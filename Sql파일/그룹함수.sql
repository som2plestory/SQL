/************************************
*   그룹함수
************************************/
/*
select  first_name,
        sum(salary)
from employees;
*/
select sum(salary)
from employees;


-- 그룹함수 - count()
select  count(*),
        count(commission_pct),  -- commission_pct 열의 null 은 카운트에서 제외
        count(manager_id)
from employees;

select count(*)
from employees
where salary >= 16000;


-- 그룹함수 - sum())
select  count(*),
        sum(salary)
from employees;


-- 그룹함수 - avg()
select  avg(salary),            -- 급여가 null인 사람은 평균 계산 제외
        avg(nvl(salary, 0)),    -- null 값을 0으로 변경 후 평균 계산
        round(avg(salary),0),
        count(*),
        sum(salary)
from employees;


-- 그룹함수 - max() / min()
select  max(salary),
        min(salary),
        count(*)
from employees
order by salary desc;

select  department_id,
        salary
from employees
order by department_id asc;


select  department_id,
        avg(salary)     -- department_id(부서별 평균)
from employees
group by department_id
order by department_id asc;

select  job_id,
        avg(salary)
from employees
group by department_id;

select  department_id,
        job_id,
        avg(salary),    -- department_id(부서별 평균)
        sum(salary),    -- department_id(부서별 합계)
        count(salary)   -- department_id(부서별 카운트)
from employees
group by department_id, job_id
ORDER BY department_id asc;

-- 예제)
-- 연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와, 인원수, 급여합계를 출력하세요
select  department_id 부서번호,
        count(*) 인원수,       -- 부서별 인원수
        sum(salary) 급여합계   -- 부서별 급여 합계
from employees
where sum(salary) >= 20000    -- where 절에는 사용불가
group by department_id;

-- 정상
select  department_id 부서번호,
        count(*) 인원수,     
        sum(salary) 급여합계   
from employees
where hire_date >= '04/01/01'
group by department_id
having sum(salary)>=20000
and sum(salary) <= 100000
and department_id = 90;
-- and hire_date >= '04/01/01' : 오류 
/*having 절에는 그룹함수와 group by에 참여한 컬럼만 사용할 수 있다. */



-- CASE ~ END 문
select  employee_id,
        first_name,
        job_id,
        salary,
        case when job_id = 'AC_ACCOUNT' then salary + salary*0.1
             when job_id = 'SA_REP' then salary + salary*0.2
             when job_id = 'ST_CLERK' then salary + salary*0.3
        END realsalary
from employees;


-- DECODE 문
select  employee_id,
        first_name,
        job_id,
        salary,
        decode( job_id, 'AC_ACCOUNT',salary + salary*0.1, 
                        'SA_REP', salary + salary*0.2,  
                        'ST_CLERK',  salary + salary*0.3,
                        salary) bonus
from employees;

-- 예제)
-- 직원의 이름, 부서, 팀을 출력하세요
-- 팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’ 60~100이면 ‘B-TEAM’  110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
select  first_name 이름,
        department_id 부서,
        case when department_id >=10 and department_id<=50 then 'A-TEAM'
             when department_id >=60 and department_id<=100 then 'A-TEAM'
             when department_id >=110 and department_id<=150 then 'C-TEAM'
             ELSE '팀없음'
        END TEAM
from employees;