/*
QUESTION: What are the top-paying skills based on salary?
-Look at the average salary associated with each skill for Data Analyst postiions
-Focuses on roles with specified salaries regardless of location
-Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS job_skills ON job_skills.job_id = job_postings.job_id
INNER JOIN skills_dim AS skills ON skills.skill_id = job_skills.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
Place Analysis here
*/