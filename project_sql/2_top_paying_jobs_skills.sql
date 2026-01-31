/*
QUESTION: What skills are required for high-paying data analyst jobs?
-Use the top 50 highest-paying Data Analyst jobs from the first query
-Add the specific skills required for these roles
-Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        name AS company_name,
        job_title,
        salary_year_avg
    FROM job_postings_fact AS job_postings
    LEFT JOIN company_dim AS company ON company.company_id = job_postings.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        (job_location LIKE 'Anywhere' OR job_location LIKE '%CA') AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 50
)

SELECT
    top_paying_jobs.*,
    skills.skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim AS job_skills ON job_skills.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim AS skills ON skills.skill_id = job_skills.skill_id
ORDER BY 
    salary_year_avg DESC