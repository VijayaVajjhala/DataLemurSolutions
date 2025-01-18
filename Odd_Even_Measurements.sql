with measurement_base as (
select measurement_value
,to_char(measurement_time,'YYYY-mm-dd') as ms_date
,row_number() over(partition by to_char(measurement_time,'YYYY-mm-dd') order by measurement_time) as row_num
from measurements)

select ms_date::timestamp
,sum(case when row_num%2 !=0 then measurement_value else 0 end) as odd_sum
,sum(case when row_num%2 = 0  then measurement_value else 0 end) as even_sum
from measurement_base
group by ms_date