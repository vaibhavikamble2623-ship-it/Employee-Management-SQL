-- Employee Management & Salary Analysis
-- SQL Portfolio Project

CREATE DATABASE EmployeeManagementDB;
GO

USE EmployeeManagementDB;
GO

-- Create Department table
CREATE TABLE Department (
    DeptNo INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);
GO

-- Create Employee table
CREATE TABLE Employee (
    EmpNo INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Job VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    DeptNo INT,
    MgrNo INT NULL,
    FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo)
);
GO

-- Insert Department data
INSERT INTO Department VALUES
(10, 'ACCOUNTING', 'MUMBAI'),
(20, 'RESEARCH', 'PUNE'),
(30, 'SALES', 'DELHI'),
(40, 'OPERATIONS', 'BANGALORE');
GO

-- Insert Employee data
INSERT INTO Employee VALUES
(7839, 'KING', 'PRESIDENT', 75000, '2018-11-17', 10, NULL),
(7698, 'BLAKE', 'MANAGER', 50000, '2019-05-01', 30, 7839),
(7782, 'CLARK', 'MANAGER', 48000, '2019-06-09', 10, 7839),
(7566, 'JONES', 'MANAGER', 49000, '2020-04-02', 20, 7839),
(7788, 'SCOTT', 'ANALYST', 45000, '2021-12-09', 20, 7566),
(7902, 'FORD', 'ANALYST', 44000, '2021-12-03', 20, 7566),
(7369, 'SMITH', 'CLERK', 30000, '2022-12-17', 20, 7902),
(7499, 'ALLEN', 'SALESMAN', 35000, '2022-02-20', 30, 7698),
(7521, 'WARD', 'SALESMAN', 32000, '2022-02-22', 30, 7698),
(7844, 'TURNER', 'SALESMAN', 33000, '2022-09-08', 30, 7698);
GO

-- 1. Display all employees
SELECT * FROM Employee;

-- 2. Display employee names and salaries
SELECT EmpName, Salary
FROM Employee;

-- 3. Employees earning more than 40000
SELECT EmpName, Salary
FROM Employee
WHERE Salary > 40000;

-- 4. Employees working in department 30
SELECT EmpName, Job, Salary
FROM Employee
WHERE DeptNo = 30;

-- 5. Employees sorted by salary
SELECT EmpName, Salary
FROM Employee
ORDER BY Salary DESC;

-- 6. Maximum salary
SELECT MAX(Salary) AS MaximumSalary
FROM Employee;

-- 7. Minimum salary
SELECT MIN(Salary) AS MinimumSalary
FROM Employee;

-- 8. Average salary
SELECT AVG(Salary) AS AverageSalary
FROM Employee;

-- 9. Number of employees
SELECT COUNT(*) AS TotalEmployees
FROM Employee;

-- 10. Total salary
SELECT SUM(Salary) AS TotalSalary
FROM Employee;

-- 11. Number of employees in each department
SELECT DeptNo, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY DeptNo;

-- 12. Average salary in each department
SELECT DeptNo, AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptNo;

-- 13. Departments having average salary greater than 40000
SELECT DeptNo, AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptNo
HAVING AVG(Salary) > 40000;

-- 14. Employee and department information
SELECT E.EmpName, E.Job, E.Salary, D.DeptName, D.Location
FROM Employee E
INNER JOIN Department D
    ON E.DeptNo = D.DeptNo;

-- 15. Employees working in Sales department
SELECT E.EmpName, E.Job, E.Salary
FROM Employee E
INNER JOIN Department D
    ON E.DeptNo = D.DeptNo
WHERE D.DeptName = 'SALES';

-- 16. Employees earning more than the average salary
SELECT EmpName, Salary
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
);

-- 17. Employee with the highest salary
SELECT EmpName, Salary
FROM Employee
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employee
);

-- 18. Employees earning more than SMITH
SELECT EmpName, Salary
FROM Employee
WHERE Salary > (
    SELECT Salary
    FROM Employee
    WHERE EmpName = 'SMITH'
);

-- 19. Employees working in the same department as JONES
SELECT EmpName, DeptNo
FROM Employee
WHERE DeptNo = (
    SELECT DeptNo
    FROM Employee
    WHERE EmpName = 'JONES'
);

-- 20. Employee and department report
SELECT
    E.EmpNo,
    E.EmpName,
    E.Job,
    E.Salary,
    D.DeptName,
    D.Location
FROM Employee E
INNER JOIN Department D
    ON E.DeptNo = D.DeptNo
ORDER BY E.Salary DESC;

-- 21. Department salary summary
SELECT
    D.DeptNo,
    D.DeptName,
    COUNT(E.EmpNo) AS EmployeeCount,
    MAX(E.Salary) AS MaximumSalary,
    MIN(E.Salary) AS MinimumSalary,
    AVG(E.Salary) AS AverageSalary,
    SUM(E.Salary) AS TotalSalary
FROM Department D
LEFT JOIN Employee E
    ON D.DeptNo = E.DeptNo
GROUP BY D.DeptNo, D.DeptName
ORDER BY D.DeptNo;
