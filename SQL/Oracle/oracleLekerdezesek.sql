select *
from emp e 

select * 
from salgrade 

select *
from emp 


#kik dolgoznak Chicagoban
select  e.*
from dept d
	join emp e on e.deptno =d.deptno 
where d.loc = "Chicago"

#nagy fizetes
select ename, sal
from emp e
order by e.sal desc
limit 1

#atlag fizetes jobtype szerint
select avg(sal) atlag, job
from emp 
group by job 
group by atlag desc


#foglakozas lista
select distinct(e.job) 
from emp e 

#harmincas rezlege ndolgozik
select *
from emp e
amy-hnkd-vte
