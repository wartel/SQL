-- Check DEV_DW.PARTYDOC_F

-- check number of records in the source table which are candidates for loading into staging table
select count(*)
from siebel.cx_party_xm@siebel
where upper(cx_party_xm.type)='DOC';

-- check records in source table
select *
from siebel.cx_party_xm@siebel
where upper(cx_party_xm.type)='DOC';

-- check number of records in staging table (wc_partydoc_fs)
select count(*)
from wc_partydoc_fs;

-- check number of records in target table (wc_partydoc_f). 28
select count(*)
from wc_partydoc_f;

-- check records in target table (wc_partydoc_f)
select * 
from wc_partydoc_f;

-- differences between source and target. records in source, not in target.
select * from siebel.cx_party_xm@siebel
where 1=1
and upper(cx_party_xm.type)='DOC'
and row_id not in (
  select integration_id
  from wc_partydoc_f
  );
  
-- differences between target and source. records in target, not in source
select count(*) 
from wc_partydoc_f
where integration_id not in (
  select row_id
  from siebel.cx_party_xm@siebel
  );

select * 
from wc_partydoc_f
where integration_id not in (
  select row_id
  from siebel.cx_party_xm@siebel
  );
  
/* Conclusion for Custom_SDE_PartyDocFact and Custom_SIL_PartyDocFact
records are all loaded from source table (cx_party_xm) to staging table (wc_partydoc_fs) to target (wc_partydoc_f)
All records from the source are in the target. However there are more records in the target than in the source.