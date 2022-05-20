/* 초기화 작업 */
-- 북 테이블 삭제
drop table book;
-- 북 시퀀스 삭제
drop sequence seq_book_id;
-- 작가 테이블 삭제
drop table author;
-- 작가 시퀀스 삭제
drop sequence seq_author_id;

--------------------------------작가 테이블-------------------------------------

-- 작가 테이블 생성
create table author(
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    PRIMARY KEY (author_id)
);


-- 작가 시퀀스 생성
create sequence seq_author_id
INCREMENT by 1
start with 1
nocache;


-- 작가 테이블 데이터 추가
/*insert into author
values (seq_author_id.nextval, '김문열', '경북 영양');*/
-- 작가 테이블 데이터 추가

-- COMMIT WORK;

-- author 수정
update author
set author_name = '최문열',
    author_desc = '서울특별시'; -- 이렇게 하면 모든 행 수정

delete from author
where  author_id = 5;


-- 자바에서 전체 조회를 위해 *대신 모든 열 작성
select  author_id,
        author_name,
        author_desc
from author;

rollback;   -- 이클립스에서 마지막흐로 추가 실행한 시점으로 돌아가기


---------------------------------북 테이블-------------------------------------\

-- 북 테이블 생성
create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id)
);


-- 북 시퀀스 생성 
create sequence seq_book_id
increment by 1
start with 1
nocache;


-- 북테이블 데이터 추가
insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2022-03-01', 1);

COMMIT WORK;

-- 북 테이블 조회
select  book_id,
        title,
        pubs,
        pub_date,
        author_id
from book;
