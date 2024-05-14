-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 28 Ara 2023, 20:25:21
-- Sunucu sürümü: 8.0.31
-- PHP Sürümü: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `ajans`
--

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `departman_personel`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `departman_personel` (IN `p_departman_id` INT)   SELECT *
FROM personel
WHERE departman_id = p_departman_id$$

DROP PROCEDURE IF EXISTS `dep_per_is`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dep_per_is` (IN `p_departman_id` INT)   SELECT isler.*, personel.ad AS personel_ad, 
personel.soyad AS personel_soyad, musteriler.sirket_ad
FROM isler, personel, musteriler
WHERE isler.personel_id = personel.personel_id
AND isler.musteri_id = musteriler.musteri_id
AND personel.departman_id = p_departman_id$$

DROP PROCEDURE IF EXISTS `Is_gider`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Is_gider` (IN `p_is_id` INT)   SELECT giderler.*
FROM giderler, isler
WHERE giderler.gider_id = isler.gider_id 
AND isler.is_id = p_is_id$$

DROP PROCEDURE IF EXISTS `musterinin_isleri`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `musterinin_isleri` (IN `p_musteri_id` INT)   SELECT isler.*
    FROM isler
    WHERE isler.musteri_id = p_musteri_id$$

DROP PROCEDURE IF EXISTS `personelSehir`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `personelSehir` (IN `p_personel_id` INT)   SELECT sehir_ad
FROM sehirler
WHERE sehir_id = (SELECT sehir_id FROM personel WHERE personel_id = p_personel_id)$$

DROP PROCEDURE IF EXISTS `personel_is`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `personel_is` (IN `p_is_id` INT)   SELECT personel.personel_id FROM personel, isler 
WHERE personel.personel_id = isler.personel_id 
AND isler.is_id = p_is_id$$

DROP PROCEDURE IF EXISTS `ToplamIs`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ToplamIs` ()   SELECT COUNT(*) AS toplam_is FROM isler$$

DROP PROCEDURE IF EXISTS `ToplamMaas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ToplamMaas` ()   SELECT SUM(miktar) AS toplam_maas
FROM maaslar$$

DROP PROCEDURE IF EXISTS `ToplamPersonel`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ToplamPersonel` ()   SELECT COUNT(*) AS toplam_personel
FROM personel$$

DROP PROCEDURE IF EXISTS `YasAralığındakiPersoneller`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `YasAralığındakiPersoneller` (IN `p_alt_limit` INT, IN `p_ust_limit` INT)   SELECT *
FROM personel
WHERE yas BETWEEN p_alt_limit AND p_ust_limit$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `departmanlar`
--

