/*1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.*/
select codigo_oficina, ciudad from oficina;
/*2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.*/
select * from oficina
where pais = 'españa';
/*3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un
código de jefe igual a 7.*/
select nombre, apellido1, apellido2, email from empleado
where codigo_jefe = 7;
/*4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.*/
select nombre, apellido1, apellido2, email, puesto from empleado
where puesto = 'director general';
/*5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
representantes de ventas.*/
select nombre, apellido1, apellido2, puesto from empleado
where puesto != 'representante ventas';
/*6. Devuelve un listado con el nombre de los todos los clientes españoles.*/
select e.nombre, o.pais from empleado e
inner join oficina o on e.codigo_oficina=o.codigo_oficina
where o.pais = 'españa';
/*7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.*/
select distinct estado from pedido;
/*8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
o Utilizando la función YEAR de MySQL.
o Utilizando la función DATE_FORMAT de MySQL.
o Sin utilizar ninguna de las funciones anteriores.*/
select distinct p.codigo_cliente from pago p
where fecha_pago like '2008%';
/*9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos que no han sido entregados a tiempo.*/
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido
where fecha_esperada<fecha_entrega;
/*10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
o Utilizando la función ADDDATE de MySQL.
o Utilizando la función DATEDIFF de MySQL.*/
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido
where adddate(fecha_entrega, interval 2 day)<=fecha_esperada;
/*11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.*/
select * from pedido
where estado='rechazado' 
and YEAR(fecha_pedido) = 2009;
/*12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de
cualquier año.*/
select * from pedido
where estado = 'entregado'
and date_format(fecha_entrega, '%m')='01';
/*13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
Ordene el resultado de mayor a menor.*/
select * from pago
where YEAR(fecha_pago)=2008
and forma_pago='paypal';
/*14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
cuenta que no deben aparecer formas de pago repetidas.*/
select distinct forma_pago from pago;
/*15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
venta, mostrando en primer lugar los de mayor precio.*/
select * from producto
where cantidad_en_stock>100
and gama='ornamentales'
order by precio_venta desc;
/*16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
representante de ventas tenga el código de empleado 11 o 30.*/
select * from cliente
where ciudad = 'madrid'
and codigo_empleado_rep_ventas=11 
or codigo_empleado_rep_ventas=30;
/*Consultas multitabla (Composición interna)
Las consultas se deben resolver con INNER JOIN.
1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante
de ventas.*/
select c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado;
/*2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
representantes de ventas.*/
select p.id_transaccion, c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join pago p on p.codigo_cliente = c.codigo_cliente;
/*3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de
sus representantes de ventas.*/
select p.id_transaccion, c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
left outer join pago p on p.codigo_cliente = c.codigo_cliente;
where p.id_transaccion is null;
/*4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.*/
select p.id_transaccion, c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join pago p on p.codigo_cliente = c.codigo_cliente
inner join oficina o on o.codigo_oficina = e.codigo_oficina;
/*5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
select distinct c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on o.codigo_oficina = e.codigo_oficina
left join pago p on p.codigo_cliente = c.codigo_cliente
where p.id_transaccion is null;
/*6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/
select o.*, c.ciudad from oficina o
inner join empleado e on e.codigo_oficina=o.codigo_oficina
inner join cliente c on c.codigo_cliente=e.codigo_empleado
where c.ciudad = 'Fuenlabrada';
/*7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
de la oficina a la que pertenece el representante.*/
select c.nombre_cliente, e.nombre, o.ciudad from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina;
/*8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.*/
select e.nombre, e.apellido1, e1.nombre as 'Jefe', e1.apellido1 from empleado e
inner join empleado e1 on e.codigo_jefe=e1.codigo_empleado;
/*9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.*/
select distinct c.nombre_cliente from pedido p
inner join cliente c on p.codigo_cliente=c.codigo_cliente
where p.fecha_esperada<p.fecha_entrega;
/*10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
Consultas multitabla (Composición externa)*/
select distinct p.gama, c.nombre_cliente from detalle_pedido dp
inner join producto p on dp.codigo_producto=p.codigo_producto
inner join pedido pe on dp.codigo_pedido=pe.codigo_pedido
inner join cliente c on pe.codigo_cliente=c.codigo_cliente;
/*Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.
1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
select c.* from cliente c
left join pago p on c.codigo_cliente=p.codigo_cliente
where p.codigo_cliente is null;
/*2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
pedido.*/
select c.* from cliente c
left join pedido p on c.codigo_cliente=p.codigo_cliente
where p.codigo_cliente is null;

/*****DIFERENCIA ENTRE 2 TABLAS*******/
select c.* from cliente c
left join pago p on c.codigo_cliente=p.codigo_cliente
where p.codigo_cliente is null
and c.codigo_cliente not in (
select c.codigo_cliente from cliente c
left join pedido p on c.codigo_cliente=p.codigo_cliente
where p.codigo_cliente is null);

