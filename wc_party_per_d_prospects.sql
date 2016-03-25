-- check nr records in source tables
select count(*)
from siebel.s_prsp_contact@siebel a left outer join siebel.s_prsp_con_x@siebel x on s_prsp_contact.row_id = s_prsp_con_x.par_row_id
inner join tab b on a.hfhfh=b.hdhdyhd;

-- check nr of records in source tables (s_prsp_contact and s_prsp_con_x)
select count(*)
from siebel.s_prsp_contact@siebel
, siebel.s_prsp_con_x@siebel
where s_prsp_contact.row_id = s_prsp_con_x.par_row_id(+);

--check records in source table
select s_prsp_contact.row_id
from siebel.s_prsp_contact@siebel
, siebel.s_prsp_con_x@siebel
where s_prsp_contact.row_id = s_prsp_con_x.par_row_id(+);

--check nr of records in staging table 
select count(*)
from w_party_per_ds;

-- check for relevant integration id's in staging table
select count(*) 
from w_party_per_ds
where integration_id in (
  select s_prsp_contact.row_id
  from siebel.s_prsp_contact@siebel
  , siebel.s_prsp_con_x@siebel
  where s_prsp_contact.row_id = s_prsp_con_x.par_row_id(+)
  );
  
-- check nr of records in target table with integration_id = source.row_id
select count(*)
from w_party_per_d
where integration_id in (
  select s_prsp_contact.row_id
  from siebel.s_prsp_contact@siebel
  , siebel.s_prsp_con_x@siebel
  where s_prsp_contact.row_id = s_prsp_con_x.par_row_id(+)
  );

-- check nr of records with integration_id = source.row_id

select distinct contact_type_code
from w_party_per_d;

