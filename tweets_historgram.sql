with tweet_counts as (
SELECT user_id
,count(*) as bucket
FROM tweets
where date_part('year',tweet_date) = '2022'
group by user_id)

select bucket as tweet_bucket, count(*) as user_num
from tweet_counts
group by bucket