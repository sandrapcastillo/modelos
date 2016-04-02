-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-04-2016 a las 19:39:29
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `aseguradora`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int(11) NOT NULL,
  `identificacion` varchar(40) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `direccion` varchar(300) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `correo` varchar(400) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `id_tipoidentificacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poliza`
--

CREATE TABLE IF NOT EXISTS `poliza` (
  `id_poliza` int(11) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `deducible` float DEFAULT NULL,
  `valor_asegurado` float DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `fecha_adquisicion` timestamp NULL DEFAULT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sinietro`
--

CREATE TABLE IF NOT EXISTS `sinietro` (
  `id_siniestro` int(11) NOT NULL,
  `fecha_hora` timestamp NULL DEFAULT NULL,
  `direccion` varchar(200) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `id_poliza` int(11) NOT NULL,
  `consecutivo` int(11) DEFAULT NULL,
  `latitud` float DEFAULT NULL,
  `longitud` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_identificacion`
--

CREATE TABLE IF NOT EXISTS `tipo_identificacion` (
  `id_tipoidentificacion` int(11) NOT NULL,
  `descripcion` varchar(60) COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE IF NOT EXISTS `vehiculo` (
  `id_vehiculo` int(11) NOT NULL,
  `placa` varchar(15) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `modelo_fecha` int(11) DEFAULT NULL,
  `cilindraje` int(11) DEFAULT NULL,
  `id_tipovehiculo` int(11) NOT NULL,
  `id_color` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo_color`
--

CREATE TABLE IF NOT EXISTS `vehiculo_color` (
  `id_color` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo_tipo`
--

CREATE TABLE IF NOT EXISTS `vehiculo_tipo` (
  `id_tipovehiculo` int(11) NOT NULL,
  `descripcion` varchar(60) COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
 ADD PRIMARY KEY (`id_cliente`), ADD KEY `R_2` (`id_tipoidentificacion`);

--
-- Indices de la tabla `poliza`
--
ALTER TABLE `poliza`
 ADD PRIMARY KEY (`id_poliza`), ADD KEY `R_3` (`id_cliente`), ADD KEY `R_8` (`id_vehiculo`);

--
-- Indices de la tabla `sinietro`
--
ALTER TABLE `sinietro`
 ADD PRIMARY KEY (`id_siniestro`), ADD KEY `R_5` (`id_poliza`);

--
-- Indices de la tabla `tipo_identificacion`
--
ALTER TABLE `tipo_identificacion`
 ADD PRIMARY KEY (`id_tipoidentificacion`);

--
-- Indices de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
 ADD PRIMARY KEY (`id_vehiculo`), ADD KEY `R_4` (`id_tipovehiculo`), ADD KEY `R_6` (`id_color`);

--
-- Indices de la tabla `vehiculo_color`
--
ALTER TABLE `vehiculo_color`
 ADD PRIMARY KEY (`id_color`);

--
-- Indices de la tabla `vehiculo_tipo`
--
ALTER TABLE `vehiculo_tipo`
 ADD PRIMARY KEY (`id_tipovehiculo`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
ADD CONSTRAINT `R_2` FOREIGN KEY (`id_tipoidentificacion`) REFERENCES `tipo_identificacion` (`id_tipoidentificacion`);

--
-- Filtros para la tabla `poliza`
--
ALTER TABLE `poliza`
ADD CONSTRAINT `R_3` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
ADD CONSTRAINT `R_8` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`);

--
-- Filtros para la tabla `sinietro`
--
ALTER TABLE `sinietro`
ADD CONSTRAINT `R_5` FOREIGN KEY (`id_poliza`) REFERENCES `poliza` (`id_poliza`);

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
ADD CONSTRAINT `R_4` FOREIGN KEY (`id_tipovehiculo`) REFERENCES `vehiculo_tipo` (`id_tipovehiculo`),
ADD CONSTRAINT `R_6` FOREIGN KEY (`id_color`) REFERENCES `vehiculo_color` (`id_color`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
