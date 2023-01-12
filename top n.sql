select market,
round(sum(net_sales)/1000000,2) as net_sales_mln
from net_sales
where fiscal_year=2021
group by market
order by net_sales_mln desc
limit 5; 

-- top n customer

select c.customer,
	round(sum(net_sales)/1000000,2) as net_sales_mln
	from net_sales n
    join dim_customer c
    on n.customer_code=c.customer_code
	where fiscal_year=2021
	group by c.customer
	order by net_sales_mln desc
	limit 5 
