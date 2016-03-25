-- records in source table

select count(*)  
from siebel.cx_c2v2retailer@siebel
left outer join siebel.s_asset@siebel on cx_c2v2retailer.x_asset_id=s_asset.row_id
left outer join siebel.s_prod_int@siebel on s_asset.ref_number_2=s_prod_int.name;

select count(*)
from siebel.s_prod_int@siebel
right outer join siebel.s_asset@siebel on s_prod_int.name=s_asset.ref_number_2
right outer join siebel.cx_c2v2retailer@siebel on s_asset.row_id=cx_c2v2retailer.x_asset_id;
/*
No records in the source table
*/

-- records in the staging table
select * 
from wc_cus_veh_retailer_fs
;

/*
There are no records in the staging table
*/

select count(*) 
from wc_cus_veh_retailer_f
;

/*
There are 20 records in the target table. It is unclear what the source has been. The current source has no records
*/
