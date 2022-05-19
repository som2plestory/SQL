/****************************** DDL - 테이블관리 ****************************
 ********* 제약조건 **********
 - NOT NULL : NULL값 입력불가
 - UNIQUE : 중복값 입력불가(NULL값은 허용)
 - PRIMARY KEY : NOT NULL + UNIQUE (데이터들끼리 유일성을 보장하는 칼럼에 설정)
                 테이블당 1개만 설정 가능 (여러가지를 묶어서 설정 가능)  -- PK
 - FOREIGN KEY = 외래키(FK) : 다른 테이블과 연결
                 일반적으로 REFERENCE 테이블의 PK를 참조
                 REFERENCE 테이블에 없는 값은 삽입 불가
                 REFERENCE 테이블의 레코드 삭제 시 동작
                 반드시 참조테이블에 UNIQUE 또는 PRIMARY KEY가 설정되어 있어야함
            - ON DELETE CASCADE  : 해당하는 FK를 가진 참조행도 삭제
            - ON DELETE SET NULL : 해당하는 FK를 NULL로 변경 
        CONSTARINT 제약조건이름 FOREIGN KEY(필드이름)
        REFERENCES 테이블이름(필드이름)
 - DEFAULT : 기본값 설정
***************************************************************************/

-- 테이블 생성
Create table author(
    author_id number(10),
    -- 데이터가 비어있으면 오류 발생
    author_name varchar2(100) not null, 
    author_desc varchar2(500),
    -- primary keys : 한 테이블 당 하나
    primary key(author_id)
);



/********************************** DML - INSERT ****************************
 ******** 테이블 관리 : DML(Data Manipulation Language, 데이터 조작어) *********
 ■ 묵시적 방법
    - 컬럼 이름, 순서 지정하지 않음
    - 테이블 생성시 정의한 순서에 따라 값 지정
    INSERT INTO 테이블이름
    VALUES 테이블 행 값 ;
 ■ 명시적 방법
    - 컬럼 이름 명시적 사용
    - 지정되지 않는 컬럼 NULL 자동입력
    INSERT INTO 테이블이름 (지정할 열 이름)
    VALUES 테이블 행의 지정할 열 값 (into 뒤 열 순서로 입력) ;
****************************************************************************/
 
-- 테이블 열 순서대로 데이터 입력하여 추가
insert into author
values (1, '박경리', '토지 작가');   -- cf) 자바 문자열 "", sql 문자열 ''
 
-- 추가할 열을 지정하여 데이터 추가
insert into author(author_id, author_name)
values (2, '이문열');

-- 명시적방법으로는 테이블의 열 순서와 상관없이 작성한 열 이름과 데이터 순서가 맞으면 추가 가능
INSERT INTO author(author_name, author_id)
values('기안84', 3);

-- author_name이 not null로 지정되어 있어 추가 불가능 : 오류 발생
insert into author(author_id)
values(4);



/********************************** DML - UPDATE ****************************
 ******** 테이블 데이터 수정 *********
 ■ 조건을 만족하는 레코드를 변경
    - 컬럼 이름, 순서 지정하지 않음
    - 케이블 생성시 정의한 순서에 따라 값 지정
    UPDATE 테이블이름
    SET 열이름 = 수정할 열에 따른 데이터값,
        열이름2 = 수정할 열에 따른 데이터값2 (...) ;
    WHERE 조건 ;
 ■ WHERE 절이 생략되면 모든 레코드에 적용
    UPDATE 테이블이름
    SET 열이름 = 수정할 열에 따른 데이터값,
        열이름2 = 수정할 열에 따른 데이터값2 (...) ;
****************************************************************************/

-- 데이터 수정
update author
set author_desc = '삼국지 작가'
where author_id = 2;

-- where 지정안해주면 모든 레코드에 적용(주의)
update author
set author_desc = '웹툰작가';

update author
set author_name = '김경리',
    author_desc = '토지 작가'
where author_id = 1;



/********************************** DML - DELET ****************************
******** 테이블 데이터 삭제 *********
 ■ 조건을 만족하는 레코드를 삭제
    DELETE FROM 테이블이름 ;
    WHERE 조건
 ■ 조건이 없으면 모든 데이터 삭제(주의)
    DELETE FROM 테이블이름 ;
****************************************************************************/

-- 데이터 삭제
delete from author
where author_id =3;

select *
from author;


------------------------------------------------------------------------------
-- book 테이블 생성
create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100), -- 출판사
    pub_date date,  -- 인쇄날짜
    author_id number(10),
    primary key(book_id),
    -- author 테이블의 author_id 참조
    constraint book_fk foreign key(author_id)
    REFERENCES author(author_id)
);

-- 데이터 추가하기 : 1, 토지, 마로니에북스, 2012-08-15, 1
insert into book
VALUES (1, '토지', '마로니에북스', '2012-08-15', 1);

-- 데이터 추가 : 2, 삼국지, 민음사, 2002/03/01, 2
insert into book
values(2, '삼국지', '민음사', '2002/03/01', 2);


select *
from book;

-- 테이블 전부 삭제
drop table author;
drop table book;