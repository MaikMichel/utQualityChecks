set define '^'
set verify off

@../env.sql

prompt
prompt
prompt **********************************************************************
prompt ***  USER CREATION: ^db_app_user
prompt **********************************************************************
prompt
prompt

prompt ^db_app_user droppen
declare
  v_check number(1) := 0;
begin
  select 1
    into v_check
    from all_users
   where username = upper('^db_app_user');
  dbms_output.put_line('drop user ^db_app_user cascade');
  execute immediate 'drop user ^db_app_user cascade';
exception
  when no_data_found then
    null; -- ok, nothing to drop  ´
end;
/

prompt create user ^db_app_user identified by "^db_app_pwd" default tablespace ^deftablespace
create user ^db_app_user
  identified by "^db_app_pwd"
  default tablespace ^deftablespace
  temporary tablespace temp
  profile default
  account unlock;


-- 2 roles for ^db_app_user
grant connect to ^db_app_user;
alter user ^db_app_user default role all;
grant create any context to ^db_app_user;

prompt **********************************************************************
prompt
prompt-- 2 tablespace quotas for utx
alter user utx quota unlimited on ^deftablespace;


-- 11 system privileges for utx
grant create any context to utx;
grant create any directory to utx;
grant create any procedure to utx;
grant create job to utx;
grant create procedure to utx;
grant create sequence to utx;
grant create synonym to utx;
grant create public synonym to utx;
grant create table to utx;
grant create trigger to utx;
grant create type to utx;
grant create view to utx;
grant create session to utx;

-- 5 object privileges for utx
grant execute on sys.dbms_crypto to utx;
grant execute on sys.utl_file to utx;
grant execute on sys.utl_http to utx;
grant execute on sys.dbms_rls to utx;


prompt **********************************************************************
prompt
prompt