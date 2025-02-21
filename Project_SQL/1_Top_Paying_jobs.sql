-- -- What are the top paying jobs for a Data Analyst?
-- - Identify top 10 highest paying jobs available remotely
-- - Remove Nulls Only job postings that exist


SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location, 
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
ORDER BY
    salary_year_avg DESC
LIMIT 10;


