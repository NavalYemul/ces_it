-- sales
create streaming table bronze.sales as 
select *, current_timestamp() as ingestion_date from stream read_files("/Volumes/pipeline/default/input_files/sales/",format=>"csv");

--products
create streaming table bronze.products as 
select *,current_timestamp() as ingestion_date from stream read_files("/Volumes/pipeline/default/input_files/products/",format=>"csv");

--customer
create streaming table bronze.customers as 
select *,current_timestamp() as ingestion_date from stream read_files("/Volumes/pipeline/default/input_files/customers/",format=>"csv");


