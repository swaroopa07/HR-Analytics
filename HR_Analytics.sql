use HR_Analytics;

select top 10 * from ibm_data

--- Income earned based on JobRole,Department,EducationField
select JobRole,Department,EducationField,sum(MonthlyIncome) as income 
from ibm_data
Group By JobRole,Department,EducationField

--- Does people who don't have job satisfaction tends to leave company more
SELECT JobSatisfaction,
       Attrition,
       COUNT(*) AS employees
FROM ibm_data
GROUP BY JobSatisfaction, Attrition
ORDER BY JobSatisfaction;

--- Does people who are having more age shifted more companies
select age,count(NumCompaniesWorked) as companiesworked 
from IBM_Data
Group By age
order by age desc


---- Which gender is earning more
SELECT Gender,
       AVG(MonthlyIncome) AS avg_income,
       COUNT(*) AS employees
FROM ibm_data
GROUP BY Gender;

---- which gender have martial status as single(mens/female)?
select MaritalStatus, Gender, count(Gender) as mart_count
from ibm_data
group by MaritalStatus, Gender

--- does who travel frequently tends to leave company more?
SELECT BusinessTravel,
       CAST(
           ROUND(
               100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
               2
           ) AS DECIMAL(10,2)
           )AS AttritionRate
FROM ibm_data
GROUP BY BusinessTravel;

--- does people who are working overtime getting more hike
SELECT OverTime,
       AVG(PercentSalaryHike) AS avg_salary_hike,
       COUNT(*) AS employees
FROM ibm_data
GROUP BY OverTime;

--- does people who are working overtime getting more dailyincome
SELECT OverTime,
       AVG(DailyRate) AS avg_daily_rate,
       COUNT(*) AS employees
FROM ibm_data
GROUP BY OverTime;

--- which roles pay more
WITH role_salary AS (
    SELECT JobRole,
           AVG(MonthlyIncome) AS avg_role_salary
    FROM ibm_data
    GROUP BY JobRole
)
SELECT JobRole,
       avg_role_salary,
       ROW_NUMBER() OVER (ORDER BY avg_role_salary DESC) AS rn
FROM role_salary;


--- Compare each employee salary vs job role average
SELECT EmployeeNumber,Department,JobRole,MonthlyIncome,
       AVG(MonthlyIncome) OVER (PARTITION BY JobRole) AS avg_role_salary,
       CASE 
           WHEN MonthlyIncome > AVG(MonthlyIncome) OVER (PARTITION BY JobRole)
           THEN 'Above Average'
           WHEN MonthlyIncome < AVG(MonthlyIncome) OVER (PARTITION BY JobRole)
           THEN 'Below Average'
           ELSE 'At Average'
       END AS salary_status
FROM ibm_data
ORDER BY JobRole, MonthlyIncome DESC;

--- Salary Ranking of Non-Attrited Employees Across Job Roles
SELECT EmployeeNumber,
       JobRole,
       MonthlyIncome,
       AVG(MonthlyIncome) OVER (PARTITION BY JobRole) AS avg_role_salary,
       RANK() OVER (PARTITION BY JobRole ORDER BY MonthlyIncome DESC) AS salary_rank
FROM ibm_data
WHERE Attrition = 'No'
ORDER BY JobRole, salary_rank;


--- Employee Experience vs Salary
select Experience, avg(MonthlyIncome) as avg_income
from IBM_Data
group by Experience


--- Overtime vs attrition
select OverTime, Round(100 * sum(case when Attrition = 'Yes' then 1 else 0 end)/count(*),2) as attr_rate
from IBM_Data
group by OverTime


                                          --- CREATING TABLES FOR STAR SCHEMA

--------- Dimension Table Deaprtment
CREATE TABLE DimDepartment(
    DepartmentKey INT IDENTITY(1,1) PRIMARY KEY,
    Department VARCHAR(100) NOT NULL
);

-- insert
INSERT INTO DimDepartment(Department)
SELECT DISTINCT Department
FROM ibm_data;

-------- Dimesion Table Job
CREATE TABLE DimJob(
    JobKey INT IDENTITY(1,1) PRIMARY KEY,
    JobRole VARCHAR(100) NOT NULL,
    JobLevel INT NOT NULL
);

