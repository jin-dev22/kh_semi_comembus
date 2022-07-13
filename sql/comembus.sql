--=============================
-- 관리자 계정
--=============================
-- comembus계정 생성

create user comembus identified  by Zhapaqjtm2022  default tablespace users;
alter user comembus quota unlimited on users;
grant connect, resource, create view to comembus;

--=============================
--코멤버스 계정   -> 관리자 설정 여기에 적어둬도 되는지 물어보기(깃헙에 공유되는데 보안문제가 있을것 같음)
--=============================
SELECT * FROM USER_TABLES;--생성된 테이블 확인
-- 수진 코드 시작
CREATE TABLE member (
	member_id	varchar2(12)		NOT NULL,
	job_code	char(2)		NOT NULL,
	member_nickname	varchar2(30)		NOT NULL,
	member_name	varchar2(50)		NOT NULL,
	password	varchar2(300)		NOT NULL,
	phone	char(11)		NOT NULL,
	introduction	clob		NULL,
	member_role	char(1)	DEFAULT 'M' 	NOT NULL,
	enroll_date	date	DEFAULT sysdate	NOT NULL,
	quit_date	date		NULL,
	quit_yn	char(1)	DEFAULT 'N'	NOT NULL,
    constraint pk_member_id primary key (member_id),
    constraint ck_job_code check(job_code in('PL', 'GD', 'BE', 'FE')),
    constraint ck_member_role check(member_role in ('M', 'A')),
    constraint ck_member_quit check(quit_yn in ('N', 'Y'))
);
select * from member;
insert into member values ('test', 'BE', 'tester', '홍길동','1234', '01012341234', '안녕하세요', default, default, null, default);
commit;



COMMENT ON COLUMN member.member_id IS '회원 아이디';
COMMENT ON COLUMN member.job_code IS '회원 직무분야 코드';
COMMENT ON COLUMN member.member_nickname IS '회원 닉네임';
COMMENT ON COLUMN member.member_name IS '회원 이름';
COMMENT ON COLUMN member.password IS '회원 비밀번호';
COMMENT ON COLUMN member.phone IS '회원 휴대폰번호';
COMMENT ON COLUMN member.introduction IS '회원 자기소개';
COMMENT ON COLUMN member.member_role IS '회원 권한 M/A';
COMMENT ON COLUMN member.enroll_date IS '회원 가입일시';
COMMENT ON COLUMN member.quit_date IS '회원 탈퇴일시';
COMMENT ON COLUMN member.quit_yn IS '회원 탈퇴여부';

CREATE TABLE department (
	job_code	char(2)		NOT NULL,
	job_name	varchar2(30)		NOT NULL,
    constraint pk_job_code primary key (job_code)
);
COMMENT ON COLUMN department.job_code IS '직무분야 코드';
COMMENT ON COLUMN department.job_name IS '기획 / 디자인 / 프론트 / 백엔드';

CREATE TABLE notice (
	notice_no	number		NOT NULL,
	writer	varchar2(12)		NOT NULL,
	title	varchar2(500)		NOT NULL,
	content	varchar2(4000)		NOT NULL,
	read_count	number	DEFAULT 0	NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
    constraint pk_notice_no primary key(notice_no),
    constraint fk_writer foreign key  (writer) references member(member_id) on delete set null
);
COMMENT ON COLUMN notice.notice_no IS '공지사항 번호';
COMMENT ON COLUMN notice.member_id IS '작성자(관리자)아이디';
COMMENT ON COLUMN notice.title IS '공지사항 제목';
COMMENT ON COLUMN notice.content IS '공지사항 내용';
COMMENT ON COLUMN notice.read_count IS '공지사항 조회수';
COMMENT ON COLUMN notice.reg_date IS '공지사항 작성일';


commit;
--수진 코드 끝

--선아님 코드 시작

--선아님 코드 끝

--태연님 코드 시작

--태연님 코드 끝

--미송님 코드 시작

--미송님 코드 끝