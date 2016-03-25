
-- check number of rows in source s_party_rel 293
select count(*) from siebel.s_party_rel@siebel;

select * from siebel.s_party_rel@siebel;

-- check number of records in the source. Records that should be loaded are 287
select count(s_party_rel.row_id)
from siebel.s_party_rel@siebel
, siebel.s_org_ext@siebel
, siebel.s_contact@siebel 
where 1=1
and s_party_rel.rel_party_id = s_org_ext.row_id
and s_party_rel.party_id = s_contact.row_id;

-- check records in staging table (268)
select count(integration_id) 
from WC_ACCOUNT2CONTACT_FS;

-- differences between source and staging
select count(s_party_rel.row_id)
from siebel.s_party_rel@siebel
, siebel.s_org_ext@siebel
, siebel.s_contact@siebel 
where 1=1
and s_party_rel.rel_party_id = s_org_ext.row_id
and s_party_rel.party_id = s_contact.row_id
and siebel.s_party_rel.row_id not in (
  select integration_id 
  from WC_ACCOUNT2CONTACT_FS  
  );
  
-- differences between source and staging, s_party_rel.row_id
select s_party_rel.row_id
from siebel.s_party_rel@siebel
, siebel.s_org_ext@siebel
, siebel.s_contact@siebel 
where 1=1
and s_party_rel.rel_party_id = s_org_ext.row_id
and s_party_rel.party_id = s_contact.row_id
and siebel.s_party_rel.row_id not in (
  select integration_id 
  from WC_ACCOUNT2CONTACT_FS  
  );

-- check differences between source and target
select integration_id, count(*) from wc_account2contact_f group by integration_id
minus
select s_party_rel.row_id, count(*)
from siebel.s_party_rel@siebel
, siebel.s_org_ext@siebel
, siebel.s_contact@siebel 
where 1=1
and s_party_rel.rel_party_id = s_org_ext.row_id
and s_party_rel.party_id = s_contact.row_id
group by s_party_rel.row_id;

-- check number of records in the target table are 302
select count(integration_id) 
from WC_ACCOUNT2CONTACT_F;

-- check differences between source and target
select count(s_party_rel.row_id)
from siebel.s_party_rel@siebel
, siebel.s_org_ext@siebel
, siebel.s_contact@siebel 
where 1=1
and s_party_rel.rel_party_id = s_org_ext.row_id
and s_party_rel.party_id = s_contact.row_id
and siebel.s_party_rel.row_id not in (
  select integration_id 
  from WC_ACCOUNT2CONTACT_F
  );
  
-- check differences between target in source. Rows in target, not in source
select count (integration_id)
from wc_account2contact_f 
where integration_id not in (
  select s_party_rel.row_id
  from siebel.s_party_rel@siebel
  , siebel.s_org_ext@siebel
  , siebel.s_contact@siebel 
  where 1=1
  and s_party_rel.rel_party_id = s_org_ext.row_id
  and s_party_rel.party_id = s_contact.row_id
  );

select integration_id
from wc_account2contact_f 
where integration_id not in (
  select s_party_rel.row_id
  from siebel.s_party_rel@siebel
  , siebel.s_org_ext@siebel
  , siebel.s_contact@siebel 
  where 1=1
  and s_party_rel.rel_party_id = s_org_ext.row_id
  and s_party_rel.party_id = s_contact.row_id
  );

-- check if integration_id is unique in wc_account2contact_f
select integration_id, count(*)
from wc_account2contact_f
group by integration_id
having count(*)>1;

-- check which records have the same integration_id.
select * from wc_account2contact_f
where integration_id in ('1-1B2HV3B-Test1', '1-1B2HV3B')
order by integration_id;

/* Conclusions for Custom_SDE_PartyAccountContactFact and Custom_SIL_PartyAccountContactFact
load from source tables (s_party_rel, s_contact, s_org_ext) to staging table (wc_account2contact_fs) is complete. 
load from staging table (wc_account2contact_fs) to target table (wc_account2contact_f) is complete. 
However there are 15 records in the target that are not in the source.
13 that are not in the source at all:
2404
2406
2410
2411
2405
2408
1-1B2HV3L
1-1B2HV3B-Test1
1-1B2HV3B-Test1
2407
2409
1-1BB0LOX
2403

and the following integration_id is three times in the target. That is two times extra:
1-1B2HV3B
*/
