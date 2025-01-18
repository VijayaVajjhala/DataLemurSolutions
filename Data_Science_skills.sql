-- using having clause
select candidate_id
from candidates
group by candidate_id
having sum(case when skill in ('Python','Tableau','PostgreSQL') then 1 else 0 end) = 3
order by candidate_id

select candidate_id
from candidates
where skill in ('Python','Tableau','PostgreSQL')
group by candidate_id
having count(*) = 3
order by candidate_id

-- string agg function
select candidate_id from (
SELECT candidate_id
,string_agg(skill,'|' order by skill) as all_skills
from candidates
group by candidate_id) a 
where all_skills = 'PostgreSQL|Python|Tableau'
order by candidate_id