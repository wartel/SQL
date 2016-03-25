-- WC_CUS_VEH_CONTRACT_FACT

-- check number of records in source tables that are to be loaded

select count(*)
from siebel.s_asset_con@siebel
inner join siebel.s_asset@siebel on s_asset_con.asset_id=s_asset.row_id
left outer join siebel.s_prod_int@siebel on s_asset.ref_number_2=s_prod_int.name;


-- check nr of records in s_asset_con table. result is approx 13.7 million records
select count(*) 
from siebel.s_asset_con@siebel;

-- check nr of records in s_asset table. result is approx 35 million records
select count(*) 
from siebel.s_asset@siebel;

-- check nr of records as a result of an inner join on s_asset_con.asset_id = s_asset.row_id. Also approx 13.7 million records
select count(s_asset_con.row_id)
from s_asset_con@siebel
, s_asset@siebel
where 1=1
and s_asset_con.asset_id = s_asset.row_id
;

--check number of records in table s_prod_int. result is 712 million records
select count(*) from s_prod_int@siebel;  

-- check number of records in the staging table. Expected to be 0 when all records are purged to target table.
select count(integration_id)
from wc_cus_veh_contract_fs;

-- records not in staging table that are in target
select count(integration_id)
from wc_cus_veh_contract_fs
where integration_id not in (
  select integration_id 
  from wc_cus_veh_contract_f
  );

-- records  in target, but are in staging
select count(integration_id)
from WC_CUS_VEH_CONTRACT_F
where integration_id not in (
  select integration_id
  from wc_cus_veh_contract_fs
  );

-- check number of records in the target table. Expected to be equal to the number of records in the source table.
select count(integration_id)
from wc_cus_veh_contract_f;

/* There are a lot more records in the source tables then there are in the staging and target tables of the warehouse. 
I cannot detect any extra filters in the mapping. So I am not sure why there is loaded so less data...