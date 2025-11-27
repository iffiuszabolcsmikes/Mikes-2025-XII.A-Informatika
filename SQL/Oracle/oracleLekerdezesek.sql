select *
from emp e 

select * 
from salgrade 

#kik dolgoznak Chicagoban
select  e.*
from dept d
	join emp e on e.deptno =d.deptno 
where d.loc = "Chicago"

#legnagyobb fizetes
select ename, sal
from emp e
order by e.sal desc
limit 1

#atlag fizetes jobtype szerint
select avg(sal) atlag, job
from emp 
group by job 
order by atlag desc

#foglakozas lista
select distinct e.job
from emp e 

#harmincas reszlegen dolgozik
select *
from emp e
where deptno = 30

#azok a reszlegek ahol van alkalmazott
select distinct d.*
from dept d 
	inner join emp e on e.deptno =d.deptno 

#azok a reszlegek ahol nincs alkalmazott
select distinct d.*
from dept d 
	left join emp e on e.deptno =d.deptno 
where e.deptno  is null

#Johns nal tobbet keresok listaja
select *
from emp e
where sal > (select e2.sal from emp e2 where e2.ename = "Jones")

#ki keres tobbet a fonokenel
select e.ename 
from emp e
inner join emp fonok on e.mgr = fonok.empno 
where e.sal > fonok.sal

#azok a reszlegek ahol a fizetesek atlaga nagyobb mint 2000
select d.dname,  AVG(e.sal) atlag
from dept d 
inner join emp e on e.deptno =d.deptno 
group by d.dname 
having avg(e.sal) > 2000

#Irassuk ki azon alkalmazottak szamat es nevet akik egy olyan reszlegben dolgoznak amelyben van egy legalabb egy olyan alkalmazott akinek neve tartalamazza a 'T' karaktert.
#A fejlec:  Szam   Nev

select a.empno as Szam, a.ename as Nev
from emp a
inner join (
        select distinct d.deptno
        from emp e
        inner join dept d on d.deptno=e.deptno
        where e.ename like "%t%"
    ) s on a.deptno =s.deptno
