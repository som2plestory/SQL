
-- 작가 테이블 만들기
Create table author(
    author_id number(10),
    author_name varchar2(100) not null, 
    author_desc varchar2(500),
    primary key(author_id)
);

/****************************** SEQUENCE(시퀀스) ****************************
 ********* SEQUENCE **********
 ■ 시퀀스 생성
    - 연속적인 일렬번호 생성 > PK에 주로 사용됨
    CREATE SEQUENCE 시퀀스이름
    INCREMENT BY 숫자(씩 올라가게) 
    START WITH 숫자 (처음숫자)
    nocache;
 ■ 시퀀스 사용
    INSERT INTO 테이블이름
    VALUES (시퀀스이름.nextval, 추가할 테이블 행 데이터);
***************************************************************************/

-- 작가 시퀀스 만들기
create sequence seq_author_id
increment by 1
start with 1
nocache;

insert into author
values (seq_author_id.nextval, '박경리', '토지작가');

insert into author
values (seq_author_id.nextval, '이문열', '삼국지 작가');

insert into author
values (seq_author_id.nextval, '기안84', '웹툰작가');

insert into author
values (seq_author_id.nextval, 'SOM2', 'SOM2PLESTORY');

insert into author
values (seq_author_id.nextval, '유재석', '개그맨');


select *
from author;


/****************************** SEQUENCE(시퀀스) ****************************
 ■ 시퀀스 조회
    SELECT *
    FROM USER_SEQUENCES ;
 ■ 현재 시퀀스 조회
    SELECT 시퀀스이름.currval
    FROM dual ;
 ■ 다음 시퀀스 조회
    SELECT 시퀀스이름.nextval
    FROM dual ;
 ■ 시퀀스 삭제
    DROP SEQUENCE 시퀀스이름 ;
***************************************************************************/

select *
from user_sequences;

select seq_author_id.currval
from dual;

select seq_author_id.nextval
from dual;

drop sequence seq_author_id;

-- 이전에 커밋한 상태로 돌림
rollback;

select *
from author;


-- 지금까지 자료 저장
commit;

insert into author
values (seq_author_id.nextval, '이효리', '가수');

rollback;

-----------------------------------------------------------
-- 작가 테이블 삭제
drop table author;
-- 작가 시퀀스 삭제
drop sequence seq_author_id;

-- 작가 테이블 만들기
Create table author(
    author_id number(10),
    author_name varchar2(100) not null, 
    author_desc varchar2(500),
    primary key(author_id)
);

-- 작가 시퀀스 만들기 
create sequence seq_author_id
INCREMENT by 1
start with 1
nocache;

-- 작가 데이터 추가
insert into author
values (seq_author_id.nextval, '박경리', '토지작가');

insert into author
values (seq_author_id.nextval, '이문열', '삼국지작가');

insert into author
values (seq_author_id.nextval, '기안84', '웹툰작가');

update author
set author_name = '자취84',
    author_desc = '나혼자산다 출연'
where author_id = 3;    

-- 블럭지정해서 실행하면 블럭 내에 있는 것 모두 실행

-- 작가 테이블 조회하기
select *
from author;

-- 작가 시퀀스 조회하기
select *
from user_sequences;