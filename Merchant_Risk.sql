/* PROJECT: Merchant Risk & Fulfillment Latency Analysis
AUTHOR: Aquababy98
DESCRIPTION: Identifying the correlation between shipping delays and credit risk.
*/

---------------------------------------------------------
-- 1. OVERALL PORTFOLIO PERFORMANCE BY INDUSTRY
---------------------------------------------------------
-- This query identifies which industries have the highest dispute rates 
-- and quantifies the total financial loss (chargebacks).

SELECT 
    industry,
    COUNT(merchant_id) AS total_merchants,
    ROUND(AVG(days_to_ship)::numeric, 1) AS avg_shipping_delay,
    ROUND(((SUM(is_disputed)::numeric / COUNT(*)) * 100), 2) AS dispute_rate_pct,
    SUM(chargeback_amount) AS total_chargeback_loss
FROM merchant_data
GROUP BY industry
ORDER BY dispute_rate_pct DESC;

---------------------------------------------------------
-- 2. SHIPPING SPEED SEGMENTATION
---------------------------------------------------------
-- This query groups merchants into tiers to find the specific threshold
-- where delays become a significant financial liability.

SELECT 
    CASE 
        WHEN days_to_ship <= 5 THEN '1. Fast (0-5 days)'
        WHEN days_to_ship <= 15 THEN '2. Moderate (6-15 days)'
        WHEN days_to_ship <= 25 THEN '3. Slow (16-25 days)' -- Highest combined loss tier
        ELSE '4. Extreme (25+ days)'
    END AS shipping_tier,
    COUNT(*) AS merchant_count,
    SUM(is_disputed) AS total_disputes,
    SUM(chargeback_amount) AS total_chargeback_loss
FROM merchant_data
GROUP BY 1 
ORDER BY 1;

---------------------------------------------------------
-- 3. INDUSTRY-LEVEL HEATMAP DATA
---------------------------------------------------------
-- This query crosses industry types with shipping tiers to find 
-- high-sensitivity outliers like the Travel sector.

SELECT 
    industry,
    CASE 
        WHEN days_to_ship <= 5 THEN '1. Fast (0-5 days)'
        WHEN days_to_ship <= 15 THEN '2. Moderate (6-15 days)'
        WHEN days_to_ship <= 25 THEN '3. Slow (16-25 days)'
        ELSE '4. Extreme (25+ days)'
    END AS shipping_tier,
    ROUND(((SUM(is_disputed)::numeric / COUNT(*)) * 100), 2) AS dispute_rate_pct
FROM merchant_data
GROUP BY industry, shipping_tier
ORDER BY industry, shipping_tier;


