#This query allows me to obtain the average salary per country 
#i.e, Canada resident average salary for data science field is $97085
SELECT employee_residence, AVG(salary_in_usd) as Average_Salary_Per_Country
FROM ds_salaries
GROUP BY employee_residence
;

#This query gets the max salary and groups this max salary by employee_residence
#i.e, Canada Max Salary is 196,979 for data science field
SELECT employee_residence, MAX(salary_in_usd) as Max_Salary_Per_State
FROM ds_salaries
GROUP BY employee_residence
;

#This query allows me to obtain the average salary per state in the work year 2020 
#i.e, Canada resident average salary for data science field in 2020 is $117,104
SELECT employee_residence, AVG(salary_in_usd)
FROM ds_salaries
WHERE work_year = 2020
GROUP BY employee_residence
;

#What is the highest salary? highest salary is $600000
SELECT MAX(salary_in_usd) as Highest_Salary_Data_Science
FROM ds_salaries
;

#What is the highest salary per experience level
SELECT experience_level, MAX(salary_in_usd)
FROM ds_Salaries
GROUP BY experience_level
;

#Average Salary Per Experience level
SELECT experience_level, AVG(salary_in_usd)
FROM ds_salaries
GROUP BY experience_level
;

#count positions in each job title
SELECT job_title, COUNT(job_title) AS total_job
FROM ds_salaries
GROUP BY job_title
ORDER BY total_job DESC
;

#This query obtains the average salary per job title
#i.e, The average salary of a data scientist in 2020 is 85,970
SELECT job_title, AVG(salary_in_usd)
FROM ds_salaries
WHERE work_year = 2020
GROUP BY job_title
;
