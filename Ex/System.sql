-- ppt. 계정관리 
-- 빨간글씨는 명령어

/************************************
* 계정관리 (DCL)

************************************/

-- 계정만들기
create user webdb identified by 1234;

-- 권한설정
grant resource, connect to webdb;

-- 비밀번호 변경
alter user webdb identified by webdb;

-- 계정 삭제
drop user webdb cascade;


-- hr/hr
-- system / manager
-- webdb / webdb
