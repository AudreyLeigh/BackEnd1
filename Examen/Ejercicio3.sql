drop schema if exists Empresaeducativa;
create schema Empresaeducativa;

create table Empresaeducativa.Cursos(
	Nombre_Curso varchar(15) primary key,
    Descripcion_Curso varchar(70) not null,
    Precio_Curso int not null
);
insert into Empresaeducativa.cursos value(
	'Calculo','Enseñanza de derivadas e integrales',500
);
insert into Empresaeducativa.cursos value(
	'Economia','Enseñanza de micro y macro empresas',450
);
insert into Empresaeducativa.cursos value(
	'Arte','Enseñanza de la historia del arte',150
);


create table Empresaeducativa.Profesores(
	Nombre_Profesor varchar(30) primary key,
    Descripcion_Profesor varchar(70) not null,
    Foto_Profesor blob
);
insert into Empresaeducativa.profesores value(
	'Luisa Guerrero','Profesora con doctorado en Milán',''
);
insert into Empresaeducativa.profesores value(
	'Ricardo Lizana','Catedrático de la Universidad Nacional de Ingenieria',''
);


create table Empresaeducativa.Alumnos(
	DNI char(8) primary key,
    Nombre_Alumno varchar(30) not null,
    Celular char(9) not null,
    Email varchar(45) not null
);
insert into Empresaeducativa.alumnos value(
	'72223806','Audrey Leigh','978375198','audreyleigh01@hotmail.com'
);
insert into Empresaeducativa.alumnos value(
	'75674538','Ana Pardo','954321800','anapardo@gmail.com'
);




create table Empresaeducativa.Profesores_Cursos(
	Nombre_Profesor varchar(30) not null,
    Curso varchar(15) not null,
    foreign key (Nombre_Profesor) references Empresaeducativa.Profesores(Nombre_Profesor) on delete cascade,
    foreign key (Curso) references Empresaeducativa.Cursos(Nombre_Curso) on delete cascade
);
insert into Empresaeducativa.profesores_cursos value(
	'Luisa Guerrero','Calculo'
);
insert into Empresaeducativa.profesores_cursos value(
	'Ricardo Lizana','Calculo'
);
insert into Empresaeducativa.profesores_cursos value(
	'Ricardo Lizana','Economia'
);
insert into Empresaeducativa.profesores_cursos value(
	'Luisa Guerrero','Economia'
);
insert into Empresaeducativa.profesores_cursos value(
	'Luisa Guerrero','Arte'
);




create table Empresaeducativa.Alumnos_Cursos(
	DNI char(8) not null,
    Curso varchar(15) not null,
    foreign key (DNI) references Empresaeducativa.Alumnos(DNI) on delete cascade,
    foreign key (Curso) references Empresaeducativa.Cursos(Nombre_Curso) on delete cascade
);
insert into Empresaeducativa.alumnos_cursos value(
	'72223806','Arte'
);
insert into Empresaeducativa.alumnos_cursos value(
	'72223806','Economia'
);
insert into Empresaeducativa.alumnos_cursos value(
	'72223806','Calculo'
);
insert into Empresaeducativa.alumnos_cursos value(
	'75674538','Economia'
);
insert into Empresaeducativa.alumnos_cursos value(
	'75674538','Calculo'
);


select * from Empresaeducativa.cursos;
select * from Empresaeducativa.profesores;
select * from Empresaeducativa.alumnos;
select * from Empresaeducativa.profesores_cursos;
select * from Empresaeducativa.alumnos_cursos;


-- Pregunta 1
select * from Empresaeducativa.alumnos_cursos where Curso = "Arte";

-- Pregunta 2
select count(Nombre_Profesor) as conteo_profesores, 
Empresaeducativa.profesores_cursos.Curso,
Empresaeducativa.cursos.Descripcion_Curso,
Empresaeducativa.cursos.Precio_Curso
from Empresaeducativa.profesores_cursos
JOIN Empresaeducativa.cursos
on Empresaeducativa.profesores_cursos.Curso = Empresaeducativa.cursos.Nombre_Curso
group by Curso
having conteo_profesores>1;

-- Pregunta 3
select count(Curso) as conteo_cursos,
Empresaeducativa.alumnos_cursos.DNI,
Empresaeducativa.alumnos.Nombre_Alumno,
Empresaeducativa.alumnos.Celular,
Empresaeducativa.alumnos.Email
from Empresaeducativa.alumnos_cursos
JOIN Empresaeducativa.alumnos
on Empresaeducativa.alumnos_cursos.DNI = Empresaeducativa.alumnos.DNI
group by DNI
having conteo_cursos>1;

-- Pregunta 4
select
Empresaeducativa.alumnos_cursos.curso,
Empresaeducativa.alumnos_cursos.DNI,
Empresaeducativa.alumnos.Nombre_Alumno,
Empresaeducativa.alumnos.Celular,
Empresaeducativa.alumnos.Email
from Empresaeducativa.alumnos_cursos
JOIN Empresaeducativa.alumnos
on Empresaeducativa.alumnos_cursos.DNI = Empresaeducativa.alumnos.DNI
where Curso in ('Calculo','Economia');