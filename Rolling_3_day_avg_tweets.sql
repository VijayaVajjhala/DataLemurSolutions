
-- Using rows between in window function
select user_id
,tweet_date
,round(avg(tweet_count) over(partition by user_id
                     order by tweet_date
                     rows between 2 preceding and current row),2) as tweet_count 
from tweets

-- Using Self join
select a.user_id
,a.tweet_date
,round(avg(b.tweet_count),2) as tweet_count
from tweets a 
inner join tweets B 
on a.user_id = b.user_id
and b.tweet_date between a.tweet_date - INTERVAL '2 day' and a.tweet_date
group by a.user_id,a.tweet_date
order by a.user_id,a.tweet_date

-- Alternative solution using lag function
with rolling_tweets as (
select user_id
,tweet_date,tweet_count
,lag(tweet_count,1) over(partition by user_id order by tweet_date) as prev_tweet_cnt
,lag(tweet_count,2) over(partition by user_id order by tweet_date) as prev2_tweet_cnt
from tweets)

select user_id
,tweet_date
,case when prev_tweet_cnt is null then round(tweet_count/1.0,2)
      when prev2_tweet_cnt is null then round((tweet_count + prev_tweet_cnt) /2.0,2)
      else round((tweet_count + prev_tweet_cnt + prev2_tweet_cnt) /3.0,2)
 end as tweet_count
from rolling_tweets
order by user_id, tweet_date






