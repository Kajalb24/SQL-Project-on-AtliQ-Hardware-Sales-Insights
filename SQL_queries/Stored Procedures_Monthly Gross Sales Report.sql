select sum(s.sold_quantity)
from fact_sales_monthly s
join dim_customer c 
on s.customer_code = c.customer_code
where get_fy(s.date) = 2021 and c.market = "India"
group by c.market; 


select sum(s.sold_quantity)
from fact_sales_monthly s
join dim_customer c 
on s.customer_code = c.customer_code
where year(s.date) = 2018 and c.market = "India";
-- group by c.market;


select get_fy('2020-09-01');


select sum(s.sold_quantity)
from fact_sales_monthly s
join dim_customer c 
on s.customer_code = c.customer_code
where year(date_add(s.date, interval 4 month)) = 2018 and c.market = "India";

select c.market , sum(s.sold_quantity) as total_qty
from fact_sales_monthly s
join dim_customer c 
on s.customer_code = c.customer_code
where year(date_add(s.date, interval 4 month)) = 2021
group by c.market;
