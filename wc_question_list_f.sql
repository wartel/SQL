-- Question List

-- get number of records from the source table(s)

select count(*)
from siebel.s_comm_svy_log@siebel;

-- get number of records of the staging table

select count(*) 
from WC_QUESTION_LIST_FS;

-- get number of records in the target table

select count(*)
from wc_question_list_f
where datasource_num_id = 1;

-- number of records in target that are not in the source

select count(*)
from wc_question_list_f
where integration_id not in (
  select s_comm_svy_log.row_id
  from siebel.s_comm_svy_log@siebel
  );
  
-- select records in target, not in source
select count(*)
from wc_question_list_f
where datasource_num_id = 1
and integration_id not in (
  select s_comm_svy_log.row_id
  from siebel.s_comm_svy_log@siebel
  );

-- get records in target, with 
select count(*)
from wc_question_list_f
where datasource_num_id = 1 
and integration_id in (
  select s_comm_svy_log.row_id
  from siebel.s_comm_svy_log@siebel
  );
-- number of records that are in source but not in target

select count(*)
from siebel.s_comm_svy_log@siebel
where s_comm_svy_log.row_id not in (
  select integration_id 
  from wc_question_list_f
  where datasource_num_id = 1
  );

-- records in source that are in target
select count(*)
from siebel.s_comm_svy_log@siebel
where s_comm_svy_log.row_id in (
  select integration_id 
  from wc_question_list_f
  where datasource_num_id = 1
  );
  
-- check for differtent data sources
select DATASOURCE_NUM_ID, count(*)
from wc_question_list_f
group by DATASOURCE_NUM_ID;

