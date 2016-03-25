--

-- check nr records in source tables


-- check nr records in source tables


-- check nr of records in source tables (s_prsp_contact and s_prsp_con_x)


--check records in source table


--check nr of records in staging table 
select count(*) 
from wc_asset_order_fs
;

-- check nr of records in target table
select count(*) 
from wc_asset_order_f
;

-- check nr of records in target table with integration_id matches integration id from staging table
select count(*)
from wc_asset_order_f
where integration_id in (
  select integration_id
  from wc_asset_order_fs
  );

-- check nr of records in target table with an integration id that is not in the staging table
select count(*)
from wc_asset_order_f
where integration_id not in (
  select integration_id
  from wc_asset_order_fs
  );