/*3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que
no han realizado ningún pedido.*/
select c.* from cliente c
where c.codigo_cliente in (
select distinct c1.codigo_cliente from cliente c1
left join pago p on c1.codigo_cliente=p.codigo_cliente
left join pedido pe on c1.codigo_cliente=pe.codigo_cliente
where pe.codigo_cliente is null 
or p.codigo_cliente is null);
/***** OTRA FORMA *******/
select c.* from cliente c
left join pago p on c.codigo_cliente=p.codigo_cliente
where p.codigo_cliente is null
union
select c.* from cliente c
left join pedido p on c.codigo_cliente=p.codigo_cliente
where p.codigo_cliente is null;

/*4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina
asociada.*/
select * from empleado e
left join oficina o on e.codigo_oficina=o.codigo_oficina
where o.codigo_oficina is null
order by e.codigo_empleado;
/*5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente
asociado.*/
select e.* from empleado e
left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
where c.codigo_cliente is null;
/*6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
que no tienen un cliente asociado.*/
select e.* from empleado e
left join oficina o on e.codigo_oficina=o.codigo_oficina
where o.codigo_oficina is null
union
select e.* from empleado e
left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
where c.codigo_cliente is null;
/*7. Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
select p.* from producto p
left join detalle_pedido dp on p.codigo_producto=dp.codigo_producto
where dp.codigo_producto is null;
/*8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto
de la gama Frutales.*/
select * from oficina;
select distinct o.* from oficina o
where o.codigo_oficina not in (
select distinct o.codigo_oficina from oficina o
left join empleado e on o.codigo_oficina=e.codigo_oficina
left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
left join pedido p on c.codigo_cliente=p.codigo_cliente
left join detalle_pedido dp on p.codigo_pedido=dp.codigo_pedido
left join producto pr on dp.codigo_producto=pr.codigo_producto
where pr.gama='Frutales');

