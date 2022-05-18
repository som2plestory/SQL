/* 혼합 SQL 문제입니다. */

-- 문제1.
-- 담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
-- 이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요. (45건)
select  first_name 이름,
        manager_id 매니저아이디,
        commission_pct 커미션비율,
        salary 월급
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000
order by salary desc;


-- 문제2.
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 
-- 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요
-- 조건절비교 방법으로 작성하세요
-- 급여의 내림차순으로 정렬하세요
-- 입사일은 2001-01-13 토요일 형식으로 출력합니다.
-- 전화번호는 515-123-4567 형식으로 출력합니다. (11건)
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        to_char(hire_date, 'YYYY-MM-DD') 입사일,
        phone_number 전화번호,
        department_id 부서번호
from employees 
where (department_id, salary) in (  select  department_id,
                                            max(salary) 
                                    from    employees
                                    group by department_id)
order by salary desc;


-- 문제3.
-- 매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-- 통계대상(직원)은 *2005년 이후(2005년 1월 1일 ~ 현재)*의 입사자 입니다.
-- 매니저별 평균급여가 5000이상만 출력합니다.
-- 매니저별 평균급여의 내림차순으로 출력합니다.
-- 매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-- 출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.(9건)
select  e.employee_id 매니저아이디,
        e.first_name 매니저이름,
        매니저별평균급여,
        매니저별최소급여,
        매니저별최대급여
from employees e, ( select manager_id,
                    max(salary) 매니저별최대급여,
                    min(salary) 매니저별최소급여,
                    round(avg(salary), 0) 매니저별평균급여
                    from employees
                    where hire_date >= '2005/01/01'
                    group by manager_id) m
where e.employee_id = m.manager_id
and 매니저별평균급여 > 5000
order by 매니저별평균급여 desc;


-- 문제4.
-- 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 
-- 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
-- 부서가 없는 직원(Kimberely)도 표시합니다. (106명)
select  e.employee_id 사번,
        e.first_name 이름,
        d.department_name 부서명,
        m.first_name 매니저이름
from employees e, employees m,departments d 
where e.manager_id = m.employee_id
and   e.department_id = d.department_id(+);


-- 문제5.
-- 2005년 이후 입사한 직원중에서 입사일이 11번째에서 20번째인 직원의
-- 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
select *
from (select rownum 순번,
                    사번,
                    이름,
                    부서명,
                    급여,
                    입사일
            from (  select  e.employee_id 사번,
                            e.first_name 이름,
                            d.department_name 부서명,
                            e.salary 급여,
                            e.hire_date 입사일
                    from employees e, departments d
                    where e.department_id = d.department_id
                    and   e.hire_date>='2005/01/01'
                    order by hire_date asc  )ot --order table
    ) 입사일순
where   순번>=11
and     순번<=20
;


-- 문제6.
-- 가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?

select  first_name||' '||last_name 이름,
        salary 연봉,
        department_name 부서이름,
        hire_date 입사일
from    employees e, departments d 
where   e.department_id = d.department_id
and     hire_date = (select max(hire_date)
                    from employees e)
;


-- 문제7.
-- 평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(first_name), 성(last_name)과 
-- 업무(job_title), 연봉(salary)을 조회하시오

select  e.employee_id 직원번호,
        e.first_name 이름,
        e.last_name 성,
        j.job_title 업무,
        e.salary 연봉
from    employees e, 
        jobs j,
        (select  rownum 순번,
                        부서아이디
                from   (select  avg(salary) 평균급여,
                                department_id 부서아이디
                        from employees 
                        group by department_id
                        order by 평균급여 desc)
                where rownum = 1
        )최고평균급여부서
where   e.department_id = 최고평균급여부서.부서아이디
and     e.job_id = j.job_id
order by e.salary asc
;


select  e.employee_id 직원번호,
        e.first_name 이름,
        e.last_name 성,
        j.job_title 업무,
        e.salary 연봉
from    employees e, 
        jobs j,(select  avg(salary) 평균급여,
                        department_id 부서아이디
                        from employees 
                        group by department_id) s
where   e.department_id = s.부서아이디
and     j.job_id = e.job_id
and     s.평균급여 = (select max(평균급여)
                     from  (select avg(salary) 평균급여,
                            department_id 부서아이디
                            from employees 
                            group by department_id))
order by e.salary asc
;



-- 문제8.
-- 평균 급여(salary)가 가장 높은 부서는?
select department_name 부서
from departments d,(select  rownum 순번,
                            부서아이디
                    from   (select  avg(salary) 평균급여,
                                    department_id 부서아이디
                            from employees 
                            group by department_id
                            order by 평균급여 desc) ot
                    )평균급여순
where   d.department_id = 부서아이디
and     순번 = 1
;


SELECT  d.department_name 부서
from    departments d, (select avg(salary) 평균급여,
                            department_id 부서아이디
                            from employees 
                            group by department_id) s
where   d.department_id = s.부서아이디
and     s.평균급여 = (select  max(평균급여)
                     from   (select avg(salary) 평균급여
                            from employees 
                            group by department_id)
                    )
;



-- 문제9.
-- 평균 급여(salary)가 가장 높은 지역은?
select ot.지역명
from (  select  rownum 순번,
                avgt.지역명
        from ( select   지역명,
                        avg(급여) 평균급여
                from (  select  region_name 지역명,
                                salary 급여
                        from employees e, departments d, locations l, countries c, regions r
                        where   e.department_id = d.department_id
                        and     d.location_id = l.location_id
                        and     l.country_id = c.country_id
                        and     c.region_id = r.region_id) st -- 급여
                group by 지역명
                order by 평균급여 desc
             ) avgt -- 평균급여
        )ot -- 순서정리
where 순번=1
;


-- 문제10.
-- 평균 급여(salary)가 가장 높은 업무는?
select 업무
from (  select  rownum 순번,
                업무
        from (  select  업무,
                        avg(급여) 평균급여
                from (  select  e.employee_id 사번,
                                e.salary 급여,
                                j.job_title 업무
                        from employees e, jobs j
                        where   e.job_id = j.job_id) ej
                group by 업무
                order by 평균급여
                ) 업무별평균급여
)
where   rownum =1
;

