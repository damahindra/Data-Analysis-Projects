-- Select all data from the table
Select * from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$

-- Let's take a look at the total of the data rows
Select count(*) AS Total_Rows from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$ 

-- I want to see the row with the highest salary, let's do that
select * from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
where Salary = (select max(Salary) from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$) -- the company with the highest salary is Thapar University

-- Let's select all the rows where the company is Thapar University
select * from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
where Company_Name = 'Thapar University' -- Oh, so Thapar University only has 1 Job role, which is SDE, but the salary is no game.

-- The Job Roles column is quite interesting, let's look at how many rows are there and select all the job roles
select count(distinct [Job_Roles]) as Total_job_roles from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
select distinct [Job_Roles] as Job_Roles from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$ -- 11 job roles

-- How about average salary by job role?
select [Job_Roles] as Job_Role, AVG([Salary]) as average_salary
from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
group by [Job_Roles]
order by [average_salary] desc -- By job role, Database has the highest salary average

-- Let's also see the Job Title
select count(distinct [Job_Title]) as Total_job_titles from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
select distinct [Job_Title] as Job_Titles from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$ -- 1080 job titles

-- Let's see how many job titles one job role carry
select [Job_Roles] as Job_Role, count([Job_Title]) as Job_Title_Count
from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
group by [Job_Roles]
order by [Job_Title_Count] desc -- so the job role with the most titles is SDE, while the job role with the most few job titles is Mobile
-- This shows that the data contains SDE job role the most which means people in this data is mostly has SDE job roles with different job_titles

-- Let's see the job title count which has the SDE job role
select Job_Title, count(Job_Title) as job_title_count
from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
where Job_Roles = 'SDE'
group by Job_Title
order by [job_title_count] desc -- This shows that the SDE job role has the Software Deelopment Engineer as the job title  with the highest count

-- Let's see the locations
select count(distinct [Location]) as Total_locations from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
select distinct [Location] as Locations from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$ -- 10 locations

-- I want to see how balanced the data is by the location
select distinct Location as locations, count(*) as data_count
from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
group by Location
order by data_count desc -- Bangalore has the highest data count, while Jaipur has the lowest data count

-- I want to take a look at the average salary by location
select [Location] as Location, AVG([Salary]) as average_salary
from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
group by [Location]
order by [average_salary] desc -- As we can see Mumbai has the highest salary average out of all the other locations

-- let's look at the sum of salary by location
select [Location] as Location, SUM([Salary]) as average_salary
from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
group by [Location]
order by [average_salary] desc -- if we switch to sum we can see that Bangalore rises to the top and jaipur goes to the bottom
-- this is due to the fact that the location count is indeed the highest in bangalore and the lowest in jaipur

-- we haven't looked at the rating yet, let's look at it
-- company with the highest rating
select * from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
order by Rating desc -- format is wrong

-- let's fix it
update [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
set Rating = Rating/10
where Rating != 395 and Rating != 385 

update [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
set Rating = Rating/100
where Rating = 395 or Rating = 385
-- now data format is correct

-- let's count the data with a perfect rating of 5
select Rating, count(*) as data_count
from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
where Rating = 5
group by Rating -- there are 672 rows of data with a perfect rating of 5

-- We haven't see data salary by rating
select Rating, AVG(Salary) as average_salary
from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
group by Rating
order by average_salary desc -- hmm, the top average_salary oddly has a very low rating
-- this shows that the rating of the company does not affect the salary, since there are no linear similarity
-- however, that might indicate that the company has a bad environment

-- so, it's safe to say that it's best to choose for a job with a minimum  rating of 4 (good environment)

-- best choice for trainees
select * from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
where Rating >= 4 and Employment_Status = 'Trainee'
order by Salary desc

-- best choice for interns
select * from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
where Rating >= 4 and Employment_Status = 'Intern'
order by Salary desc

-- best choice for Full timers
select * from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
where Rating >= 4 and Employment_Status = 'Full Time'
order by Salary desc

-- best choice for contractors
select * from [Software Industry].dbo.Salary_Dataset_with_Extra_Featu$
where Rating >= 4 and Employment_Status = 'Contractor'
order by Salary desc
