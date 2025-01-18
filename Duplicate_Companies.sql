-- using sub query
SELECT count(distinct company) as duplicate_companies 
from (
select company_id as company
from job_listings
group by company_id,title,description
having count(*) > 1
) a;

-- using self join
select count(distinct a.company_id)  as duplicate_companies
from job_listings a
inner join job_listings b 
on a.company_id = b.company_id
and a.title = b.title
and a.description = b.description
and a.job_id <> b.job_id

-- using count distinct 
select count(*) - count(distinct company_id || title || description)
from job_listings