-- What are the top skills based on salary?
-- Average salary associated with each skill for Data Analyst
-- It looks at how skills impact the salaries

SELECT
    ROUND(AVG(salary_year_avg),0) AS Average_salary,
    skills
FROM job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    Average_salary DESC
limit 25;