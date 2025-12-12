select
	* FROM dbo.sustainable_clothing

SELECT *
FROM DBO.marketing_campaigns

SELECT 
* FROM dbo.transactions

SELECT 
	MC.campaign_id,
	MC.campaign_name,
	COUNT(TS.transaction_id) AS [Transaction_Count]   --OVER(PARTITION BY TS.PRODUCT_ID) 
FROM DBO.marketing_campaigns AS MC
LEFT JOIN DBO.transactions AS TS
ON MC.product_id = TS.product_id
GROUP BY MC.campaign_id,MC.campaign_name

--------------------------------------------


SELECT 
	top 5 SC.product_name,
	TS.PRODUCT_ID,
	SUM(TS.quantity)  [Quantity]
FROM dbo.sustainable_clothing AS SC
LEFT JOIN dbo.transactions AS TS
ON SC.product_id = TS.product_id
group by sc.product_name,ts.product_id
order by [Quantity] desc

-----------------------------------

select 
	(campaign_name) ,
	sum(sc.price * ts.quantity ) as [Total Revenue]
from dbo.sustainable_clothing as [sc]
join dbo.marketing_campaigns as [mc]
on sc.product_id = mc.product_id
join dbo.transactions as [ts]
on mc.product_id=ts.product_id
group by campaign_name
order by [Total Revenue]desc

------------------------------------------

select
	top 5 sc.product_name,
	sc.category,
	sum(sc.price * ts.quantity) as [Total Revenue]
from dbo.sustainable_clothing as [sc]
join dbo.transactions as [ts]
on sc.product_id=ts.product_id
group by sc.product_name,sc.category
order by [Total Revenue] desc

----------------------------------

select 
sc.product_name,
sum (t.quantity )  as [Higher Quantity Sold],
avg (t.quantity) over() as [Avg Quantity Sold]
from dbo.transactions as t
left join dbo.sustainable_clothing as sc 
on t.product_id = sc.product_id
group by t.quantity,sc.product_name
order by [Higher Quantity Sold] desc

--------------------------
select 
	campaign_name,
	ROUND([Total Revenue] / [Campagin during day],2) as [Avg Pre Total Revenue]

from (

select  
	mc.campaign_name,
	avg(sc.price * t.quantity ) as [Total Revenue],
	DATEDIFF(DAY,mc.start_date,mc.end_date)  as [Campagin during day]
from dbo.marketing_campaigns as mc
join dbo.transactions  as t
on mc.product_id = t.product_id
join dbo.sustainable_clothing as sc 
on mc.product_id = sc.product_id
group by mc.campaign_name,sc.price,t.quantity,mc.end_date,mc.start_date ) as camp_per_revenue


---------------------------

                                              n .



