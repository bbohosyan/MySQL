-- 595. Big Countries
select name, population, area from World
where area > 3000000 or population > 25000000;
-- 620. Not Boring Movies
select * from cinema
where id%2 = 1 and description <> "boring"
order by rating desc;
-- 182. Duplicate Emails
select distinct p1.Email from Person p1
where (select count(p2.Id) from Person p2 where p2.Email = p1.Email having count(p2.Id) > 1);
-- 175. Combine Two Tables
select p.FirstName, p.LastName, a.City, a.State from Person p
left join Address a on p.PersonId = a.PersonId;
-- 181. Employees Earning More Than Their Managers
select e.Name as Employee from Employee e
join Employee m on e.ManagerId = m.Id
where e.Salary > m.Salary;
-- 183. Customers Who Never Order
select c.Name as Customers from Customers c
left join Orders o on c.Id = o.CustomerId
where CustomerId is null;
-- 627. Swap Salary
UPDATE salary SET sex = CASE sex 
                          WHEN 'f' THEN 'm' 
                          WHEN 'm' THEN 'f' 
                        END;
-- 596. Classes More Than 5 Students
select class from(
select class, count(student) from (
select distinct c1.student, c1.class from courses c1) q
group by class
having count(student) >= 5) w;