DROP TABLE IF EXISTS `departmanlar`;
CREATE TABLE IF NOT EXISTS `departmanlar` (
  `departman_id` int NOT NULL,
  `departman_ad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`departman_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `departmanlar`
--

INSERT INTO `departmanlar` (`departman_id`, `departman_ad`) VALUES
(1, 'Part-Time'),
(2, 'Full-Time'),
(3, 'Ulaşım'),
(4, 'Yöneteci'),
(5, 'Sekreter'),
(6, 'Rejisör'),
(7, 'Bilgi Teknolojileri'),
(8, 'Müzik'),
(9, 'Işık'),
(10, 'Karşılama');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `eski_personeller`
--

DROP TABLE IF EXISTS `eski_personeller`;
CREATE TABLE IF NOT EXISTS `eski_personeller` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `personel_id` int DEFAULT NULL,
  `ad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `soyad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `yas` int DEFAULT NULL,
  `telefon` varchar(15) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `departman_id` int DEFAULT NULL,
  `tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `eski_personeller`
--

INSERT INTO `eski_personeller` (`log_id`, `personel_id`, `ad`, `soyad`, `yas`, `telefon`, `departman_id`, `tarih`) VALUES
(1, 11, 'Ali', 'Kaya', 32, '555-1111', 1, '2023-12-24 19:51:27'),
(2, 11, 'asda', 'dsasd', 19, '05071333389', 1, '2023-12-25 10:33:42');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `fisler`
--

DROP TABLE IF EXISTS `fisler`;
CREATE TABLE IF NOT EXISTS `fisler` (
  `fis_id` int NOT NULL,
  `fis_ad` varchar(50) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`fis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `fisler`
--

INSERT INTO `fisler` (`fis_id`, `fis_ad`) VALUES
(1, 'Yemek'),
(2, 'Taksi'),
(3, 'Giriş'),
(4, 'Otopark'),
(5, 'Avm'),
(6, 'Fotokopi'),
(7, 'Otel'),
(8, 'Bilet'),
(9, 'Müze'),
(10, 'Ekstra');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `giderler`
--

DROP TABLE IF EXISTS `giderler`;
CREATE TABLE IF NOT EXISTS `giderler` (
  `gider_id` int NOT NULL,
  `miktar` decimal(10,2) DEFAULT NULL,
  `tarih` date DEFAULT NULL,
  `fis_id` int DEFAULT NULL,
  PRIMARY KEY (`gider_id`),
  KEY `fis_id` (`fis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `giderler`
--

INSERT INTO `giderler` (`gider_id`, `miktar`, `tarih`, `fis_id`) VALUES
(1, '100.00', '2023-01-11', 1),
(2, '200.00', '2023-01-12', 2),
(3, '300.00', '2023-01-13', 3),
(4, '400.00', '2023-01-14', 4),
(5, '500.00', '2023-01-15', 5),
(6, '600.00', '2023-01-16', 6),
(7, '700.00', '2023-01-17', 7),
(8, '800.00', '2023-01-18', 8),
(9, '900.00', '2023-01-19', 9),
(10, '10.00', '2023-01-20', 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `guncel_personeller`
--

DROP TABLE IF EXISTS `guncel_personeller`;
CREATE TABLE IF NOT EXISTS `guncel_personeller` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `personel_id` int DEFAULT NULL,
  `ad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `soyad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `yas` int DEFAULT NULL,
  `telefon` varchar(15) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `departman_id` int DEFAULT NULL,
  `tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `guncel_personeller`
--

INSERT INTO `guncel_personeller` (`log_id`, `personel_id`, `ad`, `soyad`, `yas`, `telefon`, `departman_id`, `tarih`) VALUES
(1, 11, 'Ali', 'Kaya', 32, '555-1111', 1, '2023-12-24 19:50:57');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `isler`
--

DROP TABLE IF EXISTS `isler`;
CREATE TABLE IF NOT EXISTS `isler` (
  `is_id` int NOT NULL,
  `aciklama` text COLLATE utf8mb3_turkish_ci,
  `gider_id` int DEFAULT NULL,
  `musteri_id` int DEFAULT NULL,
  `mekan` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `zaman` datetime DEFAULT NULL,
  `kazanc` decimal(10,2) DEFAULT NULL,
  `personel_id` int DEFAULT NULL,
  PRIMARY KEY (`is_id`),
  KEY `gider_id` (`gider_id`),
  KEY `musteri_id` (`musteri_id`),
  KEY `personel_id` (`personel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `isler`
--

INSERT INTO `isler` (`is_id`, `aciklama`, `gider_id`, `musteri_id`, `mekan`, `zaman`, `kazanc`, `personel_id`) VALUES
(1, 'TOPLANTI', 1, 1, 'TANITIM', '2023-03-01 10:00:00', '8000.00', 1),
(2, 'TOPLANTI', 2, 2, 'Movenpick-otel', '2023-03-02 10:00:00', '8000.00', 2),
(3, 'TANITIM', 3, 3, 'Hyaat-otel', '2023-03-03 10:00:00', '8000.00', 3),
(4, 'TOPLANTI', 4, 4, 'Kaya-otel', '2023-03-04 10:00:00', '8000.00', 4),
(5, 'TANITIM', 5, 5, 'Ege-palas-otel', '2023-03-05 10:00:00', '8000.00', 5),
(6, 'TOPLANTI', 6, 6, 'Hilton-otel', '2023-03-06 10:00:00', '8000.00', 6),
(7, 'TANITIM', 7, 7, 'Radison-otel', '2023-03-07 10:00:00', '8000.00', 7),
(8, 'TOPLANTI', 8, 8, 'Ramada-otel', '2023-03-08 10:00:00', '8000.00', 8),
(9, 'TANITIM', 9, 9, 'Marriot-otel', '2023-03-09 10:00:00', '8000.00', 9),
(10, 'TOPLANTI', 10, 10, 'Swissotel-otel', '2023-03-10 10:00:00', '8000.00', 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `maaslar`
--

DROP TABLE IF EXISTS `maaslar`;
CREATE TABLE IF NOT EXISTS `maaslar` (
  `maas_id` int NOT NULL,
  `departman_id` int DEFAULT NULL,
  `miktar` decimal(10,2) DEFAULT NULL,
  `tarih` date DEFAULT NULL,
  PRIMARY KEY (`maas_id`),
  KEY `departman_id` (`departman_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `maaslar`
--

INSERT INTO `maaslar` (`maas_id`, `departman_id`, `miktar`, `tarih`) VALUES
(1, 1, '6000.00', '2023-01-01'),
(2, 2, '6000.00', '2023-01-01'),
(3, 3, '6000.00', '2023-01-01'),
(4, 4, '6000.00', '2023-01-01'),
(5, 5, '6000.00', '2023-01-01'),
(6, 6, '6000.00', '2023-01-01'),
(7, 7, '6000.00', '2023-01-01'),
(8, 8, '6000.00', '2023-01-01'),
(9, 9, '6000.00', '2023-01-01'),
(10, 10, '6000.00', '2023-01-01');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `musteriler`
--

DROP TABLE IF EXISTS `musteriler`;
CREATE TABLE IF NOT EXISTS `musteriler` (
  `musteri_id` int NOT NULL,
  `ad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `soyad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `telefon` varchar(15) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `sirket_ad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`musteri_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `musteriler`
--

INSERT INTO `musteriler` (`musteri_id`, `ad`, `soyad`, `telefon`, `email`, `sirket_ad`) VALUES
(1, 'Fatma', 'Kara', '555-1111', 'fatma.kara@example.com', 'SIEMENS'),
(2, 'Batu', 'Kutu', '555-1112', 'batu.kara@example.com', 'PFISER'),
(3, 'Ayhan', 'Kuru', '555-1113', 'ayhan.kara@example.com', 'PUNTO'),
(4, 'Osman', 'Cenk', '555-1114', 'osman.kara@example.com', 'OCEAN'),
(5, 'Fatih', 'Terim', '555-1115', 'fatih.kara@example.com', 'TESLA'),
(6, 'Bedir', 'Demir', '555-1116', 'bedir.kara@example.com', 'JAGUAR'),
(7, 'Uygar', 'Ataç', '555-1117', 'uygar.kara@example.com', 'KOÇ'),
(8, 'Dilan', 'Polat', '555-1118', 'dilan.kara@example.com', 'SABANCI'),
(9, 'Ceyda', 'Durgun', '555-1119', 'ceyda.kara@example.com', 'GARANTİ'),
(10, 'Ayşe', 'Balım', '555-1110', 'ayse.kara@example.com', 'ZİRAAT');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `personel`
--

DROP TABLE IF EXISTS `personel`;
CREATE TABLE IF NOT EXISTS `personel` (
  `personel_id` int NOT NULL,
  `ad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `soyad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `yas` int DEFAULT NULL,
  `telefon` varchar(15) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `departman_id` int DEFAULT NULL,
  `sehir_id` int DEFAULT NULL,
  PRIMARY KEY (`personel_id`),
  KEY `departman_id` (`departman_id`),
  KEY `sehir_id` (`sehir_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `personel`
--

INSERT INTO `personel` (`personel_id`, `ad`, `soyad`, `yas`, `telefon`, `departman_id`, `sehir_id`) VALUES
(1, 'Kaan', 'Balcı', 23, '555-1234', 1, 1),
(2, 'Seher', 'Güven', 25, '555-1235', 2, 2),
(3, 'Eren', 'Turgut', 26, '555-1236', 3, 3),
(4, 'Kursad', 'Dönmez', 40, '555-1237', 4, 4),
(5, 'Batur', 'Berrak', 25, '555-1238', 5, 5),
(6, 'Efe', 'Adasal', 26, '555-1239', 6, 6),
(7, 'Baran', 'Arat', 27, '555-1231', 7, 7),
(8, 'Uğur', 'Düzgün', 28, '555-1232', 8, 8),
(9, 'Berra', 'Bozdağa', 29, '555-1222', 9, 9),
(10, 'Ayberk', 'Yavaş', 30, '555-1233', 10, 10);

--
-- Tetikleyiciler `personel`
--
DROP TRIGGER IF EXISTS `personel_ekleme`;
DELIMITER $$
CREATE TRIGGER `personel_ekleme` AFTER INSERT ON `personel` FOR EACH ROW INSERT INTO yeni_personeller (personel_id, ad, soyad, yas, telefon, departman_id)
VALUES (NEW.personel_id, NEW.ad, NEW.soyad, NEW.yas, NEW.telefon, NEW.departman_id)
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `personel_güncelleme`;
DELIMITER $$
CREATE TRIGGER `personel_güncelleme` AFTER UPDATE ON `personel` FOR EACH ROW INSERT INTO guncel_personeller (personel_id, ad, soyad, yas, telefon, departman_id)
VALUES (NEW.personel_id, NEW.ad, NEW.soyad, NEW.yas, NEW.telefon, NEW.departman_id)
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `personel_silinme`;
DELIMITER $$
CREATE TRIGGER `personel_silinme` AFTER DELETE ON `personel` FOR EACH ROW INSERT INTO eski_personeller (personel_id, ad, soyad, yas, telefon, departman_id)
VALUES (OLD.personel_id, OLD.ad, OLD.soyad, OLD.yas, OLD.telefon, OLD.departman_id)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sehirler`
--

DROP TABLE IF EXISTS `sehirler`;
CREATE TABLE IF NOT EXISTS `sehirler` (
  `sehir_id` int NOT NULL,
  `sehir_ad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`sehir_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `sehirler`
--

INSERT INTO `sehirler` (`sehir_id`, `sehir_ad`) VALUES
(1, 'İstanbul'),
(2, 'İzmir'),
(3, 'Ankara'),
(4, 'Bodrum'),
(5, 'Antalya'),
(6, 'Bursa'),
(7, 'Manisa'),
(8, 'Tekirdağ'),
(9, 'Çanakkale'),
(10, 'Balıkesir');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yeni_personeller`
--

DROP TABLE IF EXISTS `yeni_personeller`;
CREATE TABLE IF NOT EXISTS `yeni_personeller` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `personel_id` int DEFAULT NULL,
  `ad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `soyad` varchar(255) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `yas` int DEFAULT NULL,
  `telefon` varchar(15) COLLATE utf8mb3_turkish_ci DEFAULT NULL,
  `departman_id` int DEFAULT NULL,
  `tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_turkish_ci;

--
-- Tablo döküm verisi `yeni_personeller`
--

INSERT INTO `yeni_personeller` (`log_id`, `personel_id`, `ad`, `soyad`, `yas`, `telefon`, `departman_id`, `tarih`) VALUES
(1, 11, 'Zeynep', 'Kaya', 28, '555-1111', 1, '2023-12-24 19:50:22'),
(2, 11, 'asda', 'dsasd', 19, '05071333389', 1, '2023-12-25 10:33:19');

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `giderler`
--
ALTER TABLE `giderler`
  ADD CONSTRAINT `giderler_ibfk_1` FOREIGN KEY (`fis_id`) REFERENCES `fisler` (`fis_id`);

--
-- Tablo kısıtlamaları `isler`
--
ALTER TABLE `isler`
  ADD CONSTRAINT `isler_ibfk_1` FOREIGN KEY (`gider_id`) REFERENCES `giderler` (`gider_id`),
  ADD CONSTRAINT `isler_ibfk_2` FOREIGN KEY (`musteri_id`) REFERENCES `musteriler` (`musteri_id`),
  ADD CONSTRAINT `isler_ibfk_3` FOREIGN KEY (`personel_id`) REFERENCES `personel` (`personel_id`);

--
-- Tablo kısıtlamaları `maaslar`
--
ALTER TABLE `maaslar`
  ADD CONSTRAINT `maaslar_ibfk_1` FOREIGN KEY (`departman_id`) REFERENCES `departmanlar` (`departman_id`);

--
-- Tablo kısıtlamaları `personel`
--
ALTER TABLE `personel`
  ADD CONSTRAINT `personel_ibfk_1` FOREIGN KEY (`departman_id`) REFERENCES `departmanlar` (`departman_id`),
  ADD CONSTRAINT `personel_ibfk_2` FOREIGN KEY (`sehir_id`) REFERENCES `sehirler` (`sehir_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
