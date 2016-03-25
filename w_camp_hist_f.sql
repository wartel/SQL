-- SDE Camp Hist F

select count(*)
from siebel.s_camp_con@siebel;

/* 
result on 17/03/2016 is 70321 records
*/

select count(*) 
from siebel.s_src@siebel;

/*
result on 17/03/2016 is 32258 records
*/

select count(*)
from siebel.s_camp_con@siebel
inner join siebel.s_src@siebel on s_camp_con.src_id=s_src.row_id
;

/*
result on 17/03/2016 is 70321 records. This means that all records in s_camp_con has an src_id in the s_src table
*/

-- get results with filters for prospect sde applied
select count(*)
from siebel.s_camp_con@siebel
inner join siebel.s_src@siebel on s_camp_con.src_id=s_src.row_id
where s_camp_con.prsp_con_per_id is not null
and s_camp_con.con_per_id is null;

-- get results with filters for contact sde applied
select count(*)
from siebel.s_camp_con@siebel
inner join siebel.s_src@siebel on s_camp_con.src_id=s_src.row_id
where s_camp_con.con_per_id is not null;

-- get records that do not meet the criteria of the filters in the where clause
select * 
from siebel.s_camp_con@siebel
inner join siebel.s_src@siebel on s_camp_con.src_id=s_src.row_id
where s_camp_con.con_per_id is null
and s_camp_con.prsp_con_per_id is null;

-- get total number of records in staging table
select count(*)
from w_camp_hist_fs;

-- get total number of records in the target table
select count(*)
from w_camp_hist_f;

-- get records that are in the target, but not in the source
select count(*)
from w_camp_hist_f
where integration_id not in (
  select s_camp_con.row_id
  from siebel.s_camp_con@siebel
  inner join siebel.s_src@siebel on s_camp_con.src_id=s_src.row_id
  where s_camp_con.prsp_con_per_id is not null
  and s_camp_con.con_per_id is null
  union all
  select s_camp_con.row_id
  from siebel.s_camp_con@siebel
  inner join siebel.s_src@siebel on s_camp_con.src_id=s_src.row_id
  where s_camp_con.con_per_id is not null
  );

-- records in source that are not in the target table
select count(*) 
from siebel.s_camp_con@siebel
where s_camp_con.row_id not in (
  select integration_id
  from w_camp_hist_f
  );