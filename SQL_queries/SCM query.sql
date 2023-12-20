-- update fact_act_est
-- set sold_quantity = 0
-- where sold_quantity is null;

-- update fact_act_est
-- set forecast_quantity = 0
-- where forecast_quantity is null;

select 
		*,
		forecast_quantity - sold_quantity as net_err,
        (forecast_quantity- sold_quantity)*100/forecast_quantity as net_err_pct,
        abs(forecast_quantity- sold_quantity) as abs_err,
        abs(forecast_quantity- sold_quantity)*100/forecast_quantity as abs_err_pct
from fact_act_est where fiscal_year = 2021;



select  customer_code, fiscal_year, sum(sold_quantity) as sold_qty, sum(forecast_quantity) as forecast_qty,
		sum(forecast_quantity - sold_quantity) as net_err,
        sum(forecast_quantity- sold_quantity)*100/sum(forecast_quantity) as net_err_pct,
        sum(abs(forecast_quantity- sold_quantity)) as abs_err,
        sum(abs(forecast_quantity- sold_quantity))*100/sum(forecast_quantity) as abs_err_pct
from fact_act_est where fiscal_year = 2021
group by customer_code
order by abs_err_pct desc ;


select 
		sum(forecast_quantity - sold_quantity) as net_err,
        sum(forecast_quantity- sold_quantity)*100/sum(forecast_quantity) as net_err_pct,
        sum(abs(forecast_quantity- sold_quantity)) as abs_err,
        sum(abs(forecast_quantity- sold_quantity))*100/sum(forecast_quantity) as abs_err_pct
from fact_act_est where fiscal_year = 2021
group by customer_code;



select  customer_code, fiscal_year, sum(sold_quantity) as sold_qty, sum(forecast_quantity) as forecast_qty,
		sum(forecast_quantity - sold_quantity) as net_err,
        sum(forecast_quantity- sold_quantity)*100/sum(forecast_quantity) as net_err_pct,
        sum(abs(forecast_quantity- sold_quantity)) as abs_err,
        sum(abs(forecast_quantity- sold_quantity))*100/sum(forecast_quantity) as abs_err_pct
from fact_act_est where fiscal_year = 2021
group by customer_code
order by abs_err_pct desc ;

with forecast_err_table as 
	(select  
		customer_code, fiscal_year, sum(sold_quantity) as sold_qty,
        sum(forecast_quantity) as forecast_qty,
		sum(forecast_quantity - sold_quantity) as net_err,
        sum(forecast_quantity- sold_quantity)*100/sum(forecast_quantity) as net_err_pct,
        sum(abs(forecast_quantity- sold_quantity)) as abs_err,
        sum(abs(forecast_quantity- sold_quantity))*100/sum(forecast_quantity) as abs_err_pct
from fact_act_est where fiscal_year = 2021
group by customer_code )
select *,
		100 - abs_err_pct as forecast_accuracy
from forecast_err_table 
order by forecast_accuracy; 



#temporary table
create temporary table temp_fa
select 
		sum(forecast_quantity - sold_quantity) as net_err,
        sum(forecast_quantity- sold_quantity)*100/sum(forecast_quantity) as net_err_pct,
        sum(abs(forecast_quantity- sold_quantity)) as abs_err,
        sum(abs(forecast_quantity- sold_quantity))*100/sum(forecast_quantity) as abs_err_pct
from fact_act_est where fiscal_year = 2021
group by customer_code;


select * from temp_fa;
