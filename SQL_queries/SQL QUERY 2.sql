select  s.date,
sum(round(g.gross_price*s.sold_quantity ,2)) as monthly_sales
from fact_sales_monthly s
join fact_gross_price g
on g.product_code= s.product_code and 
   g.fiscal_year=get_fiscal_year(s.date)
where customer_code=90002002  
group by s.date 
 order by date asc;
