use nba;
select * from jugadores;
/*1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.*/
select nombre from jugadores
order by nombre asc;
/*2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente.*/
select nombre from jugadores
where posicion = 'c'
and peso > 200;
/*3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.*/
select nombre from equipos
order by nombre asc;
/*4. Mostrar el nombre de los equipos del este (East).*/
select nombre from equipos
where conferencia = 'east';
/*5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.*/
select * from equipos
where ciudad like 'c%'
order by nombre;
/*6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.*/
select * from jugadores j
inner join equipos e on j.nombre_equipo = e.nombre
order by e.nombre;
/*7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.*/
select * from jugadores j
inner join equipos e on j.nombre_equipo = e.nombre
where e.nombre = 'raptors'
order by e.nombre;
/*8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.*/
select j.nombre, e.puntos_por_partido from jugadores j
inner join estadisticas e on j.codigo = e.jugador
where j.nombre = 'Pau Gasol';
/*9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.*/
select j.nombre, e.puntos_por_partido, temporada from jugadores j
inner join estadisticas e on j.codigo = e.jugador
where j.nombre = 'Pau Gasol'
and temporada = '04/05';
/*10. Mostrar el número de puntos de cada jugador en toda su carrera.*/
select j.nombre, e.puntos_por_partido, temporada from jugadores j
inner join estadisticas e on j.codigo = e.jugador
order by j.nombre, temporada;
/*11. Mostrar el número de jugadores de cada equipo.*/
select count(e.nombre), e.nombre from jugadores j
inner join equipos e on e.nombre = j.nombre_equipo
group by e.nombre;
/*12. Mostrar el jugador que más puntos ha realizado en toda su carrera.*/
select j.nombre, round(sum(e.puntos_por_partido)) as puntos_carrera from jugadores j
inner join estadisticas e on j.codigo = e.jugador
group by e.jugador
order by puntos_carrera desc;
/*13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.*/
select e.nombre, e.conferencia, e.division, j.nombre from jugadores j
inner join equipos e on j.nombre_equipo = e.nombre
order by j.altura desc 
limit 1;
/*14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
select avg(es.puntos_por_partido) as 'media_puntos', e.nombre, e.division from jugadores j
inner join equipos e on e.nombre = j.nombre_equipo
inner join estadisticas es on es.jugador = j.codigo
group by e.nombre
having e.division = 'pacific'
order by media_puntos desc;
/*15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos.*/
select abs(puntos_local-puntos_visitante) as dife, equipo_local, equipo_visitante, temporada from partidos
having dife = 
(select abs(puntos_local-puntos_visitante) as dif from partidos
order by dif desc limit 1);
/*16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
select avg(es.puntos_por_partido) as 'media_puntos', e.nombre, e.division from jugadores j
inner join equipos e on e.nombre = j.nombre_equipo
inner join estadisticas es on es.jugador = j.codigo
group by e.nombre
having e.division = 'pacific'
order by media_puntos desc;
/*17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.*/
select e.nombre, 
sum(if(e.nombre=p.equipo_local,puntos_local,puntos_visitante)) as puntos_totales,
p.temporada
from partidos p
inner join equipos e on e.nombre = p.equipo_local or e.nombre = p.equipo_visitante
group by p.temporada, e.nombre
order by puntos_totales desc;

/*OTRA FORMA DE HACERLO

SELECT temporada, equipo, SUM(puntos_totales) AS puntos_totales
FROM (
    SELECT temporada, equipo_local AS equipo, SUM(puntos_local) AS puntos_totales
    FROM partidos
    GROUP BY temporada, equipo_local
    UNION ALL
    SELECT temporada, equipo_visitante AS equipo, SUM(puntos_visitante) AS puntos_totales
    FROM partidos
    GROUP BY temporada, equipo_visitante
) AS subquery
GROUP BY temporada, equipo
order by puntos_totales desc;
*/

/*18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null.*/
select 
equipo_local, equipo_visitante, puntos_local, puntos_visitante,
if(puntos_local!=puntos_visitante,
if(puntos_local>puntos_visitante, equipo_local, equipo_visitante),
null) as ganador
from partidos p;
