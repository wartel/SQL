/* There are two mappings that map to the staging table wc_cus_veh_cus_prod_fs 
SDE_CustomerVehicleCustomerProductFact_Product
SDE_CustomerVehicleCustomerProductFact_Vehicle

*/

-- check nr records in source tables

-- SDE_CustomerVehicleCustomerProductFact_Product
select count(*)
from siebel.cx_cust2product@siebel 
left outer join siebel.s_org_ext@siebel on cx_cust2product.x_account_id=s_org_ext.row_id ;

-- SDE_CustomerVehicleCustomerProductFact_Vehicle
select count(*)
from siebel.s_asset_con@siebel
inner join siebel.s_asset@siebel on s_asset_con.asset_id=s_asset.row_id
left outer join siebel.s_prod_int@siebel on s_asset.ref_number_2=s_prod_int.name;

--check nr of records in staging table 
select count(*) 
from wc_cus_veh_cus_prod_fs;

-- check nr of records in target table
select count(*) 
from wc_cus_veh_cus_prod_f;

-- check nr of records in target table with integration_id matches integration id from staging table
select count(*)
from wc_cus_veh_cus_prod_f
where integration_id in (
  select integration_id
  from WC_CUS_VEH_CUS_PROD_FS
  );





