-- ============================================================
-- HR Attrition Analysis
-- Dataset: IBM HR Analytics (dbo.HR_Attrition)
-- Note: Attrition column uses 1 = Left, 0 = Stayed
-- ============================================================


-- ============================================================
-- SECTION 1: DATA EXPLORATION
-- ============================================================

-- View full dataset
SELECT *
FROM dbo.HR_Attrition;


-- Total employee count
SELECT COUNT(EmployeeCount) AS TotalEmployees
FROM dbo.HR_Attrition;


-- Employees who left
SELECT COUNT(EmployeeCount) AS EmployeesLeft
FROM dbo.HR_Attrition
WHERE Attrition = '1';


-- Employees who stayed
SELECT COUNT(EmployeeCount) AS EmployeesStayed
FROM dbo.HR_Attrition
WHERE Attrition = '0';


-- ============================================================
-- SECTION 2: FILTERING
-- ============================================================

-- Employees who left
SELECT EmployeeNumber
FROM dbo.HR_Attrition
WHERE Attrition = '1';


-- Employees older than 40
SELECT EmployeeNumber
FROM dbo.HR_Attrition
WHERE Age > 40;


-- Employees who travel frequently
SELECT EmployeeNumber, BusinessTravel
FROM dbo.HR_Attrition
WHERE BusinessTravel = 'Travel_Frequently';


-- Employees who never travel
SELECT EmployeeNumber, BusinessTravel
FROM dbo.HR_Attrition
WHERE BusinessTravel = 'Non-Travel';


-- Employees who left AND travel frequently
SELECT EmployeeNumber, BusinessTravel
FROM dbo.HR_Attrition
WHERE Attrition = '1'
  AND BusinessTravel = 'Travel_Frequently';


-- Employees living more than 20 units from home
SELECT EmployeeNumber
FROM dbo.HR_Attrition
WHERE DistanceFromHome > 20;


-- Employees with daily rate above 1000
SELECT EmployeeNumber
FROM dbo.HR_Attrition
WHERE DailyRate > 1000;


-- Employees with Life Sciences education
SELECT EmployeeNumber, EducationField
FROM dbo.HR_Attrition
WHERE EducationField = 'Life Sciences';


-- Employees aged 25 to 35 (both methods return the same result)
SELECT EmployeeNumber
FROM dbo.HR_Attrition
WHERE Age >= 25 AND Age <= 35;

SELECT EmployeeNumber
FROM dbo.HR_Attrition
WHERE Age BETWEEN 25 AND 35;


-- ============================================================
-- SECTION 3: SUMMARY STATISTICS
-- ============================================================

-- Age: min, max, average
SELECT MIN(Age) AS MinAge
FROM dbo.HR_Attrition;

SELECT MAX(Age) AS MaxAge
FROM dbo.HR_Attrition;

SELECT AVG(Age) AS AvgAge
FROM dbo.HR_Attrition;


-- Average daily rate across all employees
SELECT AVG(DailyRate) AS AvgDailyRate
FROM dbo.HR_Attrition;


-- Average distance from home across all employees
SELECT AVG(DistanceFromHome) AS AvgDistanceFromHome
FROM dbo.HR_Attrition;


-- ============================================================
-- SECTION 4: GROUP BY — DISTRIBUTION
-- ============================================================

-- Employee count by department
SELECT Department, COUNT(EmployeeCount) AS Employees
FROM dbo.HR_Attrition
GROUP BY Department
ORDER BY Employees DESC;


-- Employee count by education field
SELECT EducationField, COUNT(EmployeeCount) AS Employees
FROM dbo.HR_Attrition
GROUP BY EducationField
ORDER BY Employees DESC;


-- Employee count by travel category
SELECT BusinessTravel, COUNT(EmployeeCount) AS Employees
FROM dbo.HR_Attrition
GROUP BY BusinessTravel
ORDER BY Employees DESC;


