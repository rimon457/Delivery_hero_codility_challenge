create temp table senior as
select count(*) senior_dev, coalesce (sum(salary),0) as first_budget
from
(select bh3.*, sum(salary) over (order by salary) as senior_budget 
from budget_hiring_2 bh3 
where position='senior' 
order by salary) s
where s.senior_budget <=50000;

create temp table junior as
select count(*) junior_dev, sum(salary) as last_budget
from
(select bh3.*, sum(salary) over (order by salary) as junior_budget 
from budget_hiring_2 bh3 
where position='junior' 
order by salary) j
where j.junior_budget <=50000-(select first_budget from senior);

select (select junior_dev from junior),
        (select senior_dev from senior);

-- drop table senior;
-- drop table junior;
