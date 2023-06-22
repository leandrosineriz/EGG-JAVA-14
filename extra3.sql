/*1. Mostrar el nombre de todos los pokemon.*/
select * from pokemon;
/*2. Mostrar los pokemon que pesen menos de 10k.*/
select * from pokemon
where peso<10;
/*3. Mostrar los pokemon de tipo agua.*/
select p.*, t.nombre from pokemon p
inner join pokemon_tipo pt on p.numero_pokedex=pt.numero_pokedex
inner join tipo t on pt.id_tipo=t.id_tipo;
/*4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo.*/
select p.*, t.nombre from pokemon p
inner join pokemon_tipo pt on p.numero_pokedex=pt.numero_pokedex
inner join tipo t on pt.id_tipo=t.id_tipo
where t.nombre in ('agua', 'tierra', 'fuego')
order by t.nombre;
/*5. Mostrar los pokemon que son de tipo fuego y volador.*/
select p.*, t.nombre from pokemon p
inner join pokemon_tipo pt on p.numero_pokedex=pt.numero_pokedex
inner join tipo t on pt.id_tipo=t.id_tipo
where t.nombre in ('volador', 'fuego')
order by t.nombre;
/*6. Mostrar los pokemon con una estadística base de ps mayor que 200.*/
select * from pokemon p
inner join estadisticas_base eb on p.numero_pokedex=eb.numero_pokedex
where eb.ps>200;

/*Falta un pokemon en estadistica base, asi lo encontre*/
select * from pokemon p
where not exists (
select * from estadisticas_base eb where p.numero_pokedex=eb.numero_pokedex);

/*7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok.*/
select * from pokemon p
where p.numero_pokedex=(
select ed.pokemon_origen from evoluciona_de ed
inner join pokemon p1 on ed.pokemon_evolucionado=p1.numero_pokedex
where p1.nombre='Arbok');

/*8. Mostrar aquellos pokemon que evolucionan por intercambio.*/
select * from pokemon p
where p.numero_pokedex in (
select pfe.numero_pokedex from pokemon_forma_evolucion pfe 
inner join forma_evolucion fe on pfe.id_forma_evolucion=fe.id_forma_evolucion
inner join tipo_evolucion te on fe.tipo_evolucion=te.id_tipo_evolucion
where te.tipo_evolucion='intercambio');

/*9. Mostrar el nombre del movimiento con más prioridad.*/
select * from movimiento
where prioridad=(
select min(prioridad) from movimiento);
/*10. Mostrar el pokemon más pesado.*/
select * from pokemon
where peso=(
select max(peso) from pokemon);
/*11. Mostrar el nombre y tipo del ataque con más potencia.
12. Mostrar el número de movimientos de cada tipo.
13. Mostrar todos los movimientos que puedan envenenar.
14. Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre.
15. Mostrar todos los movimientos que aprende pikachu.
16. Mostrar todos los movimientos que aprende pikachu por MT (tipo de aprendizaje).
17. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel.
18. Mostrar todos los movimientos de efecto secundario cuya probabilidad sea mayor al 30%.
19. Mostrar todos los pokemon que evolucionan por piedra.
20. Mostrar todos los pokemon que no pueden evolucionar.
21. Mostrar la cantidad de los pokemon de cada tipo.*/