-- 1 Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company.
select FirstName, LastName, Salary from telerikacademy.employees where Salary = (select min(Salary) from telerikacademy.employees);
-- 2 Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10% higher than the minimal salary for the company.
select FirstName, LastName, Salary from telerikacademy.employees where Salary < 1.1*(select min(Salary) from telerikacademy.employees);
-- 3 Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department.
select concat(FirstName,' ', ifnull(MiddleName, ''),' ', LastName) as FullName, Salary, d.Name from telerikacademy.employees e
join telerikacademy.departments d on e.DepartmentID = d.DepartmentID
where Salary = (select min(Salary) from telerikacademy.employees where d.DepartmentID = DepartmentID);
-- 4 Write a SQL query to find the average salary in the department #1.
select avg(Salary) from telerikacademy.employees where DepartmentID = 1;
-- 5 Write a SQL query to find the average salary  in the "Sales" department.
select avg(Salary) from (
select Salary from telerikacademy.employees e
join telerikacademy.departments d on e.DepartmentID = d.DepartmentID and d.Name = "Sales") as a;
-- 6 Write a SQL query to find the number of employees in the "Sales" department.
select count(EmployeeID) from (
select EmployeeID from telerikacademy.employees e
join telerikacademy.departments d on d.DepartmentID = e.DepartmentID and d.Name = "Sales") as l;
-- 7 Write a SQL query to find the number of all employees that have manager.
select count(EmployeeID) from telerikacademy.employees where ManagerID is not null;
-- 8 Write a SQL query to find the number of all employees that have no manager.
select count(EmployeeID) from telerikacademy.employees where ManagerID is null;
-- 9 Write a SQL query to find all departments and the average salary for each of them.
select avg(Salary), Name from (
select e.FirstName, e.LastName, e.Salary, d.Name from telerikacademy.employees e
join telerikacademy.departments d on e.DepartmentID = d.DepartmentID and Name = d.Name) as i group by Name;
-- 10 Write a SQL query to find the count of all employees in each department and for each town.
select t.Name, d.Name, count(e.EmployeeID) from telerikacademy.employees e
join telerikacademy.departments d on e.DepartmentID = d.DepartmentID
join telerikacademy.addresses a on e.AddressID = a.AddressID
join telerikacademy.towns t on t.TownID = a.TownID
group by d.Name, t.Name
order by t.Name;
-- 11 Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name. //7
select m.FirstName, m.LastName, count(e.EmployeeID) from telerikacademy.employees e
join telerikacademy.employees m on e.ManagerID = m.EmployeeID
group by e.ManagerID having count(e.EmployeeID) = 5;
-- 12 Write a SQL query to find all employees along with their managers. For employees that do not have manager display the value "(no manager)".
select e.FirstName, e.LastName, ifnull(m.FirstName, '(no manager)') as FirstNameManager, ifnull(m.LastName, '') as LastNameManager from telerikacademy.employees e
left join telerikacademy.employees m on e.ManagerID = m.EmployeeID;
-- 13 Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.
select e.FirstName, e.LastName from telerikacademy.employees e where e.LastName like "_____";
-- 14 Write a SQL query to display the current date and time in the following format "day.month.year hour:minutes:seconds:milliseconds".
select DATE_FORMAT(NOW(), '%e.%m.%Y %H:%i:%s:%f');
-- 15 Write a SQL query to display the average employee salary by department and job title.
select e.JobTitle, d.Name, avg(e.Salary) from telerikacademy.employees e
join telerikacademy.departments d on e.DepartmentID = d.DepartmentID
group by d.Name, e.JobTitle;
-- 16 Write a SQL query to display the town where maximal number of employees work.
select nameT, max(maxE) from (
select t.Name as nameT, count(e.EmployeeID) as maxE from telerikacademy.employees e
join telerikacademy.addresses a on e.AddressID = a.AddressID
join telerikacademy.towns t on t.TownID = a.TownID
group by t.TownID
) as q;
-- 17 Write a SQL query to display the number of managers from each town.
select t.Name, count(e.EmployeeID) from telerikacademy.employees e
join telerikacademy.addresses a on e.AddressID = a.AddressID
join telerikacademy.towns t on t.TownID = a.TownID
where e.EmployeeID in (select distinct ManagerID from telerikacademy.employees where ManagerID is not null)
group by t.TownID;

select t.Name, count(e.EmployeeID) ManagersCount
from telerikacademy.employees e
join telerikacademy.addresses a on a.AddressID = e.EmployeeID
join telerikacademy.towns t on t.TownID = a.TownID
where e.EmployeeID in (select distinct ManagerID from telerikacademy.employees where ManagerID is not null)
group by t.Name;
-- 18 Create a table Users. Users should have username, password, full name and last login time.
-- Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
-- Define the primary key column as auto-increment to facilitate inserting records.
-- Define unique constraint to avoid repeating usernames.
-- Define a check constraint to ensure the password is at least 5 characters long.
create table Users (
	UserID int primary key auto_increment,
	Username varchar(50) unique,
	Password varchar(50),
	FullName varchar(50),
	LastLoginTime timestamp,
	check(length(Password) > 4)
);
-- 19 Write SQL statements to insert in the Users table the names of all employees from the Employees table.
-- Combine the first and last names as a full name.
-- For username use the first 3 letters of the first name + the last name (in lowercase).
-- Use the same for the password.
-- Use HireDate for last login time.
insert into Users (Username, Password, FullName, LastLoginTime)
select
	concat(lower(substr(e.FirstName, 1, 3)), lower(e.LastName)) as Username,
	concat(lower(e.FirstName), lower(e.LastName)) as Password,
	concat(e.FirstName, ' ', e.LastName) as FullName,
	e.HireDate
from employees e;
-- 20 Write a SQL statement that changes the password to NULL for all users that have not been in the system since year 1999.
update Users
set Password = null
where year(LastLoginTime) < 2000;
-- 21 Write a SQL statement that deletes all users without passwords (NULL password).
delete from Users
where Password is null;