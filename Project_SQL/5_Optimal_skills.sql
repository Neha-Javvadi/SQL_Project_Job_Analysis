-- What are the most optimal skills to learn? (in demand and highest paying)


WITH Top_demanded_skills AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS Demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), Avg_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg),0) AS Average_salary 
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        salary_year_avg IS NOT NULL AND
        job_title_short = 'Data Analyst'
    GROUP BY skills_job_dim.skill_id )

SELECT
    Top_demanded_skills.skill_id,
    Top_demanded_skills.skills,
    Demand_count,
    Average_salary
FROM Top_demanded_skills
INNER JOIN Avg_salary ON Top_demanded_skills.skill_id = Avg_salary.skill_id
WHERE
    Demand_count > 10
ORDER BY
    Average_salary DESC,
    Demand_count DESC
    