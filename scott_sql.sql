/*____________________________________
 * Scott SQL Aufgaben
 *____________________________________
 */

/*1.*/
select dname, deptno, loc from dept;

/*2.*/
select * from emp;

/*3.*/
select ename, job, sal from emp where job = 'CLERK';

/*4.*/
select * from emp where deptno != 10;

/*5.*/
select ename from emp where comm > sal;

/*6.*/
select ename from emp where hiredate = '03.12.81';

/*7.*/
select ename, sal from emp where sal < 1250 or sal > 1600; /*1. Variante --> für Programmierer*/
select ename, sal from emp where sal not between 1250 and 1600; /*2. Variante --> in SQL besser*/
select ename, sal from emp where not (sal between 1250 and 1600); /*2. Variante anders formuliert*/
select ename, sal from emp where not (sal >= 1250 and sal <= 1600); /*3. Variante*/

/*8.*/
select * from emp where job != 'MANAGER' and job != 'PRESIDENT';
select * from emp where not (job = 'MANAGER' and job = 'PRESIDENT');
select * from emp where job in ('MANAGER', 'PRESIDENT'); /*besser in SQL*/

/*9.*/
select ename from emp where ename like '__A%';
select ename from emp where substr(ename, 3, 1) = 'A';

/*10.*/
select empno, ename, job from emp where not (comm = -1);
select * from emp where comm >= 0;
select * from emp where comm != null;

/*11.*/
select * from emp order by comm;

/*12.*/
select * from emp where not job in('MANAGER', 'PRESIDENT') order by deptno, hiredate desc;

/*13.*/
select ename from emp where length(ename) = 6;

/*14.*/
select ename || ' - ' /*<-- walschnauze :3*/ || job as MITARBEITER_JOB from emp where deptno = 30 ;
select concat(concat(ename, ' - '), job) as MITARBEITER_JOB from emp where deptno = 30;

/*15.*/
select ename, sal as MONTHLY, round(sal/22, 2) as DAILY, round((sal/22)/8, 2) as HOURLY from emp;

/*16.*/
select sum(sal) as GEHAELTER from emp;
select sum(sal) as GEHAELTER, min(sal), max(sal), round(avg(sal),2), count(sal), count(comm) from emp;

/*17.*/
select sum(coalesce(comm, 250)) from emp;
select sum(nvl(comm, 250)) from emp;

/*18.*/
select count(sal) as GEHALTSBEZIEHER, count(comm) as PROVISIONSBEZIEHER from emp where deptno=30;

/*19.*/
select distinct job from emp;

/*20.*/
select sum(sal) as SUMME_GEHAELTER, 
      sum(comm) as SUMME_PROVISION, 
      avg(sal) as DURCHSCHNITTSGEHALT, 
      avg(comm) as DURCHSCHNITTSPROVISION 
      from emp where deptno=30;
      
/*21.*/
select deptno, count(distinct job) as BERUFE from emp where not(job in('MANAGER', 'PRESIDENT')) group by deptno order by deptno;

/*22.*/
select avg(count(empno)) as MA_DURCHSCHNITT from emp group by deptno;

/*23.*/
select ename from emp where job in('PRESIDENT', 'MANAGER');

/*24.*/
select ename, job, comm from emp where comm >= sal*0.25;

/*25.*/
select min(sal + nvl(comm,0)) as AERMSTER from emp;

/*26.*/
select min(hiredate) as AELTESTER from emp;

/*27.*/
-- pro filiale und job die anzahl der mitarbeiter
select deptno, job, count(empno) from emp group by deptno, job;

/*28.*/
select min(max(sal)) from emp group by deptno;

/*29.*/
select min(sal), max(sal), round(avg(sal),2), deptno from emp group by deptno order by deptno;

/*30.*/

