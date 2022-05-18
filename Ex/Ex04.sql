/**************************************
*SubQuery
***************************************/
------------------------------------------------------------------
--*단일행 SubQuery

--‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
select  first_name,
        salary
from employees
where salary >= (select  salary
                 from employees
                 where first_name = 'Den');

--Den의 급여를 구한다
select  salary   
from employees
where first_name = 'Den';    --11000



--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
select  first_name,
        salary,
        employee_id
from employees
where salary = (select  min(salary)
                from employees);
--가장 작은 급여를 구한다
select  min(salary)  
from employees;


--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
select  first_name,
        salary
from employees
where salary <= (select avg(salary)
                 from employees); --평균급여

--평균급여
select avg(salary)
from employees;

------------------------------------------------------------------
--*다중행 SubQuery

--??  부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
--12008, 8300
select salary
from employees
where department_id = 110;

--비교용
select  employee_id,
        first_name,
        salary
from employees
where salary = 12008
or salary = 8300 ;

--사용
select employee_id,
       first_name,
       salary
from employees
where salary in (select salary
                 from employees
                 where department_id = 110);  --12008, 8300

------------------------------------------------

--각 부서별로 최고급여를 받는 사원이름을 출력하세요
--where절로 구하기
select  department_id,
        max(salary)
from employees
group by department_id;


select  first_name,
        salary,
        department_id,
        email
from employees
where (department_id, salary) in ( select  department_id,
                                           max(salary)
                                   from employees
                                   group by department_id  );

--각 부서별로 최고급여를 받는 사원이름을 출력하세요
--테이블로 구하기

select  e.first_name,
        e.salary,
        e.department_id,
        s.department_id,
        s.maxSalary
from employees e, (select department_id, 
                          max(salary) maxSalary
                   from employees
                   group by department_id) s  
where e.department_id = s.department_id
and e.salary = s.maxSalary;


------------------------------------------------

--각 부서별로 최고급여를 받는 사원이름을 출력하세요
--where절로 구하기
select  department_id,
        max(salary)
from employees
group by department_id;


select  first_name,
        salary,
        department_id,
        email
from employees
where (department_id, salary) in ( select  department_id,
                                           max(salary)
                                   from employees
                                   group by department_id  );

--각 부서별로 최고급여를 받는 사원이름을 출력하세요
--테이블로 구하기

select  e.first_name,
        e.salary,
        e.department_id,
        s.department_id,
        s.maxSalary
from employees e, (select department_id, 
                          max(salary) maxSalary
                   from employees
                   group by department_id) s  
where e.department_id = s.department_id
and e.salary = s.maxSalary;

-------------------------------------------------

-- 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
-- 급여순
-- 1~5등만 출력

/* 영어 그대로 row(행)에 num(번호)를 주는 것 */

-- 이렇게 하면 사번에 번호를 매기고 정렬이 되어 급여 순으로 정렬되지 않음
-- 먼저 번호를 매긴 후 정렬되는 것
select  rownum, -- 일렬 번호를 매김 
        employee_id,
        first_name,
        salary
from employees
order by salary desc
;

-- 먼저 정렬된 테이블을 만들고 
-- 정렬된 테이블에서 자료를 가져옴
-- phone_number 같은 것은 지정한 테이블에 존재하지 않으므로 가져올 수 없음
select  rownum,
        ot.employee_id,
        ot.first_name,
        ot.salary
from (select employee_id,
             first_name,
             salary
      from   employees
      order by salary desc) ot
where rownum >= 1 
-- 1이 아니면 데이터가 추출되지 않음
and rownum <= 5
/*and   rownum <= 7*/
;

-- 1이 아닌 순번부터 나열할 수 있도록 작성하기
-- (먼저 정렬한 테이블을 사용한) 순번매긴 테이블 사용 ㅎ
select  ort.rn,
        ort.employee_id,
        ort.employee_id,
        ort.salary
from    (select  rownum rn,
                 ot.employee_id,
                 ot.first_name,
                 ot.salary
         from (select employee_id,
                      first_name,
                      salary
               from   employees
               order by salary desc) ot
         )ort
where rn >= 3 
and rn <= 5
;


-- 예제
-- 07년에 입사한 직원을 급여가 많은 순으로 나열했을 때 3등~ 7등인 직원의 이름과 급여, 입사일은?
select  순번,
        이름,
        급여,
        입사일
from   (select rownum 순번,
               이름,
               급여,
               입사일
        from  (select  first_name 이름,
                       salary 급여,
                       hire_date 입사일
              from     employees
              where   to_char(hire_date,'YY')='07'
              /* where hire_date >= '07/01/01'
                 and hire_date <= '07/12/31' */
              order by salary desc) sal 
        ) 급여순      
where   순번>=3
and     순번<=7
;       
    

-------------------------------------add)

--rownum

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--정렬을 하면 rownum이 섞인다 -->정렬을 하고 rownum 을 준다
select  rownum,
        employee_id,
        first_name,
        salary
from employees   -- 미리 정렬되어 있는 테이블이면 rownum이 섞이지 않는다
order by salary desc;

-->정렬(정렬된 테이블 사용)하고 rownum을 준다
select  rownum,
        ot.employee_id,
        ot.first_name,
        ot.salary
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) ot ;


--rownum을 이용해서 원하는 순위의 값을 선택한다(where절)
--where절이 2번 부터이면 데이터가 없다 (rownum이 항상 1이다)
select  rownum ,
        ot.employee_id,
        ot.first_name,
        ot.salary
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) ot  --정렬도 되어 있고  rownum로 있는 테이블이면?
where rownum >= 2
and rownum <= 5;

-->(1)정렬하고 (2)rownum이 있는 테이블을 사용하고 (3)where절을 쓴다
select  ort.rn,
        ort.first_name,
        ort.salary
from (select  rownum rn,
              ot.employee_id,
              ot.first_name,
              ot.salary
      from (select  employee_id,
                    first_name,
                    salary
            from employees
            order by salary desc) ot   --(1)
      )ort  --(2)
where rn >= 2
and rn<=5;  --(3)
