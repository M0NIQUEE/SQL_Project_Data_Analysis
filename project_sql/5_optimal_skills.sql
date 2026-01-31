/*
ANSWER: What are the most optimal skills to learn (aka it's in high demand and high paying skill)
-Identify skills in high demand and associated with high average salaries for Data Analyst roles
-Concentrate on remote positions with specified salaries
-Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
*/

WITH skills_demand AS(
    SELECT
        skills.skill_id,
        skills,
        COUNT(job_skills.job_id) AS demand_count
    FROM
        job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS job_skills ON job_skills.job_id = job_postings.job_id
    INNER JOIN skills_dim AS skills ON skills.skill_id = job_skills.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills.skill_id
), average_salary AS (
    SELECT
        skills.skill_id,
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
        skills.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON average_salary.skill_id = skills_demand.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;