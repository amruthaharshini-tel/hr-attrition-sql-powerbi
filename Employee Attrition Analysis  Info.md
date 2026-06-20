# Employee Attrition Analysis — SQL Project

![SQL](https://img.shields.io/badge/SQL-GROUP%20BY%20%7C%20Conditional%20Aggregation%20%7C%20CASE%20WHEN-blue)
![Dataset](https://img.shields.io/badge/Dataset-IBM%20HR%20Analytics-green)
![Records](https://img.shields.io/badge/Records-1%2C470%20Employees-lightgrey)
![Queries](https://img.shields.io/badge/Queries-40%20SQL%20Questions-orange)

This project looks at why employees leave. Using the IBM HR Analytics dataset (1,470 employees), I wrote SQL queries to find attrition patterns across departments, education backgrounds, travel frequency, pay, age, and commute distance.

The goal wasn't just to run queries — it was to find something useful in the numbers.

---

## What the data actually says

The overall attrition rate is 16.12% — meaning roughly 1 in 6 employees left. That number alone isn't alarming, but once you break it down, clear patterns emerge.

**Travel frequency is the biggest signal.** Employees who travel frequently leave at 24.91%, nearly three times the rate of those who don't travel at all (8%). That's not a subtle difference — it's a structural retention problem for companies that rely on frequent travel.

**Sales is in trouble.** A 20.63% attrition rate in a 446-person department means roughly 92 people leaving per year. HR and R&D both trail behind. If I were presenting this to leadership, Sales is where I'd start the conversation.

**Younger, lower-paid employees are leaving more.** The average age of employees who left is 33.6, vs 37.6 for those who stayed. Daily rate tells a similar story — $750 vs $813. It's not a massive gap, but it's consistent, and consistent patterns matter.

**Commute distance is a quiet factor.** Employees who left lived about 19% further from the office on average. Not the loudest finding, but worth noting if a company is deciding on hybrid work policies.

**Two education groups stand out unexpectedly.** Human Resources (25.93%) and Technical Degree (24.24%) backgrounds have attrition rates well above the company average. The dataset doesn't explain why — but it's the kind of finding that prompts a better question.

---

## The numbers

### Overall snapshot

| Metric | Value |
|--------|-------|
| Total employees | 1,470 |
| Employees who left | 237 (16.12%) |
| Employees who stayed | 1,233 (83.88%) |
| Highest-risk department | Sales — 20.63% |

### Stayed vs Left

| | Left | Stayed |
|---|------|--------|
| Count | 237 | 1,233 |
| Average age | 33.61 yrs | 37.56 yrs |
| Average daily rate | $750.36 | $812.50 |
| Avg distance from home | 10.63 | 8.92 |

### By department

| Department | Employees | Left | Attrition Rate | Risk |
|------------|-----------|------|---------------|------|
| Sales | 446 | 92 | 20.63% | High |
| Human Resources | 63 | 12 | 19.05% | High |
| Research & Development | 961 | 133 | 13.84% | Moderate |

### By travel frequency

| Travel Category | Employees | Left | Attrition Rate |
|-----------------|-----------|------|---------------|
| Travel Frequently | 277 | 69 | 24.91% |
| Travel Rarely | 1,043 | 156 | 14.96% |
| Non-Travel | 150 | 12 | 8.00% |

### By education field

| Education Field | Employees | Left | Attrition Rate |
|-----------------|-----------|------|---------------|
| Human Resources | 27 | 7 | 25.93% |
| Technical Degree | 132 | 32 | 24.24% |
| Marketing | 159 | 35 | 22.01% |
| Life Sciences | 606 | 89 | 14.69% |
| Medical | 464 | 63 | 13.58% |
| Other | 82 | 11 | 13.41% |

---

## SQL techniques used

- `GROUP BY` with `COUNT()`, `AVG()`, and `MAX()` for distribution and averages across segments
- Conditional aggregation using `CASE WHEN` inside `SUM()` to calculate attrition counts without subqueries
- Attrition rate formula: `SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)`
- `ROUND()` and `ORDER BY` for clean, ranked outputs

---

## Sample query

```sql
-- Attrition rate by department
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS attrition_rate_pct
FROM hr_data
GROUP BY Department
ORDER BY attrition_rate_pct DESC;
```

All 40 queries with comments are in [`attrition_analysis.sql`](./attrition_analysis.sql)

---

## Files

| File | Description |
|------|-------------|
| `attrition_analysis.sql` | All 40 queries |
| `hr_data.csv` | Source dataset |
| `README.md` | This file |

---

*Dataset: [IBM HR Analytics Employee Attrition & Performance](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset) — public domain via Kaggle*
