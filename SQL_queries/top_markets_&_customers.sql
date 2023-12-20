select 
	market , 
	sum(net_sales) 
from net_sales
where fiscal_year = 2021
group by market;

select * from net_sales where year(date) = 2021;

select * from net_sales where market = "Brazil";