---- insert
INSERT INTO DimJob(JobRole, JobLevel)
SELECT DISTINCT JobRole, JobLevel
FROM ibm_data;

select * from DimJob
-------- Dimension Table Education
CREATE TABLE DimEducation(
    EducationKey INT IDENTITY(1,1) PRIMARY KEY,
    Education INT,
    EducationField VARCHAR(100)
);

---- insert
INSERT INTO DimEducation(Education, EducationField)
SELECT DISTINCT Education, EducationField
FROM ibm_data;

------- Dimension Table Employee
CREATE TABLE DimEmployee(
    EmployeeNumber INT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(20),
    MaritalStatus VARCHAR(30),
    BusinessTravel VARCHAR(50),
    DistanceFromHome INT,
    OverTime VARCHAR(10)
);

-- insert
INSERT INTO DimEmployee
(
EmployeeNumber,
Age,
Gender,
MaritalStatus,
BusinessTravel,
DistanceFromHome,
OverTime
)

SELECT DISTINCT
EmployeeNumber,
Age,
Gender,
MaritalStatus,
BusinessTravel,
DistanceFromHome,
OverTime
FROM ibm_data;


---------- FACT TABLE

CREATE TABLE FactEmployee
(
    EmployeeNumber INT,
    DepartmentKey INT,
    JobKey INT,
    EducationKey INT,

    MonthlyIncome INT,
    DailyRate INT,
    HourlyRate INT,
    MonthlyRate INT,

    PercentSalaryHike INT,

    TotalWorkingYears INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT,

    NumCompaniesWorked INT,

    TrainingTimesLastYear INT,

    PerformanceRating INT,
    EnvironmentSatisfaction INT,
    JobSatisfaction INT,
    RelationshipSatisfaction INT,
    WorkLifeBalance INT,
    JobInvolvement INT,

    StockOptionLevel INT,

    Attrition VARCHAR(5),

    FOREIGN KEY(EmployeeNumber)
        REFERENCES DimEmployee(EmployeeNumber),

    FOREIGN KEY(DepartmentKey)
        REFERENCES DimDepartment(DepartmentKey),

    FOREIGN KEY(JobKey)
        REFERENCES DimJob(JobKey),

    FOREIGN KEY(EducationKey)
        REFERENCES DimEducation(EducationKey)
);
---- insert
INSERT INTO FactEmployee
(
    EmployeeNumber,
    DepartmentKey,
    JobKey,
    EducationKey,
    MonthlyIncome,
    DailyRate,
    HourlyRate,
    MonthlyRate,
    PercentSalaryHike,
    TotalWorkingYears,
    YearsAtCompany,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager,
    NumCompaniesWorked,
    TrainingTimesLastYear,
    PerformanceRating,
    EnvironmentSatisfaction,
    JobSatisfaction,
    RelationshipSatisfaction,
    WorkLifeBalance,
    JobInvolvement,
    StockOptionLevel,
    Attrition
)

SELECT
    emp.EmployeeNumber,
    d.DepartmentKey,
    j.JobKey,
    e.EducationKey,

    i.MonthlyIncome,
    i.DailyRate,
    i.HourlyRate,
    i.MonthlyRate,

    i.PercentSalaryHike,

    i.TotalWorkingYears,
    i.YearsAtCompany,
    i.YearsInCurrentRole,
    i.YearsSinceLastPromotion,
    i.YearsWithCurrManager,

    i.NumCompaniesWorked,

    i.TrainingTimesLastYear,

    i.PerformanceRating,
    i.EnvironmentSatisfaction,
    i.JobSatisfaction,
    i.RelationshipSatisfaction,
    i.WorkLifeBalance,
    i.JobInvolvement,

    i.StockOptionLevel,

    i.Attrition

FROM ibm_data i

JOIN DimEmployee emp
    ON i.EmployeeNumber = emp.EmployeeNumber

JOIN DimDepartment d
    ON i.Department = d.Department

JOIN DimJob j
    ON i.JobRole = j.JobRole
   AND i.JobLevel = j.JobLevel

JOIN DimEducation e
    ON i.Education = e.Education
   AND i.EducationField = e.EducationField;

   select * from FactEmployee;


