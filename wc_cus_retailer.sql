-- records in source table

select count(*)
from siebel.s_party_rel@siebel;

-- records in staging table

select count(*)
from wc_cus_retailer_fs;

-- records in target table

select count(*)
from wc_cus_retailer_f;

-- nr of records in source, not in target

select count(*)
from siebel.s_party_rel@siebel
where s_party_rel.row_id not in (
  select integration_id
  from wc_cus_retailer_f
  );

-- records in source, not in target

select *
from siebel.s_party_rel@siebel
where s_party_rel.row_id not in (
  select integration_id
  from wc_cus_retailer_f
  );
  
-- records in target, not in source
select count(*)
from wc_cus_retailer_f
where integration_id not in (
  select s_party_rel.row_id
  from siebel.s_party_rel@siebel
  );
  
-- records in target, in source
select count(*)
from wc_cus_retailer_f
where integration_id in (
  select s_party_rel.row_id
  from siebel.s_party_rel@siebel
  );