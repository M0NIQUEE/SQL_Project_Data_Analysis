/*
QUESTION: What are the most in-demand skills for data analysts?
-Join job postings to inner join table similar to query 2
-Identify the top 5 in-demand skills for data analysts
-Focus on all job openings
-Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers
*/

SELECT
    skills,
    COUNT(job_skills.job_id) AS demand_count
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS job_skills ON job_skills.job_id = job_postings.job_id
INNER JOIN skills_dim AS skills ON skills.skill_id = job_skills.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
Noticed the trend for ALL data analyst jobs were sql -> excel -> python -> tableau -> power bi
When altering it to also only list remote jobs, the skills had the same trend
/*