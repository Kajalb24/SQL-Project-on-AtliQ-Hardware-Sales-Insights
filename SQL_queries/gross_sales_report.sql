SELECT 
DATE_FORMAT(s.date, '%b %y') AS month, get_fy(s.date) as fiscal_year,
round(sum(s.sold_quantity*gp.gross_price),2) as gross_price_amt
from fact_sales_monthly s
join fact_gross_price gp
on 
	gp.product_code = s.product_code and
    gp.fiscal_year = get_fy(s.date)
where customer_code = 90002002
group by s.date
order by s.date asc;


                            -- ================================== --

SELECT 
    get_fy(s.date) AS fiscal_year,
    ROUND(SUM(s.sold_quantity * gp.gross_price), 2) AS gross_price_amt
FROM fact_sales_monthly s
JOIN fact_gross_price gp ON gp.product_code = s.product_code AND gp.fiscal_year = get_fy(s.date)
WHERE customer_code = 90002002
GROUP BY get_fy(s.date)
ORDER BY fiscal_year ASC;



--    ===============================