/*9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
ningún pago.*/
select distinct c.* from cliente c
inner join pedido p on c.codigo_cliente=p.codigo_cliente
left join pago pg on c.codigo_cliente=pg.codigo_cliente
where pg.id_transaccion is null;
/*10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
nombre de su jefe asociado.*/
select distinct e.*, CONCAT(e1.nombre,' ',e1.apellido1,' ',e1.apellido2) as 'Jefe' from empleado e
left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
left join empleado e1 on e.codigo_jefe=e1.codigo_empleado
where c.codigo_cliente is null;
/*Consultas resumen
1. ¿Cuántos empleados hay en la compañía?*/
select count(*) from empleado;
/*2. ¿Cuántos clientes tiene cada país?*/
select count(*), c.pais from cliente c
group by c.pais;
/*3. ¿Cuál fue el pago medio en 2009?*/
select avg(p.total) from pago p
where YEAR(p.fecha_pago)=2009;
/*4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
número de pedidos.*/
select count(*), p.estado from pedido p
group by p.estado;
/*5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.*/
select MAX(p.precio_venta), MIN(p.precio_venta) from producto p;
/*6. Calcula el número de clientes que tiene la empresa.*/
select count(*) from cliente;
/*7. ¿Cuántos clientes tiene la ciudad de Madrid?*/
select count(*) from cliente c
where c.ciudad='madrid';
/*8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?*/
select count(*), c.ciudad from cliente c
where c.ciudad like 'm%'
group by ciudad;
/*9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
cada uno.*/
select e.nombre, e.apellido1, count(*) from empleado e
inner join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
group by e.codigo_empleado;
/*10. Calcula el número de clientes que no tiene asignado representante de ventas.*/
select count(*) from cliente c
left join empleado e on c.codigo_empleado_rep_ventas=e.codigo_empleado
where e.codigo_empleado is null;
/*11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
deberá mostrar el nombre y los apellidos de cada cliente.*/
select min(p.fecha_pago), max(p.fecha_pago), c.nombre_contacto, c.apellido_contacto  from cliente c
inner join pago p on c.codigo_cliente=p.codigo_cliente
group by c.codigo_cliente;
/*12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.*/
select count(*) as cantidad, codigo_producto from detalle_pedido
group by codigo_producto
order by cantidad desc;
/*13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de
los pedidos.*/
select sum(cantidad), codigo_producto from detalle_pedido
group by codigo_producto;
/*14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que
se han vendido de cada uno. El listado deberá estar ordenado por el número total de
unidades vendidas.*/
select sum(cantidad) as 'Total_unidades_vendidas', codigo_producto from detalle_pedido
group by codigo_producto
order by Total_unidades_vendidas desc limit 20;
/*15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el
IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el
número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base
imponible, y el total la suma de los dos campos anteriores.*/
select sum(cantidad*precio_unidad) as base_imponible, 
sum(cantidad*precio_unidad)*0.21 as iva,
sum(cantidad*precio_unidad)+ sum(cantidad*precio_unidad)*0.21 as Total
from detalle_pedido;
/*16. La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
select sum(cantidad*precio_unidad) as base_imponible, 
sum(cantidad*precio_unidad)*0.21 as iva,
sum(cantidad*precio_unidad)+ sum(cantidad*precio_unidad)*0.21 as Total,
codigo_producto
from detalle_pedido dp
group by dp.codigo_producto;
/*17. La misma información que en la pregunta anterior, pero agrupada por código de producto
filtrada por los códigos que empiecen por OR.*/
select sum(cantidad*precio_unidad) as base_imponible, 
sum(cantidad*precio_unidad)*0.21 as iva,
sum(cantidad*precio_unidad)+ sum(cantidad*precio_unidad)*0.21 as Total,
codigo_producto
from detalle_pedido dp
group by dp.codigo_producto
having dp.codigo_producto like 'or%';
/*18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se
mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21%
IVA)*/
select p.nombre, count(*) as unidades_vendidas, sum(cantidad*precio_unidad) as total, 
sum(cantidad*precio_unidad)+ sum(cantidad*precio_unidad)*0.21 as total_con_impuestos,
dp.codigo_producto
from detalle_pedido dp
inner join producto p on dp.codigo_producto= p.codigo_producto
group by dp.codigo_producto
having total>3000;
/*Subconsultas con operadores básicos de comparación
1. Devuelve el nombre del cliente con mayor límite de crédito.*/
select * from cliente
where limite_credito=(
select max(limite_credito) from cliente);
/*2. Devuelve el nombre del producto que tenga el precio de venta más caro.*/
select * from producto
where precio_venta=(
select max(precio_venta) from producto);
/*3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta
que tendrá que calcular cuál es el número total de unidades que se han vendido de cada
producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código
del producto, puede obtener su nombre fácilmente.)*/
select * from producto p
where p.codigo_producto=(
select dp.codigo_producto from detalle_pedido dp
group by dp.codigo_producto
order by sum(cantidad) desc limit 1);
/*4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar
INNER JOIN).*/
select distinct c.* from cliente c, pago p
where c.limite_credito>p.total
and c.codigo_cliente=p.codigo_cliente;
/*5. Devuelve el producto que más unidades tiene en stock.*/
select * from producto
where cantidad_en_stock=(
select max(cantidad_en_stock) from producto);
/*6. Devuelve el producto que menos unidades tiene en stock.*/
select * from producto
where cantidad_en_stock=(
select min(cantidad_en_stock) from producto);
/*7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto
Soria.*/
select * from empleado
where codigo_jefe=(
select codigo_empleado from empleado
where nombre = 'Alberto'
and apellido1 = 'Soria');
/*Subconsultas con ALL y ANY
1. Devuelve el nombre del cliente con mayor límite de crédito.*/
select * from cliente
where limite_credito = any(
select max(limite_credito) from cliente);
/*2. Devuelve el nombre del producto que tenga el precio de venta más caro.*/
select * from producto
where precio_venta >= any(
select max(precio_venta) from producto);
/*3. Devuelve el producto que menos unidades tiene en stock.*/

/*Subconsultas con IN y NOT IN*/
/*1. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún
cliente.*/
select * from empleado
where codigo_empleado in (
select codigo_empleado from empleado e
left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
where c.codigo_cliente is null);
/*2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
select distinct * from cliente
where codigo_cliente in (
select c.codigo_cliente from cliente c
left join pago p on c.codigo_cliente=p.codigo_cliente
where p.id_transaccion is null);
/*3. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
select distinct * from cliente
where codigo_cliente not in (
select c.codigo_cliente from cliente c
left join pago p on c.codigo_cliente=p.codigo_cliente
where p.id_transaccion is null);
/*4. Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
select distinct * from producto
where codigo_producto not in (
select p.codigo_producto from producto p
left join detalle_pedido pe on p.codigo_producto=pe.codigo_producto
where pe.codigo_pedido is not null);
/*5. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que
no sean representante de ventas de ningún cliente.*/
select * from empleado e2
where codigo_empleado not in (
select codigo_empleado from empleado e
left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
where c.codigo_cliente is not null);

/*Subconsultas con EXISTS y NOT EXISTS*/

/*1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
pago.*/
select * from cliente c
where not exists (
select p.id_transaccion from pago p 
where c.codigo_cliente=p.codigo_cliente);
/*2. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
select * from cliente c
where exists (
select p.id_transaccion from pago p 
where c.codigo_cliente=p.codigo_cliente);
/*3. Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
select * from producto p
where not exists (
select * from detalle_pedido dp 
where p.codigo_producto=dp.codigo_producto);
/*4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.*/
select * from producto p
where exists (
select * from detalle_pedido dp 
where p.codigo_producto=dp.codigo_producto);