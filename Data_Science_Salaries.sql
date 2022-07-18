#This query allows me to obtain the average salary per country 
#i.e, US resident average salary for data science field is $149,194
SELECT employee_residence, AVG(salary_in_usd) as Average_Salary_Per_State
FROM ds_salaries
GROUP BY employee_residence
;

#counts job title and groups jobs by employee residence 
SELECT employee_residence, COUNT(job_title) AS j
FROM ds_salaries
GROUP BY employee_residence
ORDER BY j DESC
;

#counts jobs of data science in US
#54% of data science jobs are in the U.S based on this dataset
SELECT employee_residence, COUNT(job_title)/607*100 AS percentage_of_jobs_in_the_US_from_the_dataset
FROM ds_salaries
WHERE employee_residence = 'US'
;

#This query allows me to obtain the average salary per country in the work year 2020 
#i.e, US resident average salary for data science field in 2020 is $157,462
SELECT employee_residence, AVG(salary_in_usd)
FROM ds_salaries
WHERE work_year = 2020
GROUP BY employee_residence
;

#This query gets the max salary and groups this max salary by employee_residence
#i.e, US Max Salary is 600,000 for data science field
SELECT employee_residence, MAX(salary_in_usd) as Max_Salary_Per_State
FROM ds_salaries
GROUP BY employee_residence
;

#What is the highest salary? highest salary is $600,000
SELECT MAX(salary_in_usd) as Highest_Salary_Data_Science
FROM ds_salaries
;

#What is the highest salary per experience level
SELECT experience_level, MAX(salary_in_usd)
FROM ds_Salaries
GROUP BY experience_level
;

#count jobs and groups by job title
SELECT job_title, COUNT(job_title) AS total_job
FROM ds_salaries
GROUP BY job_title
ORDER BY total_job DESC
;

#53% chance of making equal to or more than $100,000 in the data science field 
SELECT ((SELECT COUNT(id) AS id_ FROM ds_salaries WHERE salary_in_usd >= 100000)/(SELECT COUNT(id) FROM ds_salaries))*100 AS Chances_of_making_more_200000
;

#57% chance of a data analyst making equal to or more than $70,000
SELECT ((SELECT COUNT(id) AS id_ FROM ds_salaries WHERE salary_in_usd >= 90000 and job_title = 'Data Analyst')/(SELECT COUNT(id) FROM ds_salaries WHERE job_title = 'Data Analyst'))*100 AS Chances_of_making_more_than50000
;
