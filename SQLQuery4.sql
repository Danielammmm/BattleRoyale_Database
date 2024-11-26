--DDL PROYECTO
--CREACI�N DE ESTRUCTURA

use BattleRoyale

--Cat�logos
create table Continente(
	idContinente int identity(1,1) primary key,
	nombre varchar(50) not null,
)

create table Pais(
	idPais int identity(1,1) primary key,
	nombre varchar(50) not null,
	idContinente int foreign key references Continente(idContinente) not null
)


-- ======================== DDL para la definici�n de tablas de cosm�ticos ========================
-- categor�a de cosm�ticos: comunes, raros, legendarios...
create table CategoriaCosmetico(
	idCategoriaCosmetico int identity(1,1) primary key,
	nombre varchar(50) not null
)

-- tipo de cosm�tico: skin de arma, skin de personaje etc...
create table TipoCosmetico(
	idTipoCosmetico int identity(1,1) primary key,
	nombre varchar(50) not null
)

-- listado de cosm�ticos: incluye su tipo de cosmetico, su categor�a , nombre y precio
create table Cosmetico(
	idCosmetico int identity(1,1) primary key,
	nombre varchar(50) not null,
	precio decimal not null,
	idCategoriaCosmetico int foreign key references CategoriaCosmetico(idCategoriaCosmetico) not null,
	idTipoCosmetico int foreign key references TipoCosmetico(idTipoCosmetico) not null,
	constraint chk_precio check  (precio >= 0)
)

create table TipoPartida(
	idTipoPartida int identity(1,1) primary key,
	nombre varchar(50) not null,
)


-- DDL para la definici�n de usuarios y conexiones desde una plataforma
create table Plataforma(
	idPlataforma int identity(1,1) primary key,
	nombre varchar(50) not null
)

create table Usuario(
	idUsuario int identity(1,1) primary key,
	nickname varchar(50) unique, -- puede cambiarse cada tres meses 
	nombre1 varchar(50) not null,
	nombre2 varchar(50),
	nombre3 varchar(50),
	apellido1 varchar(50) not null,
	apellido2 varchar(50) not null,
	email varchar(100) not null,
	contrasena varchar(20) not null, 
	fechaNacimiento date not null,
	fechaModificacion date not null, 
	estado bit not null,
	idPais int foreign key references Pais(idPais) not null,
	constraint CK_Usuario_contrasena check(len(contrasena) >= 8),
	constraint CK_Usuario_Edad check(DATEDIFF(YEAR, fechaNacimiento, getdate()) > 12),
	constraint CK_Usuario_Estado check(estado between 0 and 1)
)

-- conexi�n: Guarda el registro de cada una de las conexiones realizadas por los usuarios
create table Conexion(
	idConexion int identity(1,1) primary key,
	fechaLogin datetime not null,
	fechaLogoff datetime not null,
	idUsuario int foreign key references Usuario(idUsuario) not null,
	idPlataforma int foreign key references Plataforma(idPlataforma) not null,
)

-- Guarda un registro de todos los cosm�ticos comprados por alg�n usuario
create table UsuarioCosmetico(
	idUsuarioCosmetico int identity(1,1) primary key,
	idUsuario int foreign key references Usuario(idUsuario) not null,
	idCosmetico int foreign key references Cosmetico(idCosmetico) not null,	
)

create table Partida (
	idPartida int identity(1,1) primary key,
	fechaInicio datetime not null,
	fechaFin datetime not null,
	estado bit not null,
	idGanador int foreign key references Usuario(idUsuario) not null,
	idTipoPartida int foreign key references TipoPartida(idTipoPartida) not null
)

-- tabla que indica los cosm�ticos utilizados durante las partidas de cada usuario
create table DetalleCosmeticoPartida (
	idDetCosmeticoPartida int identity(1,1) primary key,
	idPartida int foreign key references Partida(idPartida) not null,
	idUsuario int foreign key references Usuario(idUsuario) not null,
	idUsuarioCosmetico int foreign key references UsuarioCosmetico(idUsuarioCosmetico) not null,
)

create table DetallePartida (
	idDetallePartida int identity(1,1) primary key,
	idPartida int foreign key references Partida(idPartida) not null,
	idAsesino int foreign key references Usuario(idUsuario),
	idMuerto int foreign key references Usuario(idUsuario) not null,
	fechaAsesinato datetime not null
)

