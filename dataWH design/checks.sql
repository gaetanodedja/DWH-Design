-- info about tables
show tables;
/*metadata_additional_price_rates
order_informations
order_items
product_groups
products
regions*/
describe regions;
describe products;
describe product_groups;
describe order_informations;
describe order_items;
describe metadata_additional_price_rates;

-- info needed for Date dimension and currency rate
select min(order_date) from order_informations;
select distinct currency from order_items;

-- checking volume
select count(*) from order_items;
select count(*) from order_informations;

-- checkig quality
select item_ID,count(*) from order_items
group by item_ID
having count(*) > 1;

select order_ID,count(*) from order_informations
group by order_ID
having count(*) > 1;

select i.item_ID, o.order_ID from order_items i 
right join order_informations o on i.order_ID = o.order_ID
where i.item_ID is null;

select distinct i.product_ID from order_items i 
left join products p on i.product_ID = p.ID
where p.ID is null;
/* 
'0',
'null',
'666',
'1141',
'673',
'307',
'329'
*/

select distinct shipping_country_ID from order_informations i   -- order_country_ID
left join regions r on i.shipping_country_ID = r.ID
where r.ID is null;

