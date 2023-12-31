
select  s.date, s.product_code, p.product, p.variant, c.market,
s.sold_quantity,  g.gross_price, pre.pre_invoice_discount_pct,
round(g.gross_price*s.sold_quantity,2) as gross_price_total
from fact_sales_monthly s
join dim_customer c 
on s.customer_code=c.customer_code
join dim_product p
on p.product_code=s.product_code
join fact_gross_price g 
on g.product_code= s.product_code and 
   g.fiscal_year=s.fiscal_year
join fact_pre_invoice_deductions  pre
on pre.customer_code=s.customer_code and 
pre.fiscal_year=s.fiscal_year 
limit 1000000;