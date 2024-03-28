/* Basic querying */
create table EmployeeDemographics
(EmployeeID int, FirstName varchar(50), 
LastName varchar(50),
Age int, Gender varchar (50)
); 

create table EmployeeSalary
(EmployeeID int, 
JobTtitle varchar(50), 
Salary int);

insert into Employeedemographics values
(1001, 'Jim', 'Helpert', 18, 'Male'),
(1002, 'Pam', 'Beasley', 18, 'Female'),
(1003, 'Dwight', 'schrute', 19, 'Male'),
(1004, 'Angela', 'Martin', 19, 'Female'),
(1005, 'Toby', 'Flenderson', 20, 'Male'),
(1006, 'Micheal', 'Scott', 24, 'Male'),
(1007, 'Meredith', 'Palmer', 26, 'Female'),
(1008, 'Stanley', 'Hudson', 28, 'Male'),
(1009, 'Kevin', 'Malone', 20, 'Male');

insert into Employeesalary values
(1001, 'Salesman', 15000),
(1002, 'Receptionist', 10000),
(1003, 'Salesman', 18000),
(1004, 'Accountant', 16000),
(1005, 'HR', 14000),
(1006, 'Regional manager', 20000),
(1007, 'Supplier Relation', 10000),
(1008, 'Salesman', 13000),
(1009, 'Accountant', 17000);

/*basic queries*/

select * from employeedemographics;
select * from employeesalary;
select distinct * from employeesalary limit 3;
select count(employeedemographics.Lastname) from employeedemographics;

select Gender, count(Gender) as number from employeedemographics
where age>21
group by Gender
order by number desc;


SELECT 
    employeedemographics.Gender,
    MAX(employeesalary.salary) AS maximumsalary
FROM
    employeedemographics
        LEFT OUTER JOIN
    employeesalary ON employeedemographics.EmployeeID = employeesalary.EmployeeID
GROUP BY employeedemographics.Gender
ORDER BY maximumsalary DESC;


SELECT 
    employeedemographics.EmployeeID,
    employeedemographics.Gender,
    AVG(employeesalary.Salary) AS averagesalary
FROM
    employeedemographics
        LEFT OUTER JOIN
    employeesalary ON employeedemographics.EmployeeID = employeesalary.EmployeeID
GROUP BY employeedemographics.Gender
ORDER BY averagesalary DESC;


SELECT * FROM employeedemographics AS emp LEFT OUTER JOIN employeesalary AS sal 
ON emp.EmployeeID = sal.EmployeeID
GROUP BY emp.EmployeeID ASC;


SELECT sal.jobtitle, AVG(sal.salary) AS avgsalary FROM employeedemographics as emp
LEFT OUTER JOIN employeesalary AS sal ON emp.EmployeeID = sal.EmployeeID
GROUP BY sal.JobTtitle;


/*intermediate querying*/

insert into employeedemographics values 
(1011, 'Ryan', 'Howards', 16, 'Male' ),
(NULL, 'Holly', 'Flax', null, 'Female' ),
(1013, 'darryl', 'Philibin', null, 'Male' );

insert into employeesalary values
(1010, null, 21000),
(null, 'Salesman', 17000);

select * from employeedemographics;
select * from employeesalary;

select * from employeedemographics inner join employeesalary
on employeedemographics.employeeid=employeesalary.employeeid ;

select * from employeedemographics left join employeesalary
on employeedemographics.EmployeeID=employeesalary.EmployeeID;

select * from employeedemographics right join employeesalary
on employeedemographics.EmployeeID=employeesalary.EmployeeID;

select * from employeedemographics full outer join employeesalary
on employeedemographics.EmployeeID=employeesalary.EmployeeID;

/* union  by adding a new table*/

insert into employeedemographics values
(1011, 'Ryan', 'Howard', 26, 'Male'),
(null, 'Holy', 'Flax', null, 'null'),
(1013, 'Daryl', 'Philbin', null, 'Male');

create table  warehouseemployeedemographics
(employeeid int, firstname varchar(50), 
lastname varchar(50), age int, gender varchar(50));

insert into warehouseemployeedemographics values
(1013, 'darryl', 'philbin', null, 'male'),
(1050, 'roy', 'anderson', 20, 'male'),
(1051, 'hidetoshi', 'hasagawa', 22, 'male'),
(1052, 'val', 'johnson', 20, 'female');

