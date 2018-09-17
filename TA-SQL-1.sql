-- 1 Write a SQL query to find all information about all departments (use "TelerikAcademy" database).
select * from telerikacademy.departments;
-- 2 Write a SQL query to find all department names.
select Name from telerikacademy.departments;
-- 3 Write a SQL query to find the salary of each employee.
select FirstName, LastName, Salary from telerikacademy.employees;
-- 4 Write a SQL to find the full name of each employee.
select concat(FirstName, ' ', LastName) as FullName from telerikacademy.employees;
-- 5 Write a SQL query to find the email addresses of each employee (by his first and last name). Consider that the mail domain is telerik.com. Emails should look like “John.Doe@telerik.com". The produced column should be named "Full Email Addresses".
select concat(FirstName, ' ', LastName) as `Full Name`, 
concat(FirstName, '.', LastName, '@telerik.com') as `Email` 
from telerikacademy.employees;
-- 6 Write a SQL query to find all different employee salaries.
select distinct Salary from telerikacademy.employees;
-- 7 Write a SQL query to find all information about the employees whose job title is “Sales Representative“.
select * from telerikacademy.employees where JobTitle = "Sales Representative";
-- 8 Write a SQL query to find the names of all employees whose first name starts with "SA".
select * from telerikacademy.employees where FirstName like "sa%";
-- 9 Write a SQL query to find the names of all employees whose last namecontains "ei".
select * from telerikacademy.employees where LastName like "%ei%";
-- 10 Write a SQL query to find the salary of all employees whose salary is in the range [20000…30000].
select * from telerikacademy.employees where Salary between 20000 and 30000;
-- 11 Write a SQL query to find the names of all employees whose salary is 25000, 14000, 12500 or 23600.
select * from telerikacademy.employees where Salary in (25000, 14000, 12500, 23600);
-- 12 Write a SQL query to find all employees that do not have manager.
select * from telerikacademy.employees where ManagerID is null;
-- 13 Write a SQL query to find all employees that have salary more than 50000. Order them in decreasing order by salary.
select * from telerikacademy.employees where Salary > 50000 order by Salary desc;
-- 14 Write a SQL query to find the top 5 best paid employees.
select * from telerikacademy.employees order by Salary desc limit 5;
-- 15 Write a SQL query to find all employees and their address.
select e.FirstName, ifnull(e.MiddleName, '') 
as MiddleName, e.LastName, a.AddressText from telerikacademy.employees e
join telerikacademy.addresses a on e.AddressID = a.AddressID;
-- 16 Write a SQL query to find all employees that have manager, along with their manager.
select e.FirstName, e.LastName, m.FirstName as ManagerFirstName, m.LastName 
as ManagerLastName from telerikacademy.employees e
join telerikacademy.employees m on e.ManagerID = m.EmployeeID;
-- 17 Write a SQL query to find all employees that have manager, along with their manager and their address.
select e.FirstName, e.LastName, m.FirstName as ManagerFirstName, m.LastName 
as ManagerLastName, a.AddressText from telerikacademy.employees e
join telerikacademy.employees m on e.ManagerID = m.EmployeeID
join telerikacademy.addresses a on e.AddressID = a.AddressID;
-- 18 Write a SQL query to find all departments and all town names as a single list.
select Name from telerikacademy.departments
union
select Name from telerikacademy.towns;
-- 19 Write a SQL query to find all the employees and the manager for each of them along with the employees that do not have manager.
select e.FirstName, e.LastName, m.FirstName as ManagerFirstName, m.LastName 
as ManagerLastName from telerikacademy.employees e
left join telerikacademy.employees m on e.ManagerID = m.EmployeeID;
-- 20 Write a SQL query to find the names of all employees from the departments "Sales" and "Finance" whose hire year is between 1995 and 2005.
select e.FirstName, e.LastName, d.Name, e.HireDate from telerikacademy.employees e
join telerikacademy.departments d on e.DepartmentID = d.DepartmentID
where Name in ("Sales", "Finance") and YEAR(e.HireDate) between 2002 and 2004;
