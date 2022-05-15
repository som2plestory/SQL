/* 테이블간 조인(JOIN) SQL */

-- 문제1.
-- 직원들의 사번(employee_id), 이름(first_name), 성(last_name)과 부서명(department_name)을 조회하여
-- 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순으로 정렬하세요. (106건)
select  em.employee_id 사번,
        em.first_name 이름,
        em.last_name 성,
        de.department_name 부서명
from employees em, departments de
order by department_name asc,
         employee_id desc;
         
         
-- 문제2.
-- employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
-- 직원들의 사번(employee_id), 이름(first_name), 급여(salary), 부서명(department_name)
-- 현재업무(job_title)를 사번(employee_id)오름차순으로 정렬하세요.
-- 부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.(106건)
select  e.employee_id 사번,
        e.first_name 이름,
        e.salary 급여,
        d.department_name 부서명,
        j.job_title 현재업무
from employees e, department_name d, jobs j
order by employee_idd asc;
