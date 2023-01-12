SELECT * FROM gdb041.dim_customer;



SELECT * FROM fact_sales_monthly 
	WHERE 
            customer_code=90002002 AND
            YEAR(DATE_ADD(date, INTERVAL 4 MONTH))=2021
	ORDER BY date asc;
-- making user defined function   
SELECT * FROM fact_sales_monthly 
	WHERE 
            customer_code=90002002 AND
            get_fiscal_year(date)=2021 and get_fiscal_quater(date)="Q4"
	ORDER BY date asc
	LIMIT 100000;
    
-- using joins to retrieve other metrics
    
SELECT 
 s.date, s.product_code ,
 p.product,p.variant,s.sold_quantity,
 g.gross_price,(g.gross_price*s.sold_quantity) as  gross_price_total
FROM fact_sales_monthly s
join dim_product p
on p.product_code=s.product_code
join fact_gross_price g
on g.product_code= s.product_code and g.fiscal_year = get_fiscal_year(s.date)
WHERE 
	customer_code=90002002 AND
	get_fiscal_year(date)=2021 and get_fiscal_quater(date)="Q4"
	ORDER BY date asc;

-- Task 2 croma monthly sales    
    
select 
   s.date,
   sum(g.gross_price*s.sold_quantity) as gross_price_total
from fact_sales_monthly s
join fact_gross_price g
on 
   g.product_code=s.product_code and
   g.fiscal_year=get_fiscal_year(s.date)
where customer_code=90002002
group by s.date
order by s.date asc;

-- Excercise

select gp.fiscal_year,round(sum(gp.gross_price*sm.sold_quantity),2) as gross_sales_amt
from fact_gross_price gp
join fact_sales_monthly sm
on 
gp.fiscal_year=get_fiscal_year(sm.date) and
gp.product_code=sm.product_code 
where customer_code=90002002
group by fiscal_year
order by fiscal_year asc
;


