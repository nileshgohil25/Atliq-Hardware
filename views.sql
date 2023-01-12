-- view
SELECT 
            *,
    	    (gross_price_total-pre_invoice_discount_pct*gross_price_total) as net_invoice_sales
	FROM gdb041.sales_preinv_discount;
    
SELECT 
            *, 
    	    net_invoice_sales*(1-post_invoice_discount_pct) as net_sales
	FROM gdb041.sales_postinv_discount;
    
-- exercise
create view gross_sales as
	select
		s.date,
		s.fiscal_year,
		s.customer_code,
		c.customer,
		c.market,
		s.product_code,
		p.product, p.variant,
		s.sold_quantity,
		g.gross_price as gross_price_per_item,
		round(s.sold_quantity*g.gross_price,2) as gross_price_total
	from fact_sales_monthly s
	join dim_product p
	on s.product_code=p.product_code
	join dim_customer c
	on s.customer_code=c.customer_code
	join fact_gross_price g
	on g.fiscal_year=s.fiscal_year
	and g.product_code=s.product_code


