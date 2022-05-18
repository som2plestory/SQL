-- book이라는 테이블 생성
create table book(
-- 열생성 : 열이름 / 데이터종류
-- number(5) : 숫자 데이터 5자리
    book_id number(5),
-- varchar2(50) : 가변길이 문자열 size 
    title varchar2(50),
-- varchar : varchar2와 동일
    author varchar(10),
-- date : 날짜/시간
    pub_date date
);

-- book테이블에 pubs라는 열을 데이터종류 varchar2(5)로 추가 
alter table book add(pubs varchar2(5));

-- book테이블에 title/pubs라는 열의 데이터종류/사이즈를 변경
alter table book modify(title varchar2(100));
alter table book modify(pubs varchar2(50));

-- book테이블의 title 열을 subject로 이름을 바꿈
alter table book rename column title to subject;

-- book테이블의 이름을 article로 변경
rename book to article;

select *
from article;

-- book테이블 삭제
drop table book;