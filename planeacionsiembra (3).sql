-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-01-2024 a las 19:24:07
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `planeacionsiembra`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `IdInventario` int(11) NOT NULL,
  `Codigo` varchar(11) DEFAULT NULL,
  `FechaCompra` datetime DEFAULT NULL,
  `Medida` enum('LITRO','GALON','NINGUNO','FUNDAS','SACOS') DEFAULT NULL,
  `Producto` varchar(45) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `PrecioUnitario` float DEFAULT NULL,
  `Descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`IdInventario`, `Codigo`, `FechaCompra`, `Medida`, `Producto`, `Cantidad`, `PrecioUnitario`, `Descripcion`) VALUES
(5, 'DSAD01', '2023-11-08 05:00:00', 'LITRO', 'Semilla Cavendish', 3, 300, 'Descirpcion asjdk'),
(10, 'DASDAS', '2023-12-06 05:00:00', 'GALON', 'Semilla prueba', 5, 23, 'Dasdas'),
(11, 'DSAD02', '2023-12-13 05:00:00', 'SACOS', 'Semilla Williams', 2, 60, 'Semilla para fertilizar más rapido'),
(12, 'DSAD05', '2023-12-14 05:00:00', 'FUNDAS', 'Semilla prueba ultima', 25, 30, 'Semilla de prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `IdPermisos` int(11) NOT NULL,
  `NombrePermisos` varchar(45) DEFAULT NULL,
  `Descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`IdPermisos`, `NombrePermisos`, `Descripcion`) VALUES