-- Average age by department
SELECT Department, AVG(Age) AS AvgAge
FROM dbo.HR_Attrition
GROUP BY Department
ORDER BY AvgAge DESC;


-- Average daily rate by department
SELECT Department, AVG(DailyRate) AS AvgDailyRate
FROM dbo.HR_Attrition
GROUP BY Department
ORDER BY AvgDailyRate DESC;


-- Average distance from home by department
SELECT Department, AVG(DistanceFromHome) AS AvgDistanceFromHome
FROM dbo.HR_Attrition
GROUP BY Department
ORDER BY AvgDistanceFromHome DESC;


-- Attrition count by department
SELECT Department, COUNT(Attrition) AS AttritionCount
FROM dbo.HR_Attrition
WHERE Attrition = '1'
GROUP BY Department
ORDER BY AttritionCount DESC;


-- Attrition count by travel category
SELECT BusinessTravel, COUNT(Attrition) AS AttritionCount
FROM dbo.HR_Attrition
WHERE Attrition = '1'
GROUP BY BusinessTravel
ORDER BY AttritionCount DESC;


-- Highest daily rate in each department
SELECT Department, MAX(DailyRate) AS HighestDailyRate
FROM dbo.HR_Attrition
GROUP BY Department;


-- ============================================================
-- SECTION 5: CONDITIONAL AGGREGATION
-- ============================================================

-- Overall attrition rate
SELECT
    SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0
    / COUNT(Attrition) AS OverallAttritionRate
FROM dbo.HR_Attrition;


-- Attrition rate by department
SELECT
    Department,
    SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0
    / COUNT(Attrition) AS AttritionRate
FROM dbo.HR_Attrition
GROUP BY Department
ORDER BY AttritionRate DESC;


-- Attrition rate by education field
SELECT
    EducationField,
    SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0
    / COUNT(Attrition) AS AttritionRate
FROM dbo.HR_Attrition
GROUP BY EducationField
ORDER BY AttritionRate DESC;


-- Attrition rate by travel category
SELECT
    BusinessTravel,
    ROUND(
        SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0
        / COUNT(Attrition), 2
    ) AS AttritionRate
FROM dbo.HR_Attrition
GROUP BY BusinessTravel
ORDER BY AttritionRate DESC;


-- Employees left vs stayed in one row
SELECT
    SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
    SUM(CASE WHEN Attrition = '0' THEN 1 ELSE 0 END) AS EmployeesStayed
FROM dbo.HR_Attrition;


-- Average age: left vs stayed
SELECT
    ROUND(AVG(CASE WHEN Attrition = '1' THEN Age * 1.0 END), 2) AS AvgAge_Left,
    ROUND(AVG(CASE WHEN Attrition = '0' THEN Age * 1.0 END), 2) AS AvgAge_Stayed
FROM dbo.HR_Attrition;


-- Average daily rate: left vs stayed
SELECT
    ROUND(AVG(CASE WHEN Attrition = '1' THEN DailyRate * 1.0 END), 2) AS AvgDailyRate_Left,
    ROUND(AVG(CASE WHEN Attrition = '0' THEN DailyRate * 1.0 END), 2) AS AvgDailyRate_Stayed
FROM dbo.HR_Attrition;


-- Average distance from home: left vs stayed
SELECT
    ROUND(AVG(CASE WHEN Attrition = '1' THEN DistanceFromHome * 1.0 END), 2) AS AvgDistance_Left,
    ROUND(AVG(CASE WHEN Attrition = '0' THEN DistanceFromHome * 1.0 END), 2) AS AvgDistance_Stayed
FROM dbo.HR_Attrition;


-- Department with the highest attrition rate
SELECT TOP 1
    Department,
    SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0
    / COUNT(Attrition) AS HighestAttritionRate
FROM dbo.HR_Attrition
GROUP BY Department
ORDER BY HighestAttritionRate DESC;
