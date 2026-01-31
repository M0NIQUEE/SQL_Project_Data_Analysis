/*
QUESTION: What are the top-paying data analyst jobs?
- Identify the top 50 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- Why? Highlight the top-paying opportunities for Data Analysis, offering insights into employment option and location flexibility
- Wanted to specify specifically jobs that were either remote or in CA
*/

SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact AS job_postings
LEFT JOIN company_dim AS company ON company.company_id = job_postings.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    (job_work_from_home = TRUE OR job_location LIKE '%CA%') AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 50;