(1, 'user.create', 'Crear usuario'),
(2, 'user.edit', 'Editar usuario'),
(3, 'user.deactivate', 'Desactivar usuario'),
(4, 'user.delete', 'Eliminar usuario'),
(5, 'user.list', 'Listar usuarios'),
(6, 'user.get', 'Obtener usuario'),
(7, 'permissions.list', 'Listar permisos'),
(8, 'roles.list', 'Listar roles'),
(9, 'roles.assign', 'Asignar roles a usuarios'),
(10, 'roles.get_permissions', 'Listar permisos de rol'),
(11, 'roles.set_permissions', 'Configurar permisos para roles'),
(12, 'reports.create', 'Generar reportes'),
(13, 'reports.list', 'Listar reportes'),
(14, 'reports.get', 'Obtener reporte'),
(15, 'seeding.plan', 'Planificar siembras de banano'),
(16, 'seeding.edit', 'Editar planificación de siembra'),
(17, 'seeding.list', 'Listar planificaciones de siembra'),
(18, 'seeding.get', 'Obtener planificación de siembra'),
(19, 'inventory.register', 'Registrar inventario de productos, equipos e insumos'),
(20, 'inventory.edit', 'Editar inventario'),
(21, 'inventory.list', 'Listar inventario'),
(22, 'inventory.get_product', 'Obtener producto del inventario'),
(23, 'costs.record', 'Llevar registro detallado de costos'),
(24, 'costs.edit', 'Editar registro de costos'),
(25, 'costs.list', 'Listar registros de costos'),
(26, 'costs.get', 'Obtener registro de costos'),
(27, 'profitability.calculate', 'Calcular la rentabilidad a partir de los datos registrados'),
(28, 'profitability.list', 'Listar rentabilidades'),
(29, 'profitability.get', 'Obtener rentabilidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacionsiembra1`
--

CREATE TABLE `planificacionsiembra1` (
  `IdPlanSiembra1` int(11) NOT NULL,
  `CondicionClimatica` varchar(45) DEFAULT NULL,
  `NombreSemillas` varchar(45) DEFAULT NULL,
  `VariedadBanano` varchar(45) DEFAULT NULL,
  `CantidadFertilizanteKG` float DEFAULT NULL,
  `CantidadPesticidasKG` float DEFAULT NULL,
  `FechaFumigacionArea` datetime DEFAULT NULL,
  `Riego` enum('Motores/Bombas','Electrico/Diesel','No disponible') DEFAULT NULL,
  `IdUsuarioOperativo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planificacionsiembra1`
--

INSERT INTO `planificacionsiembra1` (`IdPlanSiembra1`, `CondicionClimatica`, `NombreSemillas`, `VariedadBanano`, `CantidadFertilizanteKG`, `CantidadPesticidasKG`, `FechaFumigacionArea`, `Riego`, `IdUsuarioOperativo`) VALUES
(6, 'Sunny', '200', 'Cavendish', 20, 20, '2023-11-15 05:00:00', 'Motores/Bombas', 2),
(8, 'Sunny', '500', 'Cavendish', 30, 25, '2023-11-19 05:00:00', 'Motores/Bombas', 4),
(9, 'Sunny', '23', 'Cavendish', 34, 443, '2023-11-21 05:00:00', 'Electrico/Diesel', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacionsiembra2`
--

CREATE TABLE `planificacionsiembra2` (
  `IdPlanSiembra2` int(11) NOT NULL,
  `FechaSiembra` datetime DEFAULT NULL,
  `FechaSiembraFin` datetime DEFAULT NULL,
  `TiempoEstimadoSiembra` int(11) DEFAULT NULL,
  `NumeroRacimos` int(11) DEFAULT NULL,
  `NumeroRacimosRechazados` int(11) DEFAULT NULL,
  `PesoPromedioRacimo` float DEFAULT NULL,
  `NumeroLote` int(11) DEFAULT NULL,
  `IdPlanSiembra1` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planificacionsiembra2`
--

INSERT INTO `planificacionsiembra2` (`IdPlanSiembra2`, `FechaSiembra`, `FechaSiembraFin`, `TiempoEstimadoSiembra`, `NumeroRacimos`, `NumeroRacimosRechazados`, `PesoPromedioRacimo`, `NumeroLote`, `IdPlanSiembra1`) VALUES
(6, '2023-11-03 05:00:00', '2023-12-09 05:00:00', 10, 1500, 200, 35, 1, 6),
(8, '2023-11-19 05:00:00', '2023-11-25 05:00:00', 10, 500, 300, 30, 2, 8),
(9, '2023-11-20 05:00:00', '2023-11-29 05:00:00', 10, 1222, 23, 34, 5, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrocostos`
--

CREATE TABLE `registrocostos` (
  `IdCostos` int(11) NOT NULL,
  `FechaRegistro` datetime DEFAULT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Insumo` float DEFAULT NULL,
  `ManoObra` float DEFAULT NULL,
  `Combustible` float DEFAULT NULL,
  `Total` float DEFAULT NULL,
  `IdUsuarioOperativo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `registrocostos`
--

INSERT INTO `registrocostos` (`IdCostos`, `FechaRegistro`, `Descripcion`, `Insumo`, `ManoObra`, `Combustible`, `Total`, `IdUsuarioOperativo`) VALUES
(19, '2023-12-21 15:48:37', 'Alzado de productos', 1015, 30, 25, 1070, 4),
(20, '2023-12-27 06:48:01', 'Descripción de prueba nueva', 1135, 35, 35, 1205, 4),
(23, '2024-01-04 04:43:55', 'Ultima prueba act', 1015, 1, 2, 1018, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rentabilidad`
--

CREATE TABLE `rentabilidad` (
  `IdRentabilidad` int(11) NOT NULL,
  `IdPlanSiembra2` int(11) DEFAULT NULL,
  `IdRegistroCostos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `rentabilidad`
--

INSERT INTO `rentabilidad` (`IdRentabilidad`, `IdPlanSiembra2`, `IdRegistroCostos`) VALUES
(32, 6, 19),
(33, 9, 19),
(34, 8, 19),
(35, 6, 20),
(36, 8, 20),
(38, 9, 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `IdReportes` int(11) NOT NULL,
  `IdUsuarios` int(11) DEFAULT NULL,
  `IdTipoReporte` int(11) DEFAULT NULL,
  `Contenido` varchar(200) DEFAULT NULL,
  `FechaCreacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idRol` int(11) NOT NULL,
  `NombreRol` varchar(45) DEFAULT NULL,
  `codeRol` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idRol`, `NombreRol`, `codeRol`) VALUES
(1, 'Administrador', '001'),
(2, 'Usuario operativo', '002');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rolespermisos`
--

CREATE TABLE `rolespermisos` (
  `IdRolPermiso` int(11) NOT NULL,
  `IdRol` int(11) DEFAULT NULL,
  `IdPermiso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `rolespermisos`
--

INSERT INTO `rolespermisos` (`IdRolPermiso`, `IdRol`, `IdPermiso`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 9),
(6, 1, 7),
(7, 1, 8),
(8, 1, 10),
(9, 1, 11),
(10, 1, 5),
(11, 1, 6),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 1, 17),
(16, 1, 18),
(17, 1, 21),
(18, 1, 22),
(19, 1, 26),
(20, 1, 28),
(21, 1, 29),
(23, 2, 16),
(24, 2, 17),
(25, 2, 18),
(26, 2, 19),
(27, 2, 20),
(28, 2, 21),
(29, 2, 22),
(30, 2, 23),
(31, 2, 24),
(32, 2, 25),
(33, 2, 26),
(34, 2, 12),
(35, 2, 13),
(36, 2, 14),
(37, 1, 15),
(38, 1, 16),
(39, 1, 19),
(40, 1, 20),
(41, 1, 23),
(42, 1, 24),
(43, 1, 25),
(44, 1, 27),
(46, 2, 15),
(47, 2, 27),
(48, 2, 28),
(49, 2, 29);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiporeporte`
--

CREATE TABLE `tiporeporte` (
  `IdTipoReporte` int(11) NOT NULL,
  `NombreReporte` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tiporeporte`
--

INSERT INTO `tiporeporte` (`IdTipoReporte`, `NombreReporte`) VALUES
(1, 'Reporte de Administración'),
(2, 'Reporte de Planificación'),
(3, 'Reporte de Insumos'),
(4, 'Reporte de Costos y Rentabilidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `IdUser` int(11) NOT NULL,
  `NombreUser` varchar(45) DEFAULT NULL,
  `ApellidoUser` varchar(45) DEFAULT NULL,
  `CorreoElectronico` varchar(75) DEFAULT NULL,
  `Contrasena` varchar(255) DEFAULT NULL,
  `Estado` enum('activo','inactivo') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`IdUser`, `NombreUser`, `ApellidoUser`, `CorreoElectronico`, `Contrasena`, `Estado`) VALUES
(1, 'Admin', 'Admin', 'angie19980925@gmail.com', '$2b$10$Vk5K2VQA9V8Rv8i577DhUejB1Xpk3pWp.oMg7fsahMiE94T44MbOa', 'activo'),
(2, 'Mellanie', 'Crespin', 'joelintriago95@gmail.com', '$2b$10$zCE8ftZdeoMyRddQ1Fbc7.pzzxXs6vRfRsL5hzMcZvZ3bEH5i3FMG', 'activo'),
(3, 'User', 'Prueba', 'user@gmail.com', '$2b$10$fOWigD6jb2VktbERRSHQx.4JKEZGvc0X8dLJWO2a0pQthdYJToCNy', 'activo'),
(4, 'Joel', 'Intriago', 'joelintriago99@gmail.com', '$2b$10$ztIi3GuIqRwinqSVzHwBk.1wXxZbXoYqoKBK9cCGgfodixH5doPe.', 'activo'),
(6, 'Joel Prueba', 'Intriago M', 'joelprueba@hotmail.com', '$2b$10$nLYQ1hqdljmijJfuXtB9vu.Wo1jcpGNWha5EcC7TGsUClphyaevV6', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariosroles`
--

CREATE TABLE `usuariosroles` (
  `IdUserRol` int(11) NOT NULL,
  `idUser` int(11) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuariosroles`
--

INSERT INTO `usuariosroles` (`IdUserRol`, `idUser`, `idRol`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 1),
(6, 6, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`IdInventario`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`IdPermisos`);

--
-- Indices de la tabla `planificacionsiembra1`
--
ALTER TABLE `planificacionsiembra1`
  ADD PRIMARY KEY (`IdPlanSiembra1`),
  ADD KEY `IdUsuarioOperativo` (`IdUsuarioOperativo`);

--
-- Indices de la tabla `planificacionsiembra2`
--
ALTER TABLE `planificacionsiembra2`
  ADD PRIMARY KEY (`IdPlanSiembra2`),
  ADD KEY `IdPlanSiembra1` (`IdPlanSiembra1`);

--
-- Indices de la tabla `registrocostos`
--
ALTER TABLE `registrocostos`
  ADD PRIMARY KEY (`IdCostos`),
  ADD KEY `IdUsuarioOperativo` (`IdUsuarioOperativo`);

--
-- Indices de la tabla `rentabilidad`
--
ALTER TABLE `rentabilidad`
  ADD PRIMARY KEY (`IdRentabilidad`),
  ADD KEY `IdPlanSiembra2` (`IdPlanSiembra2`),
  ADD KEY `IdRegistroCostos` (`IdRegistroCostos`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`IdReportes`),
  ADD KEY `IdUsuarios` (`IdUsuarios`),
  ADD KEY `IdTipoReporte` (`IdTipoReporte`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `rolespermisos`
--
ALTER TABLE `rolespermisos`
  ADD PRIMARY KEY (`IdRolPermiso`),
  ADD KEY `IdRol` (`IdRol`),
  ADD KEY `IdPermiso` (`IdPermiso`);

--
-- Indices de la tabla `tiporeporte`
--
ALTER TABLE `tiporeporte`
  ADD PRIMARY KEY (`IdTipoReporte`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`IdUser`);

--
-- Indices de la tabla `usuariosroles`
--
ALTER TABLE `usuariosroles`
  ADD PRIMARY KEY (`IdUserRol`),
  ADD KEY `idUser` (`idUser`),
  ADD KEY `idRol` (`idRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `IdInventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `IdPermisos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `planificacionsiembra1`
--
ALTER TABLE `planificacionsiembra1`
  MODIFY `IdPlanSiembra1` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `planificacionsiembra2`
--
ALTER TABLE `planificacionsiembra2`
  MODIFY `IdPlanSiembra2` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `registrocostos`
--
ALTER TABLE `registrocostos`
  MODIFY `IdCostos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `rentabilidad`
--
ALTER TABLE `rentabilidad`
  MODIFY `IdRentabilidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `IdReportes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rolespermisos`
--
ALTER TABLE `rolespermisos`
  MODIFY `IdRolPermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `tiporeporte`
--
ALTER TABLE `tiporeporte`
  MODIFY `IdTipoReporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `IdUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuariosroles`
--
ALTER TABLE `usuariosroles`
  MODIFY `IdUserRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `planificacionsiembra1`
--
ALTER TABLE `planificacionsiembra1`
  ADD CONSTRAINT `planificacionsiembra1_ibfk_1` FOREIGN KEY (`IdUsuarioOperativo`) REFERENCES `usuarios` (`IdUser`);

--
-- Filtros para la tabla `planificacionsiembra2`
--
ALTER TABLE `planificacionsiembra2`
  ADD CONSTRAINT `planificacionsiembra2_ibfk_1` FOREIGN KEY (`IdPlanSiembra1`) REFERENCES `planificacionsiembra1` (`IdPlanSiembra1`);

--
-- Filtros para la tabla `registrocostos`
--
ALTER TABLE `registrocostos`
  ADD CONSTRAINT `registrocostos_ibfk_2` FOREIGN KEY (`IdUsuarioOperativo`) REFERENCES `usuarios` (`IdUser`);

--
-- Filtros para la tabla `rentabilidad`
--
ALTER TABLE `rentabilidad`
  ADD CONSTRAINT `rentabilidad_ibfk_1` FOREIGN KEY (`IdPlanSiembra2`) REFERENCES `planificacionsiembra2` (`IdPlanSiembra2`),
  ADD CONSTRAINT `rentabilidad_ibfk_2` FOREIGN KEY (`IdRegistroCostos`) REFERENCES `registrocostos` (`IdCostos`);

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`IdUsuarios`) REFERENCES `usuarios` (`IdUser`),
  ADD CONSTRAINT `reportes_ibfk_2` FOREIGN KEY (`IdTipoReporte`) REFERENCES `tiporeporte` (`IdTipoReporte`);

--
-- Filtros para la tabla `rolespermisos`
--
ALTER TABLE `rolespermisos`
  ADD CONSTRAINT `rolespermisos_ibfk_1` FOREIGN KEY (`IdRol`) REFERENCES `roles` (`idRol`),
  ADD CONSTRAINT `rolespermisos_ibfk_2` FOREIGN KEY (`IdPermiso`) REFERENCES `permisos` (`IdPermisos`);

--
-- Filtros para la tabla `usuariosroles`
--
ALTER TABLE `usuariosroles`
  ADD CONSTRAINT `usuariosroles_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `usuarios` (`IdUser`),
  ADD CONSTRAINT `usuariosroles_ibfk_2` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
