-- 1  Retrieve all records where the sector is INFORMATION TECHNOLOGY
select *
from blackrock_holdings
where sector='information technology';

-- 2 Find the total market value for stocks in the "HEALTH CARE" sector
select  sum(market_value) as total_market_value
from blackrock_holdings
where sector='health care';

--  3 List the top 10 stocks by "% of Portfolio."
select stock, Percent_of_Portfolio
FROM blackrock_holdings
ORDER BY Percent_of_Portfolio DESC
LIMIT 10;

-- 4 Identify stocks with a "% Change" greater than 5%.
select stock, Percent_Change
from blackrock_holdings
where Percent_Change >5
limit 10;

-- 5 Count the number of stocks in each sector.
select count(stock) as total,sector
from blackrock_holdings
group by Sector
order by total;

-- 6 Calculate the average "Estimated Avg Price Paid" for stocks in the "FINANCE" sector
select round(avg(Estimated_Avg_Price_Paid), 2) as average_price_paid 
from blackrock_holdings
where Sector='finance'
order by average_price_paid
limit 10;

-- 7 Find all stocks with a "Recent Price" higher than their "Quarter End Price."
select stock,recent_price,Quarter_End_Price
from blackrock_holdings
where Recent_Price>Quarter_End_Price
limit 10;

-- 8 Retrieve stocks that were first owned in Q3 2007 with a "% Ownership" greater than 6%.
select stock
from blackrock_holdings
where Qtr_1st_Owned='Q3 2007' and Percent_Ownership>6
limit 10;

-- 9 Rank stocks by their "Change in Shares" within the "ENERGY" sector.
select stock,Change_in_Shares
from blackrock_holdings
where sector='energy'
order by Change_in_Shares desc
limit 10;

-- 10 Compare the "% of Portfolio" to "Previous % of Portfolio" and identify stocks with an increase
select stock,Percent_of_Portfolio,Previous_Percent_of_Portfolio
from blackrock_holdings
where Percent_of_Portfolio>Previous_Percent_of_Portfolio
limit 10;

-- 11 Find stocks where "% Change" is negative and sort them by their rank.
select stock,percent_change
from blackrock_holdings
where Percent_Change <0
order by percent_change desc
limit 10;

-- 12. Calculate the total shares held across all sectors.
select sector,sum(Shares_Held_or_Principal_Amt) as total_shares
from blackrock_holdings
group by sector
order by total_shares;

-- 13. Identify sectors contributing more than 10% to the portfolio's market value.
select sector,sum(Percent_of_Portfolio) as total_value
from blackrock_holdings
group by sector
having total_value>10
order by total_value desc;

-- 14. Retrieve stocks with a "Source Date" later than 01/01/2022.
select stock
from blackrock_holdings
where Source_Date>2022-01-01
limit 10;

-- 15. Calculate the ratio between "Market Value" and "Shares Held or Principal Amt" for each stock.
select stock,market_value,Shares_Held_or_Principal_Amt,round(market_value/Shares_Held_or_Principal_Amt) as value_per_share
from blackrock_holdings;

-- 16. Group stocks by sector and calculate their average "% Ownership."
select sector,round(avg(percent_ownership),2) as ownership
from blackrock_holdings
group by Sector
order by ownership
limit 10;

-- 17. Find the stock with the highest estimated average price paid in each sector.
select stock,sector,max(Estimated_Avg_Price_Paid) as highest_avg
from blackrock_holdings
group by sector,stock
order by sector,highest_avg desc;

-- 18. Identify stocks where "% Change" exceeds the average for their sector.
select stock,sector,Percent_Change
from blackrock_holdings
where Percent_Change>( select avg(Percent_Change) 
         from blackrock_holdings)
 order by sector,Percent_Change;  
 
 -- 19. Calculate the percentage contribution of each stock to its sector's total market value.
 select stock,sector,market_value,round((market_value/ sum(market_value) over(partition by sector)), 2) *100 as percentage_distribution
 from blackrock_holdings
 order by sector,percentage_distribution desc;
 
 -- 20. Retrieve stocks with a market value above $50 billion and rank them by "% Ownership."
select stock,market_value,Percent_Ownership
from blackrock_holdings
where Market_Value>50000000000
order by Percent_Ownership desc;


