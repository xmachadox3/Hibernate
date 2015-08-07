-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 07-08-2015 a las 16:04:19
-- Versión del servidor: 5.5.43-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `BDOO`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `casaplaya`
--

CREATE TABLE IF NOT EXISTS `casaplaya` (
  `codigo` char(10) NOT NULL DEFAULT '',
  `poblacion` char(100) DEFAULT NULL,
  `nhabitaciones` int(11) DEFAULT NULL,
  `nbanos` int(11) DEFAULT NULL,
  `ncocinas` int(11) DEFAULT NULL,
  `ncomedores` int(11) DEFAULT NULL,
  `nestacionamientos` int(11) DEFAULT NULL,
  `estadoactual` tinyint(1) DEFAULT NULL,
  `idpropietario` char(10) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idpropietario` (`idpropietario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `casaplaya`
--

INSERT INTO `casaplaya` (`codigo`, `poblacion`, `nhabitaciones`, `nbanos`, `ncocinas`, `ncomedores`, `nestacionamientos`, `estadoactual`, `idpropietario`) VALUES
('123', 'San Francisco, Casco Historico', 2, 2, 3, 4, 4, 1, '24877491'),
('124', 'Cumana Coa', 3, 3, 2, 1, 2, 1, '24877491');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `ndeposito` char(15) DEFAULT NULL,
  `idpaquete` char(10) DEFAULT NULL,
  `idpersona` char(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`idpersona`),
  KEY `idpaquete` (`idpaquete`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`ndeposito`, `idpaquete`, `idpersona`) VALUES
(NULL, '123p', '22717696');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE IF NOT EXISTS `pago` (
  `codigo` char(10) NOT NULL DEFAULT '',
  `idcliente` char(10) DEFAULT NULL,
  `idpaquete` char(10) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idcliente` (`idcliente`),
  KEY `idpaquete` (`idpaquete`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquete`
--

CREATE TABLE IF NOT EXISTS `paquete` (
  `codigo` char(10) NOT NULL DEFAULT '',
  `fechainicio` date NOT NULL,
  `fechafinal` date NOT NULL,
  `precio` float DEFAULT NULL,
  `estados` int(11) DEFAULT NULL,
  `idcasaplaya` char(10) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idcasaplaya` (`idcasaplaya`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `paquete`
--

INSERT INTO `paquete` (`codigo`, `fechainicio`, `fechafinal`, `precio`, `estados`, `idcasaplaya`) VALUES
('123p', '2015-11-23', '2015-11-26', 1200, 2, '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `cedula` char(10) NOT NULL DEFAULT '',
  `nombre` char(50) DEFAULT NULL,
  `apellido` char(50) DEFAULT NULL,
  `telefono` char(15) DEFAULT NULL,
  `clave` char(25) DEFAULT NULL,
  `login` char(25) DEFAULT NULL,
  PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`cedula`, `nombre`, `apellido`, `telefono`, `clave`, `login`) VALUES
('22717696', 'Jeniree', 'Ramirez', NULL, '231193j', 'jeny'),
('24877491', 'Jesus', 'Machado', '04128630833', '231193j', 'xmachadox');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propietario`
--

CREATE TABLE IF NOT EXISTS `propietario` (
  `ncuenta` char(50) DEFAULT NULL,
  `idpersona` char(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `propietario`
--

INSERT INTO `propietario` (`ncuenta`, `idpersona`) VALUES
('1954926-1', '24877491');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE IF NOT EXISTS `reserva` (
  `codigo` char(10) NOT NULL DEFAULT '',
  `idcliente` char(10) DEFAULT NULL,
  `idpaquete` char(10) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idcliente` (`idcliente`),
  KEY `idpaquete` (`idpaquete`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO `reserva` (`codigo`, `idcliente`, `idpaquete`) VALUES
('123p', '22717696', '123p');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `casaplaya`
--
ALTER TABLE `casaplaya`
  ADD CONSTRAINT `casaplaya_ibfk_1` FOREIGN KEY (`idpropietario`) REFERENCES `propietario` (`idpersona`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`cedula`),
  ADD CONSTRAINT `cliente_ibfk_2` FOREIGN KEY (`idpaquete`) REFERENCES `paquete` (`codigo`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idpersona`),
  ADD CONSTRAINT `pago_ibfk_2` FOREIGN KEY (`idpaquete`) REFERENCES `paquete` (`codigo`);

--
-- Filtros para la tabla `paquete`
--
ALTER TABLE `paquete`
  ADD CONSTRAINT `paquete_ibfk_1` FOREIGN KEY (`idcasaplaya`) REFERENCES `casaplaya` (`codigo`);

--
-- Filtros para la tabla `propietario`
--
ALTER TABLE `propietario`
  ADD CONSTRAINT `propietario_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`cedula`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idpersona`),
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`idpaquete`) REFERENCES `paquete` (`codigo`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
