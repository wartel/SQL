--SDE_CustomerAttributeFact.WC_PARTY_ATTR_FS
--SIL_CustomerAttributeFact.WC_PARTY_ATTR_F

/* The source of the staging table WC_PARTY_ATTR_FS is a file
I do not have acces to this file
therefore it is not possible for me to check if the content is loaded properly
*/


-- count number of records in staging table

select count(*)
from wc_party_attr_fs;

-- count number of records in target table

select count(*)
from wc_party_attr_f;

-- check if records from staging table are in target table, based on integration_id and datasource_num_id
-- if all records are in the target, the output should be 0
select count(*) 
from wc_party_attr_fs
where integration_id not in (
  select wc_party_attr_f.integration_id from wc_party_attr_f
  where wc_party_attr_f.datasource_num_id = wc_party_attr_fs.datasource_num_id);
  
-- check if records from target are in staging table
-- if all records are loaded, the output should be 0
select count(*)
from wc_party_attr_f
where integration_id not in (
  select integration_id from wc_party_attr_fs
  where wc_party_attr_fs.datasource_num_id = wc_party_attr_f.datasource_num_id);
  
  
  
  

