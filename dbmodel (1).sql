-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-11-2025 a las 16:19:14
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbmodel`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genres`
--

CREATE TABLE `genres` (
  `id` bigint(20) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genres`
--

INSERT INTO `genres` (`id`, `name`) VALUES
(1, 'Acción'),
(2, 'Plataformas'),
(3, 'FPS'),
(4, 'Estratégia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `library`
--

CREATE TABLE `library` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unique_game_id` bigint(20) NOT NULL,
  `owner` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `library`
--

INSERT INTO `library` (`id`, `unique_game_id`, `owner`, `created_at`, `updated_at`) VALUES
(8, 5, 2, '2025-11-20 03:27:39', '2025-11-19 17:49:34'),
(9, 6, 2, '2025-11-20 03:27:39', '2025-11-19 17:49:34'),
(16, 13, 2, '2025-11-21 14:42:08', '2025-11-21 14:42:08'),
(17, 14, 3, '2025-11-21 14:46:19', '2025-11-21 14:46:19'),
(18, 15, 2, '2025-11-21 14:56:38', '2025-11-21 14:56:38'),
(19, 16, 2, '2025-11-21 14:57:45', '2025-11-21 14:57:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `offers`
--

CREATE TABLE `offers` (
  `idOferta` int(11) NOT NULL,
  `videogameId` int(11) NOT NULL,
  `nombreJuego` varchar(255) NOT NULL,
  `discount` decimal(5,2) NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `precioOriginal` decimal(8,2) DEFAULT NULL,
  `imagenUrl` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `offers`
--

INSERT INTO `offers` (`idOferta`, `videogameId`, `nombreJuego`, `discount`, `startDate`, `endDate`, `precioOriginal`, `imagenUrl`, `created_at`, `updated_at`) VALUES
(1, 1, 'Overcooked 2', 4.00, '2024-11-08 00:00:00', '2024-11-30 23:59:59', 10000.00, 'overcooked2.jpg', '2025-11-08 19:50:54', '2025-11-08 19:50:54'),
(2, 2, 'Red Dead Redemption 2', 4.00, '2024-11-08 01:30:00', '2024-11-30 23:59:59', 10000.00, 'reddead.jpg', '2025-11-08 21:12:31', '2025-11-08 21:12:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(0, 'Usuario'),
(1, 'Editor'),
(2, 'Admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) NOT NULL,
  `buyer` bigint(20) NOT NULL,
  `totalprice` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sales`
--

INSERT INTO `sales` (`id`, `buyer`, `totalprice`, `created_at`, `updated_at`) VALUES
(1, 1, 50000, '2025-11-19 17:34:48', NULL),
(5, 2, 53990, '2025-11-20 20:33:45', '2025-11-20 20:33:45'),
(6, 2, 62990, '2025-11-20 20:36:42', '2025-11-20 20:36:42'),
(7, 2, 10000, '2025-11-20 20:39:43', '2025-11-20 20:39:43'),
(8, 2, 40, '2025-11-20 22:03:01', '2025-11-20 22:03:01'),
(9, 2, 10000, '2025-11-21 14:27:29', '2025-11-21 14:27:29'),
(10, 2, 62990, '2025-11-21 14:32:06', '2025-11-21 14:32:06'),
(11, 2, 10000, '2025-11-21 14:42:08', '2025-11-21 14:42:08'),
(12, 3, 10000, '2025-11-21 14:46:19', '2025-11-21 14:46:19'),
(13, 2, 53990, '2025-11-21 14:56:38', '2025-11-21 14:56:38'),
(14, 2, 10000, '2025-11-21 14:57:45', '2025-11-21 14:57:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_items`
--

CREATE TABLE `sales_items` (
  `id` bigint(20) NOT NULL,
  `sale_id` bigint(20) NOT NULL,
  `videogame_id` bigint(20) NOT NULL,
  `nIntercambios` int(11) NOT NULL,
  `totalprice` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'en_biblioteca',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sales_items`
--

INSERT INTO `sales_items` (`id`, `sale_id`, `videogame_id`, `nIntercambios`, `totalprice`, `status`, `created_at`, `updated_at`) VALUES
(4, 1, 1, 0, 10000, 'active', '2025-11-19 17:40:54', NULL),
(5, 1, 2, 0, 15000, 'active', '2025-11-19 17:40:54', NULL),
(6, 1, 3, 0, 25000, 'active', '2025-11-19 17:40:54', NULL),
(7, 5, 4, 0, 53990, 'active', '2025-11-20 20:33:45', '2025-11-20 20:33:45'),
(8, 6, 5, 0, 62990, 'active', '2025-11-20 20:36:42', '2025-11-20 20:36:42'),
(9, 7, 1, 0, 10000, 'active', '2025-11-20 20:39:43', '2025-11-20 20:39:43'),
(10, 8, 6, 0, 40, 'active', '2025-11-20 22:03:01', '2025-11-20 22:03:01'),
(11, 9, 1, 0, 10000, 'active', '2025-11-21 14:27:29', '2025-11-21 14:27:29'),
(12, 10, 5, 0, 62990, 'active', '2025-11-21 14:32:06', '2025-11-21 14:32:06'),
(13, 11, 1, 0, 10000, 'active', '2025-11-21 14:42:08', '2025-11-21 14:42:08'),
(14, 12, 1, 0, 10000, 'active', '2025-11-21 14:46:19', '2025-11-21 14:46:19'),
(15, 13, 4, 0, 53990, 'active', '2025-11-21 14:56:38', '2025-11-21 14:56:38'),
(16, 14, 1, 0, 10000, 'active', '2025-11-21 14:57:45', '2025-11-21 14:57:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trades`
--

CREATE TABLE `trades` (
  `id` bigint(20) NOT NULL,
  `sale_item_id` bigint(20) NOT NULL,
  `from_user` bigint(20) NOT NULL,
  `to_user` bigint(20) NOT NULL,
  `trade_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `firebase_uid` varchar(255) DEFAULT NULL,
  `email` varchar(55) NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `firebase_uid`, `email`, `name`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, NULL, 'admin', 'admin', 'admin', 2, '2025-11-08 19:30:14', '2025-11-08 19:30:14'),
(2, 'VlT7TaT828MfqEloiwiRZ1dr4Gs2', 'userprueba@gmail.com', 'Usuario', NULL, NULL, '2025-11-20 05:28:39', '2025-11-20 05:28:39'),
(3, 'DyLg0Lk8eLhUEsVkK2IqrE0JQGA3', 'userprueba2@gmail.com', 'Usuario', NULL, NULL, '2025-11-21 14:46:07', '2025-11-21 14:46:07'),
(4, 'dBtOG7YmFweCKR2VKrnvna1R1vw2', 'usertest@gmail.com', 'Usuario', NULL, NULL, '2025-11-21 14:50:18', '2025-11-21 14:50:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `videogames`
--

CREATE TABLE `videogames` (
  `id` bigint(20) NOT NULL,
  `genre_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `videogames`
--

INSERT INTO `videogames` (`id`, `genre_id`, `name`, `description`, `price`) VALUES
(1, 2, 'Overcooked 2', '¡Overcooked vuelve con un nuevo y caótico juego de cocina en acción! Regresa al Reino de la Cebolla y organiza tu equipo de chefs en un cooperativo clásico o en partidas en línea de hasta cuatro jugadores. Agarraos los delantales... es hora de salvar el mundo (¡otra vez!)', 10000),
(2, 1, 'The Last of Us™ Part I', 'Descubre el galardonado juego que inspiró la aclamada serie de televisión. Guía a Joel y Ellie en su travesía por una América posapocalíptica y encuentra aliados y enemigos inolvidables en The Last of Us™.', 50000),
(3, 4, 'Sid Meier’s Civilization® VI', 'Expande tu imperio, haz avanzar tu cultura y enfréntate a los mejores líderes de la historia. ¿Podrá tu civilización superar la prueba del tiempo? ', 44990),
(4, 1, 'Red Dead Redemption 2', 'Arthur Morgan y la banda de Van der Linde se ven obligados a huir. Con agentes federales y cazarrecompensas pisándoles los talones, la banda deberá atracar, robar y luchar para sobrevivir en su camino por el escabroso territorio.', 53990),
(5, 3, 'Battlefield™ 6', 'La experiencia bélica definitiva. En una guerra de tanques, cazas y gigantescos arsenales de combate, el arma más mortífera es tu patrulla.', 62990),
(6, 1, 'The Witcher 3: Wild Hunt', 'Eres Geralt de Rivia, cazador de monstruos. En un continente devastado por la guerra e infestado de criaturas, tu misión es encontrar a Ciri, la niña de la profecía, un arma viviente que puede alterar el mundo tal y como lo conocemos', 40),
(7, 1, 'Cyberpunk 2077', 'Cyberpunk 2077 es un RPG de aventura y acción de mundo abierto ambientado en el futuro sombrío de Night City, una peligrosa megalópolis obsesionada con el poder, el glamur y las incesantes modificaciones corporales', 50),
(8, 1, 'God of War (2018)', 'Kratos ha dejado atrás su venganza contra los dioses del Olimpo y vive ahora como un hombre en los dominios de los dioses y monstruos nórdicos. En este mundo cruel e implacable debe luchar para sobrevivir… y enseñar a su hijo a hacerlo también.', 60),
(9, 1, 'God of War: Ragnarök', 'Kratos y Atreus se embarcan en una mítica aventura en busca de respuestas y aliados antes de la llegada del Ragnarök. Ahora también en PC.', 70),
(10, 1, 'Horizon Zero Dawn', 'Disfruta de Horizon Zero Dawn™, el juego aclamado por la crítica, con un impresionante y renovado apartado gráfico y más mejoras que nunca. En un futuro en el que colosales máquinas dominan la Tierra, los reductos de la humanidad sobreviven en tribus entre las ruinas de nuestra extinta civilización', 30),
(11, 1, 'Horizon Forbidden West', 'Disfruta del épico Horizon Forbidden West™ completo con contenido adicional y la expansión Burning Shores. El complemento Burning Shores incluye contenido adicional para la aventura de Aloy, con nuevas tramas, personajes y experiencias en una nueva área espectacular a la vez que implacable.', 60),
(12, 1, 'The Last of Us', 'Descubre el galardonado juego que inspiró la aclamada serie de televisión. Guía a Joel y Ellie por unos Estados Unidos postapocalípticos y encuentra aliados y enemigos inolvidables en The Last of Us™.', 20),
(13, 1, 'The Last of Us Part II', 'Disfruta en PC del ganador de más de 300 premios al Juego del Año. Descubre la historia de Ellie y Abby con mejoras gráficas, modos de juego como la experiencia de supervivencia roguelike \"Sin retorno\" y mucho más.', 40),
(14, 4, 'Minecraft', 'Juego de construcción y supervivencia en mundos generados proceduralmente.', 27),
(15, 3, 'Fortnite', 'Shooter multijugador con batalla real y construcción.', 0),
(16, 3, 'Call of Duty: Modern Warfare II', 'El juego más esperado del año y la secuela del juego de acción en primera persona número uno en ventas de todos los tiempos, Modern Warfare 2 continúa con la tensión y la acción trepidante enfrentando a los jugadores con una nueva amenaza decidida a situar al mundo al borde del colapso.', 70),
(17, 3, 'Call of Duty: Black Ops Cold War', 'Black Ops Cold War, la secuela directa de Call of Duty®: Black Ops, transportará a los jugadores al centro de la volátil batalla geopolítica de la Guerra Fría, a principios de los 80.', 60),
(18, 1, 'Elden Ring', 'EL NUEVO JUEGO DE ROL Y ACCIÓN DE AMBIENTACIÓN FANTÁSTICA. Álzate, Sinluz, y que la gracia te guíe para abrazar el poder del Círculo de Elden y encumbrarte como señor del Círculo en las Tierras Intermedias.', 60),
(19, 1, 'Dark Souls III', 'Dark Souls continúa redefiniendo los límites con el nuevo y ambicioso capítulo de esta serie revolucionaria, tan aclamada por la crítica. ¡Prepárate para sumergirte en la oscuridad!', 30),
(20, 1, 'Assassin’s Creed Valhalla', 'Assassins Creed Valhalla es un juego de acción y aventura en el que eres un guerrero vikingo que ha crecido escuchando historias de batallas y gloria. Explora un dinámico mundo abierto ambientado en el brutal trasfondo de la Alta Edad Media inglesa.\r\n', 50),
(21, 1, 'Assassin’s Creed Odyssey', 'En este juego de acción y aventura, pon rumbo a la antigua Grecia para cambiar su destino. Participa en cruentas batallas por tierra y mar, cambia una vida de marginación por la gloria y descubre los secretos de tu pasado.', 40),
(22, 1, 'Assassin’s Creed Origins', 'Explora el antiguo Egipto en este juego de acción y aventura. Enfréntate a enemigos poderosos, desvela conspiraciones y descubre la historia del origen de la Hermandad de Asesinos.', 30),
(23, 1, 'Resident Evil 4 Remake', 'Sobrevivir es solo el principio. Con una mecánica de juego modernizada, una historia reimaginada y unos gráficos espectacularmente detallados, Resident Evil 4 supone el renacimiento de un gigante del mundo de los videojuegos.', 60),
(24, 1, 'Resident Evil Village', 'Vive el survival horror como nunca antes en la 8.ª entrega principal de la aclamada serie Resident Evil: Resident Evil Village. El terror más realista e inescapable, con gráficos hiperdetallados, intensa acción en 1.ª persona y una trama magistral.', 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `videogame_images`
--

CREATE TABLE `videogame_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `videogame_id` int(11) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `videogame_images`
--

INSERT INTO `videogame_images` (`id`, `videogame_id`, `image_path`) VALUES
(1, 1, 'data/img/overcooked2-header.jpg'),
(2, 1, 'data/img/overcooked2-img-1.jpg'),
(3, 2, 'data/img/tlou-p1-header.jpg'),
(4, 2, 'data/img/tlou-p1-img-1.jpg'),
(5, 3, 'data/img/civ6-header.jpg'),
(6, 3, 'data/img/civ6-img1.jpg'),
(7, 4, 'data/img/rdr2-header.jpg'),
(8, 4, 'data/img/rdr2-img1.jpg'),
(9, 5, 'data/img/battlefield6-header.jpg'),
(10, 5, 'data/img/battlefield6-img1.jpg');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `library`
--
ALTER TABLE `library`
  ADD PRIMARY KEY (`id`),
  ADD KEY `foranea1` (`unique_game_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`idOferta`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buyer` (`buyer`);

--
-- Indices de la tabla `sales_items`
--
ALTER TABLE `sales_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `foranea11` (`sale_id`),
  ADD KEY `foranea12` (`videogame_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `firebase_uid` (`firebase_uid`);

--
-- Indices de la tabla `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indices de la tabla `videogames`
--
ALTER TABLE `videogames`
  ADD PRIMARY KEY (`id`),
  ADD KEY `foranea2` (`genre_id`);

--
-- Indices de la tabla `videogame_images`
--
ALTER TABLE `videogame_images`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `genres`
--
ALTER TABLE `genres`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `library`
--
ALTER TABLE `library`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `offers`
--
ALTER TABLE `offers`
  MODIFY `idOferta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `sales_items`
--
ALTER TABLE `sales_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `videogames`
--
ALTER TABLE `videogames`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `videogame_images`
--
ALTER TABLE `videogame_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `library`
--
ALTER TABLE `library`
  ADD CONSTRAINT `foranea1` FOREIGN KEY (`unique_game_id`) REFERENCES `sales_items` (`id`);

--
-- Filtros para la tabla `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`buyer`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `sales_items`
--
ALTER TABLE `sales_items`
  ADD CONSTRAINT `foranea11` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  ADD CONSTRAINT `foranea12` FOREIGN KEY (`videogame_id`) REFERENCES `videogames` (`id`);

--
-- Filtros para la tabla `videogames`
--
ALTER TABLE `videogames`
  ADD CONSTRAINT `foranea2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
