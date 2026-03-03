# 📈 Merchant Fulfillment Analysis: Identifying the Delay Thresholds that Drive Disputes

## **Executive Summary**
The goal of this project was to find the leak in the merchant platform, a steady drain that the current policy was missing. By digging into the data, I discovered that the business was flying blind with a one-size-fits-all approach that doesn't account for a major 15-day risk cliff. While most merchants remain stable for the first two weeks, disputes increase significantly the moment a delay hits day 15, especially in the Travel sector, where 73% of customers file disputes by day 25. To plug this hole, I have recommended that the business rework its blanket policy to trigger a 20% hold at the 15-day mark, and Day 12 for Travel, so we can stop these losses before they occur.

---

## **The Business Problem: Shipping Delays and Financial Risk**
The business has been experiencing a steady drain on its cash flow due to customer disputes, but pinpointing the exact cause has been challenging. For a long time, the assumption was simply that 'delays happen,' so we relied on a blanket policy to manage everyone on the platform. The issue is that this one-size-fits-all approach isn't working; we're flying blind while the business loses money. This project was designed to find the leak in our fulfillment process and finally plug the hole.

---

<details>
<summary><b>🛠️ Click to view Data Definitions (Technical Dictionary)</b></summary>

| Column Name | Description | Role in Analysis |
| :--- | :--- | :--- |
| **industry** | Business category (Travel, SaaS, etc.) | High-risk sector identification |
| **days_to_ship** | Days from order to fulfillment | Risk threshold variable |
| **is_disputed** | 1 if customer disputed; 0 if not | Primary risk outcome |
| **chargeback_amount** | Dollar value of the dispute | Loss quantification ($126k total) |

</details>

---

## **Methodology**
To determine where the losses were coming from, I started by looking at roughly 1,000 merchant accounts. Using SQL, I grouped these merchants into tiers, from those whose shipments were on time to those facing significant delays. Using CASE statements, I separated on-time shipments from delayed ones to compare their dispute rates.

Once the data was cleaned and grouped, I moved it to Tableau to visualize the trends. Rather than a steady increase, the heatmap showed a significant jump at Day 15. This is where the business's losses hit that $126,000 mark. It also revealed that the Travel sector was the biggest outlier; once fulfillment took longer than 25 days, nearly 73% of customers filed disputes.

---

## **The Tools Used**
* **SQL**  for grouping data and putting losses into tiers.
* **Tableau**  for visualising the trend and heatmap analysis.

---

## **The Results**

### **1. Financial Impact of Delays**
![Financial Impact Chart](images/financial_impact_barchart.png)
**The 15-Day Threshold:** Up until day 15, the dispute rates are manageable and stable. However, the moment a merchant enters the 16–25 day window, losses skyrocket, peaking at $126,000 that month.

### **2. Industry Sensitivity Analysis**
![Industry Heatmap](images/industry_risk_heatmap.png)
**Travel Sector Outlier:** The data show that the Travel sector is very fragile over time. While customers in other industries might be more understanding of delays, 73% of Travel customers file a formal dispute the second that delay hits 25 days.

---

## **Plugging the Hole (Recommendations)**

* **The 15-Day Safety Net:** Since losses spike at the 15-day mark, our intervention needs to start there. For any merchant reaching this threshold, the platform should automatically hold 20% of their sales in reserve. This gives the business a buffer to cover potential losses from disputes before they hit the bottom line.
* **Stricter policies for the Travel sector:** This is where the business sees its greatest losses. We should trigger a hold on funds for Travel merchants on Day 12. This proactive strategy allows us to get ahead of the 25-day risk cliff, where nearly three-quarters of customers file disputes.

---

## **Future Work: From Reactive to Proactive**
While the immediate holds on funds will stop the current bleeder, the long-term goal should be to move toward Real-time Monitoring. Instead of reacting to losses after the month ends, the Risk Team needs a live view of fulfillment times. I recommend building an automated dashboard that flags merchants as they approach their sector's risk threshold (Day 12 for Travel, Day 15 for others). This would allow us to step in and resolve the issue before the financial damage is ever done.

---

<details>
<summary><b>💻 Technical Instructions: How to Reproduce this Analysis</b></summary>

1. **Clone the Repo:** `git clone https://github.com/Aquababy98/Merchant-Risk-Analysis`
2. **Database:** Load `Merchant_health_mock_data.csv` into your SQL environment.
3. **Execution:** Run the queries located in the `Merchant_Risk.sql` file to generate the Risk Tiers.
</details>

---

### **Note on Data Privacy & Source**
**Data Source:** The foundation of this project utilizes a dataset sourced from [Mockaroo](https://www.mockaroo.com). 

**Privacy & Synthesis:** To maintain professional standards of data privacy, all merchant identifiers and financial figures have been **synthetically generated**. While the specific data points are simulated, the risk logic, SQL queries, and strategic findings are designed to reflect authentic challenges found in the Merchant Credit Risk and Fintech sectors.