select * from employeedemographics;
select * from employeesalary;
select * from warehouseemployeedemographics;

delete from employeedemographics
where employeedemographics.FirstName in ('ryan', 'holly', 'darryl');

select * from employeedemographics;

insert into employeedemographics values 
(1011, 'Ryan', 'Howard', 26, 'Male'),
(null, 'Holy', 'Flax', null, 'null'),
(1013, 'Daryl', 'Philbin', null, 'Male');

select * from employeedemographics
union 
select * from warehouseemployeedemographics;

select * from employeedemographics full outer join warehouseemployeedemographics
on employeedemographics.EmployeeID=warehouseemployeedemographics.employeeid;

select * from employeedemographics
union all
select * from warehouseemployeedemographics;

select employeedemographics.FirstName, employeedemographics.LastName, employeesalary.Salary, employeesalary.JobTtitle,
case 
     when salary > 19000 then 'high'
     when salary between 17000 and 19000 then 'medium'
     when salary between 14000 and 17000 then 'low'
     else 'very low'
      end as salaryband
      from employeedemographics inner join employeesalary
      on employeedemographics.EmployeeID=employeesalary.EmployeeID
      order by salaryband desc;
      
      
      select jobtitle, avg(salary) as avgsal from employeedemographics inner join employeesalary
      on employeedemographics.EmployeeID = employeesalary.EmployeeID
      order by jobtitle;

/* using CTE */

with salary_per_title(title,average_salary)
as
  (select jobtitle, avg(salary) as avgssal from employeedemographics inner join employeesalary 
  on employeedemographics.employeeid=employeesalary.employeeid
  group by jobtitle)
  select * from salary_per_title
  where title in ('hr', 'salesman');
  
  /*using temp table*/
  
  create table salary_per_title (title varchar(50), salary_average int);
  
  insert into salary_per_title
  select jobtitle , avg(salary) as avgsal from employeedemographics inner join employeesalary
  on employeedemographics.employeeid=employeesalary.employeeid
  group by jobtitle;
  
  select title from salary_per_title;
  
  /* string function on error data*/
  
  create table employeeerrors( employeeid varchar(50), firstname varchar(50), lastname varchar(50));

insert into employeeerrors value
 ('1001 ', 'jimpo', 'helbert'),
 ('  1002' , 'pamela', 'beesley'),
 ('1005', 'tont' , 'flendersob');
 
 -- using trim , ltrim, rtrim
 
 select * from employeeerrors;
 
 select employeeid, trim(employeeid) as idtrim
 from employeeerrors;
 
-- using replace

select lastname,  REPLACE(lastname, 'flendersob','flenderson') as last_name_fixed
from  employeeerrors ;
 
 select lastname,  REPLACE(lastname, 'beesley','beasley') as last_name_fixed
from  employeeerrors ;


select lastname, REPLACE(lastname, 'helbert','helpert') as last_name_fixed
from  employeeerrors ;

-- using substring

select substring(err.firstname,1,3) = substring(dem.firstname,1,3), substring(err.lastname,1,3),
substring(dem.lastname,1,3) from employeeerrors err
join employeedemographics dem
on substring(err.firstname,1,3) = substring(dem.firstname,1,3)
and substring(err.lastname,1,3) = substring(dem.lastname,1,3);

-- using upper and lower 

select firstname, lower(firstname)
from employeeerrors;

select firstname, upper(firstname)
from employeeerrors;

/* using subqueries*/

select employeeid, jobtitle, salary
from employeesalary;

-- subquery in select

select employeeid, salary, (select avg(salary) from employeesalary) as allavgsalary
from employeesalary;

-- partition by

select employeeid, salary, avg(salary) over () as allavgsalary
from employeesalary;

-- using group by

select employeeid, salary, avg(salary) as allavgsalary
from employeesalary
group by employeeid, salary
order by employeeid;

-- subquery in from

select a.employeeid, allavgsalary 
from (select employeeid, salary, avg(salary) over() as allavgsalary from employeesalary) a
order by a.employeeid;

-- subquery in where

select employeeid, jobtitle, salary
from employeesalary
where EmployeeID in (select employeeid from employeedemographics where age > 20);
