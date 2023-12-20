with cte1 as (select 
	s.date,
    s.product_code,
    p.product , p.variant,
    s.sold_quantity,
	round(g.gross_price,2) as gross_price_per_item,
    round(s.sold_quantity*g.gross_price,2) as gross_price_total,
    pre.pre_invoice_discount_pct
from fact_sales_monthly s
join dim_product p
	on s.product_code = p.product_code
join fact_gross_price g
	on g.fiscal_year = s.fiscal_year
    and g.product_code = s.product_code
join fact_pre_invoice_deductions pre
	on pre.customer_code = s.customer_code and
    pre.fiscal_year = s.fiscal_year
where
    s.fiscal_year = 2021)
    
select * , round(gross_price_total - gross_price_total*pre_invoice_discount_pct,2) as net_invoice_sales
from cte1;

#using the view created.  NOTE : sales_pre_invoice_discount is a view created.
SELECT 
	*,
    round(gross_price_total*(1- pre_invoice_discount_pct),2) as net_invoice_sales
FROM sales_pre_invoice_discount;


SELECT 
	*,
    round(gross_price_total*(1- pre_invoice_discount_pct),2) as net_invoice_sales,
    po.discounts_pct + po.other_deductions_pct as total_po_disc_pct
FROM sales_pre_invoice_discount s
join fact_post_invoice_deductions po
on po.customer_code = s.customer_code and
   po.product_code  = s.product_code and
   po.date = s.date;
    


#net_invoice_sales is another view ; so is net_sales
SELECT *,
	round(net_invoice_sales*(1 - total_po_disc_pct),2) as net_sales
 FROM post_invoice_discount;
 
 