select * from empleados;
select * from departamentos;
select * from empleados as e 
inner join departamentos as d on e.id_depto = d.id_depto
order by d.nombre_depto;
select nombre_depto from departamentos;
select nombre, sal_emp from empleados;
select comision_emp from empleados;
select * from empleados
where cargo_emp = 'Secretaria';
select * from empleados
where cargo_emp = 'Vendedor'
order by nombre asc;
select nombre, cargo_emp, sal_emp from empleados
order by sal_emp asc;
/*Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad
de “Ciudad Real”*/
select e.nombre, e.cargo_emp, d.ciudad from empleados as e
inner join departamentos as d on d.id_depto = e.id_depto
where d.ciudad = 'CIUDAD REAL' and e.cargo_emp like 'jefe%';
/*Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las
respectivas tablas de empleados.*/
select e.nombre as 'Nombre', e.cargo_emp as 'Cargo' from empleados as e;
/*Listar los salarios y comisiones de los empleados del departamento 2000, ordenado
por comisión de menor a mayor.*/
select e.nombre, e.sal_emp, e.comision_emp, d.id_depto from empleados as e
inner join departamentos as d on d.id_depto = e.id_depto
where e.id_depto = 2000;
/*Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del
empleado y el total a pagar, en orden alfabético.*/
select e.nombre, e.sal_emp+e.comision_emp+500 as 'TotalAPagar', d.id_depto from empleados as e
inner join departamentos as d on d.id_depto = e.id_depto
where d.id_depto = 3000;
/*Muestra los empleados cuyo nombre empiece con la letra J.*/
select e.nombre from empleados as e
where e.nombre like 'j%';
/*Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos
empleados que tienen comisión superior a 1000.*/
select e.nombre, e.comision_emp, e.sal_emp, e.comision_emp+e.sal_emp as SalarioTotal 
from empleados as e
where e.comision_emp > 1000;
/*Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen
comisión.*/
select e.nombre, e.comision_emp, e.sal_emp, e.comision_emp+e.sal_emp as SalarioTotal 
from empleados as e
where e.comision_emp = 0;
/*Obtener la lista de los empleados que ganan una comisión superior a su sueldo.*/
select e.nombre, e.comision_emp, e.sal_emp, e.comision_emp+e.sal_emp as SalarioTotal 
from empleados as e
where e.comision_emp > e.sal_emp;
/*Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.*/
select e.nombre, e.comision_emp, e.sal_emp, e.comision_emp+e.sal_emp as SalarioTotal 
from empleados as e
where e.comision_emp <= e.sal_emp*0.3;
/*Hallar los empleados cuyo nombre no contiene la cadena “MA”*/
select nombre from empleados
where nombre not like '%MA%';
/*Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o
‘Mantenimiento.*/
select * from departamentos as d
where d.nombre_depto in ('Ventas', 'Investigación', 'Mantenimiento');
/*Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni
“Investigación” ni ‘Mantenimiento.*/
select * from departamentos as d
where d.nombre_depto not in ('Ventas', 'Investigación', 'Mantenimiento');
/*Mostrar el salario más alto de la empresa.*/
select max(sal_emp) from empleados;
/*22. Mostrar el nombre del último empleado de la lista por orden alfabético.*/
select nombre from empleados
order by nombre desc limit 1;
/*23. Hallar el salario más alto, el más bajo y la diferencia entre ellos.*/
select max(e.sal_emp), min(e.sal_emp), max(e.sal_emp)-min(e.sal_emp) as 'Diferencia'
 from empleados as e;
/*24. Hallar el salario promedio por departamento.*/
select avg(e.sal_emp), max(e.sal_emp), min(e.sal_emp), d.nombre_depto from empleados as e
inner join departamentos as d on d.id_depto = e.id_depto
group by d.nombre_depto;
/*Consultas con Having
25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de
empleados de esos departamentos.*/
select count(*) as 'CantEmpl', d.nombre_depto from empleados as e
inner join departamentos as d on e.id_depto = d.id_depto
group by d.nombre_depto;
/*26. Hallar los departamentos que no tienen empleados
Consulta Multitabla (Uso de la sentencia JOIN/LEFT JOIN/RIGHT JOIN)*/
select count(e.id_emp) as 'CantEmp', d.nombre_depto from empleados as e
right join departamentos as d on e.id_depto = d.id_depto
group by d.nombre_depto
order by CantEmp;
/*27. Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada
departamento.
NO SE PUDO RESOLVER*/
select e.*, d.*, j.nombre as 'Jefe'
from empleados as e
inner join departamentos as d on d.id_depto = e.id_depto
inner join empleados as j on j.cod_jefe = d.cod_director;
/*Consulta con Subconsulta
28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la
empresa. Ordenarlo por departamento.*/
select e.*, d.nombre_depto, (select round(avg(sal_emp)) from empleados) as 'Promedio'
from empleados as e
inner join departamentos as d on d.id_depto = e.id_depto
where e.sal_emp >= (select avg(sal_emp) from empleados)
order by d.nombre_depto asc;