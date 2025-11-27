#Kerdezzuk le az EMP es DEPT tablak tartalmat
#describe emp;

select * from emp,dept where emp.deptno=dept.deptno;

select * from emp;

select * from dept;

#A 30. reszlegen dolgozok (DEPTNO=30) nevsorat

select ename  as nev  from emp where deptno=30 order by nev;

#A kulonbozo foglalkozasok listajat (DISTINCT)

select distinct job as foglalkozas from emp;

#A tisztviselok (JOB='CLERK') nevsorat

select ename  from emp where job = 'CLERK'order by ename asc;


#Azokat a managereket akik nem a 30-as reszlegen dolgoznak

select ename  from emp where job = 'MANAGER' and deptno !=30  order by ename asc;


#Azokat az alkalmazottakat akik vagy (managerek) vagy (tisztviselok a 10. reszlegrol)

select ename  from emp where job = 'MANAGER' or ( job = 'CLERK' and deptno =10 )  order by ename asc;

#Azokat akiknek neve az 'M' karakterrel kezdodik

select ename  from emp where ename like 'M%';

#Azokat akik nevenek hossza 5
 select ename  from emp where length(ename)=5;

#Azokat akik nevenek 3. betuje R

select ename  from emp where ename like '__R%';

#Azokat az alkalmazottakat akik nem kaptak premiumot (COMM IS NULL)

select ename,comm from emp where comm is   NULL   or comm=0;

#Listazzuk az alkalmazottakat a foglalkozasuk szerint es azon belul a fizetesuk szerint csokkeno sorrendbe (ORDER BY JOB, SAL DESC)

select ename ,job, sal from emp order by job asc , sal desc;


#Kepezzuk az EMP es a DEPT tablak descartesi szorzatat
select * from  emp,dept;


#Mondjuk meg melyik varosban dolgozik az ADAMS nevu alkalmazott
select   loc from dept ,emp where dept.deptno =emp.deptno and ename ="ADAMS";

#Listazzuk azokat a reszlegeket ameleyeknek van alkalmazottja, ezek nevsoraval es azokat
#a reszleget amelyeknek nincsenek alkalmazottaik (LEFT JOIN)
select  emp.deptno, loc, ename from emp  ,dept where dept.deptno=emp.deptno order by deptno;


#Azokat a reszlegeket amelyeknek nincs alkalmazottjuk
select dname, deptno  from dept where deptno not in ( select distinct deptno from emp );

#A CHICAGO-ban dolgozo alkalmazottak reszleget (DNAME) es azok osszes adatait (Lehetne igy is: A.* ?)
select emp.* from  emp, dept where dept.deptno=emp.deptno and loc='Chicago';

#Listazzuk minden alkalmazott fizetesbeli osztalyat az EMP es a SALGRDADE tablak JOIN osszekapcsolasa segitsegevel
select ename , sal, grade from emp inner join salgrade where sal >= losal and sal <= hisal;
#select ename , sal, grade from emp inner join salgrade where sal  BETWEEN losal and hisal;

#select ename , sal, grade, losal ,hisal from emp inner join salgrade where sal >= losal and sal <= hisal;

#A JONES-nal tobbet kereso alkalmazottak nevsorat (Probaljuk meg ezt egy ket tablas lekerdezessel)

select ename, sal from emp where sal>(select sal from emp where ename='JONES');

#Azokat az alkalmazottakat, fonokeiket es fizeteseiket akik tobbet keresnek a fonokuknel
select ename ,sal from emp,(select empno fno,  sal fsal from emp) as tmp where sal >fsal and mgr= fno;