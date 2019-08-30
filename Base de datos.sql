SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sportgift_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `acciones`
--

DROP TABLE IF EXISTS `acciones`;
CREATE TABLE IF NOT EXISTS `acciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `deporte_id` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_acciones_deporte_id` (`deporte_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda acciones deportivas, correr, nadar, saltar, caminar, trotar, escalar, etc';

-- --------------------------------------------------------

--
-- Table structure for table `ciudad`
--

DROP TABLE IF EXISTS `ciudad`;
CREATE TABLE IF NOT EXISTS `ciudad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `pais_id` int(11) NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pais_id` (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda las ciudades de los paises';

-- --------------------------------------------------------

--
-- Table structure for table `deportes`
--

DROP TABLE IF EXISTS `deportes`;
CREATE TABLE IF NOT EXISTS `deportes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `icono` varchar(150) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda los deportes';

-- --------------------------------------------------------

--
-- Table structure for table `empresas_patrocinadoras`
--

DROP TABLE IF EXISTS `empresas_patrocinadoras`;
CREATE TABLE IF NOT EXISTS `empresas_patrocinadoras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `rif_ruc` varchar(100) NOT NULL,
  `logo` varchar(150) NOT NULL,
  `direccion_sede` text CHARACTER SET latin1,
  `telefonos` text CHARACTER SET latin1,
  `ubicacion_longitud` double DEFAULT NULL,
  `ubicacion_latitud` double DEFAULT NULL,
  `emails` text CHARACTER SET latin1,
  `web` text CHARACTER SET latin1,
  `facebook` text CHARACTER SET latin1,
  `instagram` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda la informacion de las empresas creadoras de los retos';

-- --------------------------------------------------------

--
-- Table structure for table `fotos`
--

DROP TABLE IF EXISTS `fotos`;
CREATE TABLE IF NOT EXISTS `fotos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reto_id` int(11) NOT NULL,
  `participante_id` int(11) NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reto_fotos_idx` (`reto_id`),
  KEY `fk_participante_fotos_idx` (`participante_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda las fotos de los participantes en los retos';

-- --------------------------------------------------------

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
CREATE TABLE IF NOT EXISTS `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `codigo` varchar(8) NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda los paises';

-- --------------------------------------------------------

--
-- Table structure for table `participante`
--

DROP TABLE IF EXISTS `participante`;
CREATE TABLE IF NOT EXISTS `participante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `usuario` varchar(8) NOT NULL,
  `password` varchar(8) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `peso` float NOT NULL,
  `altura` float NOT NULL,
  `genero` char(1) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `pais_id` int(11) NOT NULL,
  `ciudad_id` int(11) DEFAULT NULL,
  `direccion` text,
  `facebook` varchar(200) DEFAULT NULL,
  `instagram` varchar(200) DEFAULT NULL,
  `twitter` varchar(200) DEFAULT NULL,
  `snapchat` varchar(200) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ciudad_participante_idx` (`ciudad_id`),
  KEY `fk_pais_participante_idx` (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda los participantes de los retos';

-- --------------------------------------------------------

--
-- Table structure for table `premios_participante`
--

DROP TABLE IF EXISTS `premios_participante`;
CREATE TABLE IF NOT EXISTS `premios_participante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `premios_promociones_id` int(11) NOT NULL,
  `participante_id` int(11) NOT NULL,
  `reto_participante_id` int(11) NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_premios_promociones_premios_participante_idx` (`premios_promociones_id`),
  KEY `fk_participante_premios_particpante_idx` (`participante_id`),
  KEY `fk_reto_participante_premios_participante_idx` (`reto_participante_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda los premios de los participantes en los retos';

-- --------------------------------------------------------

--
-- Table structure for table `premios_promociones`
--

DROP TABLE IF EXISTS `premios_promociones`;
CREATE TABLE IF NOT EXISTS `premios_promociones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `descripcion` text NOT NULL,
  `tipo_premio` char(1) NOT NULL,
  `foto` varchar(150) NOT NULL,
  `fecha_maxima_canje` date NOT NULL,
  `empresa_patrocinadora_id` int(11) NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_empresa_patrocinadora_premios_promociones_idx` (`empresa_patrocinadora_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda los premios y promociones de los retos';

-- --------------------------------------------------------

--
-- Table structure for table `publicidad`
--

DROP TABLE IF EXISTS `publicidad`;
CREATE TABLE IF NOT EXISTS `publicidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_patrocinadora_id` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_creacion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `tarifa` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_empresa_patrocinadora_publicidad_idx` (`empresa_patrocinadora_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda la publicidad de las empresas patrocinadoras';

-- --------------------------------------------------------

--
-- Table structure for table `reto`
--

DROP TABLE IF EXISTS `reto`;
CREATE TABLE IF NOT EXISTS `reto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(180) NOT NULL,
  `fecha_inicio` timestamp NOT NULL,
  `fecha_fin` timestamp NOT NULL,
  `participantes_maximos` int(11) NOT NULL,
  `deporte_id` int(11) NOT NULL,
  `empresa_patrocinadora_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_deporte_reto_idx` (`deporte_id`),
  KEY `fk_empresa_patrocinadora_reto_idx` (`empresa_patrocinadora_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda el encabezado de los retos';

-- --------------------------------------------------------

--
-- Table structure for table `retos_acciones`
--

DROP TABLE IF EXISTS `retos_acciones`;
CREATE TABLE IF NOT EXISTS `retos_acciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accion_id` int(20) NOT NULL,
  `simbolo` varchar(5) NOT NULL,
  `valor` float NOT NULL,
  `tipo_medida_id` int(11) NOT NULL COMMENT 'distancia/tiempo/calorias/ritmo cardiaco',
  `simbolo_rango` varchar(15) NOT NULL,
  `valor_rango_1` float NOT NULL,
  `tipo_medida_rango_1_id` int(11) NOT NULL,
  `valor_rango_2` float NOT NULL,
  `tipo_medida_rango_2_id` int(11) NOT NULL,
  `ruta_id` int(11) NOT NULL COMMENT 'Hay retos que pueden tener una ruta definida en el mapa',
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_accion_reto_acciones_idx` (`accion_id`),
  KEY `fk_tipo_medida_reto_acciones_idx` (`tipo_medida_id`),
  KEY `fk_tipo_medida_r2_reto_acciones_idx` (`tipo_medida_rango_2_id`),
  KEY `fk_ruta_reto_acciones_idx` (`ruta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda la configuracion y condiciones de los retos';

-- --------------------------------------------------------

--
-- Table structure for table `retos_participantes`
--

DROP TABLE IF EXISTS `retos_participantes`;
CREATE TABLE IF NOT EXISTS `retos_participantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reto_id` int(11) NOT NULL,
  `participante_id` int(11) NOT NULL,
  `fecha_participacion` int(11) NOT NULL,
  `status_final` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reto_retos_participantes_idx` (`reto_id`),
  KEY `fk_participante_retos_participantes_idx` (`participante_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda los participantes de los retos';

-- --------------------------------------------------------

--
-- Table structure for table `ruta`
--

DROP TABLE IF EXISTS `ruta`;
CREATE TABLE IF NOT EXISTS `ruta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `pais_id` int(11) NOT NULL,
  `ciudad_id` int(11) NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pais_ruta_idx` (`pais_id`),
  KEY `fk_ciudad_ruta_idx` (`ciudad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda el encabezado de la ruta definida de algun reto';

-- --------------------------------------------------------

--
-- Table structure for table `ruta_coordenadas`
--

DROP TABLE IF EXISTS `ruta_coordenadas`;
CREATE TABLE IF NOT EXISTS `ruta_coordenadas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruta_id` int(11) NOT NULL,
  `latitud` double NOT NULL,
  `longitud` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ruta_ruta_coordenadas_idx` (`ruta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda las coordenadas de la ruta definida';

-- --------------------------------------------------------

--
-- Table structure for table `tipo_medida`
--

DROP TABLE IF EXISTS `tipo_medida`;
CREATE TABLE IF NOT EXISTS `tipo_medida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` int(11) NOT NULL,
  `estado` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda los tipos de medida Km, metros, pulgadas, segundos, minutos, libras, kilos, ';

-- --------------------------------------------------------

--
-- Table structure for table `wallet`
--

DROP TABLE IF EXISTS `wallet`;
CREATE TABLE IF NOT EXISTS `wallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  `tokens_ganados` int(11) NOT NULL,
  `participante_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_participante_id_idx` (`participante_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena los tokens sportg ganados por los participantes por competir en los retos';

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acciones`
--
ALTER TABLE `acciones`
  ADD CONSTRAINT `fk_acciones_deporte` FOREIGN KEY (`deporte_id`) REFERENCES `deportes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ciudad`
--
ALTER TABLE `ciudad`
  ADD CONSTRAINT `fk_pais_ciudad` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `fotos`
--
ALTER TABLE `fotos`
  ADD CONSTRAINT `fk_participante_fotos` FOREIGN KEY (`participante_id`) REFERENCES `participante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_reto_fotos` FOREIGN KEY (`reto_id`) REFERENCES `reto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `participante`
--
ALTER TABLE `participante`
  ADD CONSTRAINT `fk_ciudad_participante` FOREIGN KEY (`ciudad_id`) REFERENCES `ciudad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pais_participante` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `premios_participante`
--
ALTER TABLE `premios_participante`
  ADD CONSTRAINT `fk_participante_premios_particpante` FOREIGN KEY (`participante_id`) REFERENCES `participante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_premios_promociones_premios_participante` FOREIGN KEY (`premios_promociones_id`) REFERENCES `premios_promociones` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_reto_participante_premios_participante` FOREIGN KEY (`reto_participante_id`) REFERENCES `retos_participantes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `premios_promociones`
--
ALTER TABLE `premios_promociones`
  ADD CONSTRAINT `fk_empresa_patrocinadora_premios_promociones` FOREIGN KEY (`empresa_patrocinadora_id`) REFERENCES `empresas_patrocinadoras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `publicidad`
--
ALTER TABLE `publicidad`
  ADD CONSTRAINT `fk_empresa_patrocinadora_publicidad` FOREIGN KEY (`empresa_patrocinadora_id`) REFERENCES `empresas_patrocinadoras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `reto`
--
ALTER TABLE `reto`
  ADD CONSTRAINT `fk_deporte_reto` FOREIGN KEY (`deporte_id`) REFERENCES `deportes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_empresa_patrocinadora_reto` FOREIGN KEY (`empresa_patrocinadora_id`) REFERENCES `empresas_patrocinadoras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `retos_acciones`
--
ALTER TABLE `retos_acciones`
  ADD CONSTRAINT `fk_accion_reto_acciones` FOREIGN KEY (`accion_id`) REFERENCES `acciones` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ruta_reto_acciones` FOREIGN KEY (`ruta_id`) REFERENCES `ruta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tipo_medida_r1_reto_acciones` FOREIGN KEY (`tipo_medida_id`) REFERENCES `tipo_medida` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tipo_medida_r2_reto_acciones` FOREIGN KEY (`tipo_medida_rango_2_id`) REFERENCES `tipo_medida` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tipo_medida_reto_acciones` FOREIGN KEY (`tipo_medida_id`) REFERENCES `tipo_medida` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `retos_participantes`
--
ALTER TABLE `retos_participantes`
  ADD CONSTRAINT `fk_participante_retos_participantes` FOREIGN KEY (`participante_id`) REFERENCES `participante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_reto_retos_participantes` FOREIGN KEY (`reto_id`) REFERENCES `reto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ruta`
--
ALTER TABLE `ruta`
  ADD CONSTRAINT `fk_ciudad_ruta` FOREIGN KEY (`ciudad_id`) REFERENCES `ciudad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pais_ruta` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ruta_coordenadas`
--
ALTER TABLE `ruta_coordenadas`
  ADD CONSTRAINT `fk_ruta_ruta_coordenadas` FOREIGN KEY (`ruta_id`) REFERENCES `ruta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `wallet`
--
ALTER TABLE `wallet`
  ADD CONSTRAINT `fk_participante_wallet` FOREIGN KEY (`participante_id`) REFERENCES `participante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
