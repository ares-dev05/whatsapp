-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2021 at 07:48 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ci_upload`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_conversation`
--

CREATE TABLE `tb_conversation` (
  `id` int(11) NOT NULL,
  `date` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `background` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lastseen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_images`
--

CREATE TABLE `tb_images` (
  `id` int(11) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_images`
--

INSERT INTO `tb_images` (`id`, `image_path`, `image_name`) VALUES
(1, '/assets/images/2aa427e851fbbdc2c68c677fa889e4ce.png', '2aa427e851fbbdc2c68c677fa889e4ce.png'),
(2, '/assets/images/e532f700cdfa80d4055c06d0da6fd5de.png', 'e532f700cdfa80d4055c06d0da6fd5de.png'),
(3, '/assets/images/92dccc634fb0bc5e0d467dbcdfb9a3c3.png', '92dccc634fb0bc5e0d467dbcdfb9a3c3.png');

-- --------------------------------------------------------

--
-- Table structure for table `tb_messages`
--

CREATE TABLE `tb_messages` (
  `id` int(11) NOT NULL,
  `images` varchar(2555) DEFAULT NULL,
  `sender` int(1) DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `time` varchar(10) DEFAULT NULL,
  `message` varchar(2555) DEFAULT NULL,
  `con_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_messages`
--

INSERT INTO `tb_messages` (`id`, `images`, `sender`, `state`, `time`, `message`, `con_id`) VALUES
(21, '', 0, 'send', '03:51:06', 'Hi, Ares!:6:', 2),
(22, '', 1, 'send', '23:42:05', 'sdsd', 2),
(23, 'http://192.168.109.22/whatsapp_backend/assets/images/49e80211e5c8d0616ddd1df3c0e464d8.png:::', 0, 'send', '03:51:45', 'I am hero ZEUS!:89:', 2),
(24, 'http://192.168.109.22/whatsapp_backend/assets/images/6a912716226143ca43f046e8fb26656c.png:::', 1, 'send', '03:51:23', 'What? Ares?:144::144::144:', 2),
(25, '', 1, 'send', '03:52:34', 'Are you kidding me?:3:', 2),
(32, '', 0, 'send', '03:51:06', 'Hi, Ares!:6:', 3),
(33, 'http://192.168.109.22/whatsapp_backend/assets/images/49e80211e5c8d0616ddd1df3c0e464d8.png:::', 0, 'send', '03:51:45', 'I am hero ZEUS!:89:', 3),
(34, '', 1, 'send', '03:52:34', 'Are you kidding me?:3:', 3),
(35, '', 1, 'send', '03:51:23', 'What? Ares?:144::144::144:', 3),
(36, '', 0, 'send', '23:40:06', 'Hi!!', 3),
(37, '', 1, 'send', '03:51:23', 'What? Ares?:144::144::144:', 1),
(38, '', 1, 'send', '17:08:44', 'sd', 1),
(39, '', 0, 'send', '03:51:06', 'Hi, Ares!:6:', 1),
(40, '', 0, 'send', '23:40:06', 'Hi!!', 1),
(41, 'http://192.168.109.22/whatsapp_backend/assets/images/49e80211e5c8d0616ddd1df3c0e464d8.png:::', 0, 'send', '03:51:45', 'I am hero ZEUS!:89:', 1),
(42, '', 1, 'send', '03:52:34', 'Are you kidding me?:3:', 1),
(43, '', 1, 'send', '23:42:05', 'sdsd', 1),
(44, '', 1, 'send', '03:51:23', 'What? Ares?:144::144::144:', 4),
(45, '', 0, 'send', '03:51:06', 'Hi, Ares!:6:', 4),
(46, 'http://192.168.109.22/whatsapp_backend/assets/images/49e80211e5c8d0616ddd1df3c0e464d8.png:::', 0, 'send', '03:51:45', 'I am hero ZEUS!:89:', 4),
(47, '', 1, 'send', '03:52:34', 'Are you kidding me?:3:', 4),
(48, '', 0, 'send', '23:40:06', 'Hi!!', 4),
(49, '', 0, 'send', '19:02:42', 'hey how are you?', 5),
(50, '', 1, 'send', '19:03:32', 'i a fine an u', 5),
(51, '', 0, 'send', '19:05:52', 'i am fine ', 6),
(52, '', 1, 'send', '19:03:32', 'i a fine an u', 6),
(53, '', 0, 'send', '19:02:42', 'hey how are you?', 6),
(54, '', 0, 'send', '19:06:03', 'test', 6),
(55, '', 1, 'send', '19:05:59', 'hello', 6),
(56, 'http://192.168.109.22/whatsapp_backend/assets/images/e8ab548765e735f8d7a24ca530e74020.png:::', 0, 'send', '01:56:58', ':14: :14: :14:  Schatz du bist echt der beste!!!!!! Wo bist du????', 7),
(57, '', 1, 'send', '01:57:52', 'Geh nicht ins Bad.. Könnte unangenehm werden.', 7),
(58, '', 1, 'send', '01:57:27', 'Hä? Was machst du Zuhause? Ich dachte du bist erst in 4 Tage zurück', 7),
(59, 'http://192.168.109.22/whatsapp_backend/assets/images/09f40bb31aeaff45252ce02204c65ac4.png:::', 1, 'send', '01:58:02', '', 7),
(60, 'http://192.168.109.22/whatsapp_backend/assets/images/c92f50fb86b275cfb2912cb55b603204.png:::', 0, 'send', '02:19:13', 'Schau mal wo ich bin :88: :88: na wie fühlst du dich jetzt?', 8),
(61, '', 1, 'send', '02:20:53', 'Ok was ist dn passiert?', 8),
(62, '', 0, 'send', '02:19:23', 'Tut das weh?', 8),
(63, '', 1, 'send', '02:19:57', 'As machst du da bei meiner Freundin? Ich hab erst in 30 Minuten Feierabend dann bist du darn.', 8);

-- --------------------------------------------------------

--
-- Table structure for table `tb_screenshots`
--

CREATE TABLE `tb_screenshots` (
  `id` int(11) UNSIGNED NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `image_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_screenshots`
--

INSERT INTO `tb_screenshots` (`id`, `image_path`, `image_name`) VALUES
(1, '/assets/images/1d63a3c87134d2a3b48b0555e30ffd73.jpg', '1d63a3c87134d2a3b48b0555e30ffd73.jpg'),
(2, '/assets/images/98da1d7ef5b3ba3c567f8f4c0788ffc3.jpg', '98da1d7ef5b3ba3c567f8f4c0788ffc3.jpg'),
(3, '/assets/images/e84febb609492db2b581d89251cc62b9.jpg', 'e84febb609492db2b581d89251cc62b9.jpg'),
(4, '/assets/images/66baeae10504241737a27fe60c2f6b21.jpg', '66baeae10504241737a27fe60c2f6b21.jpg'),
(5, '/assets/images/e7ce19439f1d3282a9cfffc0ab4eb8b2.jpg', 'e7ce19439f1d3282a9cfffc0ab4eb8b2.jpg'),
(6, '/assets/images/b8622a454907f338781bb709e33df8f3.jpg', 'b8622a454907f338781bb709e33df8f3.jpg'),
(7, '/assets/images/46434983411fbb10bb013d8a20042a82.jpg', '46434983411fbb10bb013d8a20042a82.jpg'),
(8, '/assets/images/a76757274fd1ba3079571023a07bec3c.jpg', 'a76757274fd1ba3079571023a07bec3c.jpg'),
(9, '/assets/images/46e2fba732bf1cb05a07c501172dd42f.jpg', '46e2fba732bf1cb05a07c501172dd42f.jpg'),
(10, '/assets/images/0d59b896c7d43b7f65e170185123b573.jpg', '0d59b896c7d43b7f65e170185123b573.jpg'),
(11, '/assets/images/fd7967f1e4c0c07dc3f3025d233677d6.jpg', 'fd7967f1e4c0c07dc3f3025d233677d6.jpg'),
(12, '/assets/images/f273f7029828adee8310c0246565bcc0.jpg', 'f273f7029828adee8310c0246565bcc0.jpg'),
(13, '/assets/images/b78d5ae3ee358166b555a5d1318495cb.jpg', 'b78d5ae3ee358166b555a5d1318495cb.jpg'),
(14, '/assets/images/bb0f358b09f5a16af9419ce38c4308e3.jpg', 'bb0f358b09f5a16af9419ce38c4308e3.jpg'),
(15, '/assets/images/23adda04b90a9c0c112934f3d5052824.jpg', '23adda04b90a9c0c112934f3d5052824.jpg'),
(16, '/assets/images/27b1ab3509f6016f4ece18873aab62a1.jpg', '27b1ab3509f6016f4ece18873aab62a1.jpg'),
(17, '/assets/images/3d00b0399294b0fea0e9828e8e9e88e3.jpg', '3d00b0399294b0fea0e9828e8e9e88e3.jpg'),
(18, '/assets/images/3e3407022b7a851b15db45add59c73a2.jpg', '3e3407022b7a851b15db45add59c73a2.jpg'),
(19, '/assets/images/c301582b390da15391c3997308aad9cb.jpg', 'c301582b390da15391c3997308aad9cb.jpg'),
(20, '/assets/images/e2ae82e6eed2e482ddc9298948c7d63e.jpg', 'e2ae82e6eed2e482ddc9298948c7d63e.jpg'),
(21, '/assets/images/9f746339602232437027b53a8ab90b93.jpg', '9f746339602232437027b53a8ab90b93.jpg'),
(22, '/assets/images/2f1becf05fbc679c4be0d97c75a6ac06.jpg', '2f1becf05fbc679c4be0d97c75a6ac06.jpg'),
(23, '/assets/images/3af9a70eaae3030eb88690e6c8c846eb.jpg', '3af9a70eaae3030eb88690e6c8c846eb.jpg'),
(24, '/assets/images/d87f45cb093f9beaa0a8a420c74d8735.jpg', 'd87f45cb093f9beaa0a8a420c74d8735.jpg'),
(25, '/assets/images/d7a5f981af4d69dc00b52018a6e85633.jpg', 'd7a5f981af4d69dc00b52018a6e85633.jpg'),
(26, '/assets/images/d25433c8b817ebe8856165b4317135e8.jpg', 'd25433c8b817ebe8856165b4317135e8.jpg'),
(27, '/assets/images/e62bd08102e3c5627989b22f2a4e2505.jpg', 'e62bd08102e3c5627989b22f2a4e2505.jpg'),
(28, '/assets/images/d48191f2e553b10b4ddf4e55d66d33e2.jpg', 'd48191f2e553b10b4ddf4e55d66d33e2.jpg'),
(29, '/assets/images/ca495fd34b42b7a59008a7cda8da161f.jpg', 'ca495fd34b42b7a59008a7cda8da161f.jpg'),
(30, '/assets/images/c8d9f0ca584ff154d7509f18f6adeb79.jpg', 'c8d9f0ca584ff154d7509f18f6adeb79.jpg'),
(31, '/assets/images/69f72438d52e3530acbb9e722f49d220.jpg', '69f72438d52e3530acbb9e722f49d220.jpg'),
(32, '/assets/images/019726ca65700392fa068980df443f64.jpg', '019726ca65700392fa068980df443f64.jpg'),
(33, '/assets/images/13806294a5184877f7d30c9277f23987.jpg', '13806294a5184877f7d30c9277f23987.jpg'),
(34, '/assets/images/26caff02a6d5bb03e707517b2849e0af.jpg', '26caff02a6d5bb03e707517b2849e0af.jpg'),
(35, '/assets/images/f60edb5ec885ea177e30a580da4ebee3.jpg', 'f60edb5ec885ea177e30a580da4ebee3.jpg'),
(36, '/assets/images/96825e3efdc19e4bcbbceeca4cd0ceec.jpg', '96825e3efdc19e4bcbbceeca4cd0ceec.jpg'),
(37, '/assets/images/2884c923166bad36969c2bacf4d79216.jpg', '2884c923166bad36969c2bacf4d79216.jpg'),
(38, '/assets/images/5ea7d8a287032707f6d407c480ae3d94.jpg', '5ea7d8a287032707f6d407c480ae3d94.jpg'),
(39, '/assets/images/a7c1ef116bad3d08098dfdf74e2005e7.jpg', 'a7c1ef116bad3d08098dfdf74e2005e7.jpg'),
(40, '/assets/images/0f0b526555d3542994892f037ad91c14.jpg', '0f0b526555d3542994892f037ad91c14.jpg'),
(41, '/assets/images/59eca89fcfa20db462cb723abf6a1115.jpg', '59eca89fcfa20db462cb723abf6a1115.jpg'),
(42, '/assets/images/b7080497407da16c2bdf3c3a14fa8e86.jpg', 'b7080497407da16c2bdf3c3a14fa8e86.jpg'),
(43, '/assets/images/0b0df6198e4f932ec6aec1248f2b43c3.jpg', '0b0df6198e4f932ec6aec1248f2b43c3.jpg'),
(44, '/assets/images/63e02ff38530cf0459a780ba0d708251.jpg', '63e02ff38530cf0459a780ba0d708251.jpg'),
(45, '/assets/images/2fe485da77568727b10a89e14ea13072.jpg', '2fe485da77568727b10a89e14ea13072.jpg'),
(46, '/assets/images/6c98d9b4c13744711eb748e35178e8b6.jpg', '6c98d9b4c13744711eb748e35178e8b6.jpg'),
(47, '/assets/images/9c0854e4694eaca4ed1b4e4e137b9840.jpg', '9c0854e4694eaca4ed1b4e4e137b9840.jpg'),
(48, '/assets/images/2ae0a083e147b20f40e02e1059be2242.jpg', '2ae0a083e147b20f40e02e1059be2242.jpg'),
(49, '/assets/images/3c387436beac472fa30c714e6b7306cf.jpg', '3c387436beac472fa30c714e6b7306cf.jpg'),
(50, '/assets/images/97d944cd2b837c60adf101c23efda9d0.jpg', '97d944cd2b837c60adf101c23efda9d0.jpg'),
(51, '/assets/images/677a3aad0714c7df7a46e45d15b49d60.jpg', '677a3aad0714c7df7a46e45d15b49d60.jpg'),
(52, '/assets/images/aeea6ddd06b6b39aef37cbce72d40a5f.jpg', 'aeea6ddd06b6b39aef37cbce72d40a5f.jpg'),
(53, '/assets/images/0b331ee30b2048e6aa0f160e686c5c9a.jpg', '0b331ee30b2048e6aa0f160e686c5c9a.jpg'),
(54, '/assets/images/09a4ebf91a123b873cb7a7b010e67567.jpg', '09a4ebf91a123b873cb7a7b010e67567.jpg'),
(55, '/assets/images/1b00e19549b46a84fae876994ad79477.jpg', '1b00e19549b46a84fae876994ad79477.jpg'),
(56, '/assets/images/f4fb16dffab881082648f9ef5f2c6814.jpg', 'f4fb16dffab881082648f9ef5f2c6814.jpg'),
(57, '/assets/images/3603ee882f2bfd90bd2de76964d9a683.jpg', '3603ee882f2bfd90bd2de76964d9a683.jpg'),
(58, '/assets/images/97a46a956bd2fca829e0d2c1fd6f28ac.jpg', '97a46a956bd2fca829e0d2c1fd6f28ac.jpg'),
(59, '/assets/images/187e073b525095f246c41fd7c08620fc.jpg', '187e073b525095f246c41fd7c08620fc.jpg'),
(60, '/assets/images/478135b39995e6457d85c9a54dabc7ac.jpg', '478135b39995e6457d85c9a54dabc7ac.jpg'),
(61, '/assets/images/c8987d27bdcbfcf82a252f41a9d5eae4.jpg', 'c8987d27bdcbfcf82a252f41a9d5eae4.jpg'),
(62, '/assets/images/2b164a31e664d4b3471d2771fd0ee3b3.jpg', '2b164a31e664d4b3471d2771fd0ee3b3.jpg'),
(63, '/assets/images/87592d1b49c9fd780cbe85982d5ec7ab.jpg', '87592d1b49c9fd780cbe85982d5ec7ab.jpg'),
(64, '/assets/images/c75f7b026d7e1dc6f6a62f611958e277.jpg', 'c75f7b026d7e1dc6f6a62f611958e277.jpg'),
(65, '/assets/images/8d972cdc7ad914bbb3c0a2489abceed8.jpg', '8d972cdc7ad914bbb3c0a2489abceed8.jpg'),
(66, '/assets/images/d0e22ae03481b48f9f2220ee56adad98.jpg', 'd0e22ae03481b48f9f2220ee56adad98.jpg'),
(67, '/assets/images/f592a04de46617124f8cf1b46f0f25a7.jpg', 'f592a04de46617124f8cf1b46f0f25a7.jpg'),
(68, '/assets/images/6384e87d9fd789802eba1e9f583daa8a.jpg', '6384e87d9fd789802eba1e9f583daa8a.jpg'),
(69, '/assets/images/e2b5849399f0668278fe25b9cbc6a404.jpg', 'e2b5849399f0668278fe25b9cbc6a404.jpg'),
(70, '/assets/images/9e8eeaecf186a256121662e299504750.jpg', '9e8eeaecf186a256121662e299504750.jpg'),
(71, '/assets/images/b807cc18340e23612d54b973b9882137.jpg', 'b807cc18340e23612d54b973b9882137.jpg'),
(72, '/assets/images/ee3dc9ccc2328c2b6700996a7ae3a4fd.jpg', 'ee3dc9ccc2328c2b6700996a7ae3a4fd.jpg'),
(73, '/assets/images/28399f6bb1da1bc91d9dcfeeed561150.jpg', '28399f6bb1da1bc91d9dcfeeed561150.jpg'),
(74, '/assets/images/f8ddb223394e9af2984add5b3adb715b.jpg', 'f8ddb223394e9af2984add5b3adb715b.jpg'),
(75, '/assets/images/4d12389bd9ca99206aa0bd8f111c9e5e.jpg', '4d12389bd9ca99206aa0bd8f111c9e5e.jpg'),
(76, '/assets/images/b6bc4a8e57e74acac486736104b571f4.jpg', 'b6bc4a8e57e74acac486736104b571f4.jpg'),
(77, '/assets/images/1756c28726f519c6baa627481f9f6778.jpg', '1756c28726f519c6baa627481f9f6778.jpg'),
(78, '/assets/images/0a64d55af6517ed953a47d3890f62663.jpg', '0a64d55af6517ed953a47d3890f62663.jpg'),
(79, '/assets/images/1d4e143eae0f6d013e31ce9177b7d390.jpg', '1d4e143eae0f6d013e31ce9177b7d390.jpg'),
(80, '/assets/images/884e11b3521933207ec31c5984b0fc07.jpg', '884e11b3521933207ec31c5984b0fc07.jpg'),
(81, '/assets/images/371332e7ba549cd6bf306b0ef3b09423.jpg', '371332e7ba549cd6bf306b0ef3b09423.jpg'),
(82, '/assets/images/527b1e626ff66de460aa935f06c70dbf.jpg', '527b1e626ff66de460aa935f06c70dbf.jpg'),
(83, '/assets/images/694ae9f5b8451c3e5a3ff2b0620365e2.jpg', '694ae9f5b8451c3e5a3ff2b0620365e2.jpg'),
(84, '/assets/images/40677a221fc39c4e0a10af81753ee3f9.jpg', '40677a221fc39c4e0a10af81753ee3f9.jpg'),
(85, '/assets/images/1ba08e9832ffb54f25ee9a7f9e90bcc0.jpg', '1ba08e9832ffb54f25ee9a7f9e90bcc0.jpg'),
(86, '/assets/images/dc27ba5b47aeca9878e053f9eecef862.jpg', 'dc27ba5b47aeca9878e053f9eecef862.jpg'),
(87, '/assets/images/a88e411f17845726b7600b8db4e8d403.jpg', 'a88e411f17845726b7600b8db4e8d403.jpg'),
(88, '/assets/images/3fa7e6a7103f39de4dae2b0e3056f480.jpg', '3fa7e6a7103f39de4dae2b0e3056f480.jpg'),
(89, '/assets/images/58dd23afff552198db1e35c5af50749d.jpg', '58dd23afff552198db1e35c5af50749d.jpg'),
(90, '/assets/images/41740d5ee5651b90c9c6aeed9ab3d217.jpg', '41740d5ee5651b90c9c6aeed9ab3d217.jpg'),
(91, '/assets/images/edbe4285860cff32dc0f4ebbac59eaa7.jpg', 'edbe4285860cff32dc0f4ebbac59eaa7.jpg'),
(92, '/assets/images/bff7802c75bcc67d430ed7b3c2b052a4.jpg', 'bff7802c75bcc67d430ed7b3c2b052a4.jpg'),
(93, '/assets/images/b8e81c0de24782e6a711c721a4f56a19.jpg', 'b8e81c0de24782e6a711c721a4f56a19.jpg'),
(94, '/assets/images/f4ff6f5efd0b97acaca0d6db8dda94c1.jpg', 'f4ff6f5efd0b97acaca0d6db8dda94c1.jpg'),
(95, '/assets/images/7ebb79c0dbeb77439de2989f13a1ba3b.jpg', '7ebb79c0dbeb77439de2989f13a1ba3b.jpg'),
(96, '/assets/images/e6d21656f8cd56f02c89c36a9317a813.jpg', 'e6d21656f8cd56f02c89c36a9317a813.jpg'),
(97, '/assets/images/2ed0c23c7bee526341584f4902889efe.jpg', '2ed0c23c7bee526341584f4902889efe.jpg'),
(98, '/assets/images/97bb1588c01a449b2a3855a4bcedbc19.jpg', '97bb1588c01a449b2a3855a4bcedbc19.jpg'),
(99, '/assets/images/0876a64dc8bb8b6f2855928c68c2bf18.jpg', '0876a64dc8bb8b6f2855928c68c2bf18.jpg'),
(100, '/assets/images/23a902b4af1066dfef7fbbb8000c72ef.jpg', '23a902b4af1066dfef7fbbb8000c72ef.jpg'),
(101, '/assets/images/9b41255af70fc9fa48b1d76765881359.jpg', '9b41255af70fc9fa48b1d76765881359.jpg'),
(102, '/assets/images/5c0bb37d17aa973b7419dc71a7e285eb.jpg', '5c0bb37d17aa973b7419dc71a7e285eb.jpg'),
(103, '/assets/images/37238b586572a93b73ce90b045d54705.jpg', '37238b586572a93b73ce90b045d54705.jpg'),
(104, '/assets/images/131cb7fd8cb96dd5f6c3b179fe16171b.jpg', '131cb7fd8cb96dd5f6c3b179fe16171b.jpg'),
(105, '/assets/images/2827d8969b75e61f796dcf30ea8cdc1f.jpg', '2827d8969b75e61f796dcf30ea8cdc1f.jpg'),
(106, '/assets/images/495d0e08f0fc514c23899893c43c7851.jpg', '495d0e08f0fc514c23899893c43c7851.jpg'),
(107, '/assets/images/26c02cc84794b35288ae1ac5c49f7a10.jpg', '26c02cc84794b35288ae1ac5c49f7a10.jpg'),
(108, '/assets/images/b251e1f781d1356554dd0c92c94669f1.jpg', 'b251e1f781d1356554dd0c92c94669f1.jpg'),
(109, '/assets/images/4e1e5ae1d2d3fc5797240e3eacd9f71e.jpg', '4e1e5ae1d2d3fc5797240e3eacd9f71e.jpg'),
(110, '/assets/images/7e86152dc388a3e555a87d563adff1de.jpg', '7e86152dc388a3e555a87d563adff1de.jpg'),
(111, '/assets/images/bf617242cb2c1fe38a710614097683fa.jpg', 'bf617242cb2c1fe38a710614097683fa.jpg'),
(112, '/assets/images/8245a8d5a23234a742f2b531c16cb36d.jpg', '8245a8d5a23234a742f2b531c16cb36d.jpg'),
(113, '/assets/images/7f56cbd8a274d2703e402c15eaf46807.jpg', '7f56cbd8a274d2703e402c15eaf46807.jpg'),
(114, '/assets/images/098cf20e2838d993444be351a5ead1e0.jpg', '098cf20e2838d993444be351a5ead1e0.jpg'),
(115, '/assets/images/6a329b2be09f10bf169b0c1f593cf135.jpg', '6a329b2be09f10bf169b0c1f593cf135.jpg'),
(116, '/assets/images/61b0dffe5e89cb96297c6a72d2112413.jpg', '61b0dffe5e89cb96297c6a72d2112413.jpg'),
(117, '/assets/images/31aa54dc8cc7faaf59bec61ae205d85e.jpg', '31aa54dc8cc7faaf59bec61ae205d85e.jpg'),
(118, '/assets/images/7b75ec343623bb54d50cb55a86054d3d.jpg', '7b75ec343623bb54d50cb55a86054d3d.jpg'),
(119, '/assets/images/02c3ef5284ca7590471640cc6c063f72.jpg', '02c3ef5284ca7590471640cc6c063f72.jpg'),
(120, '/assets/images/3ca2970f0d9ab3f0fc9deec606d91c87.jpg', '3ca2970f0d9ab3f0fc9deec606d91c87.jpg'),
(121, '/assets/images/b445bafaa1db29794d897fb7170e8c35.jpg', 'b445bafaa1db29794d897fb7170e8c35.jpg'),
(122, '/assets/images/d9df8a53f0cf1fe68f34f56a9f63056e.jpg', 'd9df8a53f0cf1fe68f34f56a9f63056e.jpg'),
(123, '/assets/images/8b4b5198d16867a9ca0bc89588f4d42f.jpg', '8b4b5198d16867a9ca0bc89588f4d42f.jpg'),
(124, '/assets/images/6dd1ebb8e9310a0c5a1ab3020b0fd4f3.jpg', '6dd1ebb8e9310a0c5a1ab3020b0fd4f3.jpg'),
(125, '/assets/images/74e5c5361a5a8d16efbbc3582d55c2ad.jpg', '74e5c5361a5a8d16efbbc3582d55c2ad.jpg'),
(126, '/assets/images/66494a25af5bc2d47b8c70d506e6c028.jpg', '66494a25af5bc2d47b8c70d506e6c028.jpg'),
(127, '/assets/images/eca2ff5d5ed46ef038bd99129d02225d.jpg', 'eca2ff5d5ed46ef038bd99129d02225d.jpg'),
(128, '/assets/images/8edb50134d25f486794c486bdd687b57.jpg', '8edb50134d25f486794c486bdd687b57.jpg'),
(129, '/assets/images/d2252a90e396552f4bf264b758b0c730.jpg', 'd2252a90e396552f4bf264b758b0c730.jpg'),
(130, '/assets/images/8f55b237e6cc4670f31cedf079a7c7d1.jpg', '8f55b237e6cc4670f31cedf079a7c7d1.jpg'),
(131, '/assets/images/1fdc10fcde25721b27a636a876297c82.jpg', '1fdc10fcde25721b27a636a876297c82.jpg'),
(132, '/assets/images/ed1b09b20ab44d2fb61c809ac4e86715.jpg', 'ed1b09b20ab44d2fb61c809ac4e86715.jpg'),
(133, '/assets/images/16f1e72003c82117ef3db98167c35299.jpg', '16f1e72003c82117ef3db98167c35299.jpg'),
(134, '/assets/images/927e4b797fe3a897d5ba46b3af85388d.jpg', '927e4b797fe3a897d5ba46b3af85388d.jpg'),
(135, '/assets/images/bd20cc44243bf25332db12e521de9c46.jpg', 'bd20cc44243bf25332db12e521de9c46.jpg'),
(136, '/assets/images/963cca5be1db671559a259d332f57a0c.jpg', '963cca5be1db671559a259d332f57a0c.jpg'),
(137, '/assets/images/4065a495a009511c12322a9eec5e2686.jpg', '4065a495a009511c12322a9eec5e2686.jpg'),
(138, '/assets/images/3b805f318a7f30e4bb115c0102729aa0.jpg', '3b805f318a7f30e4bb115c0102729aa0.jpg'),
(139, '/assets/images/2c804c0afcf84dab3217a9c7dbc1767d.jpg', '2c804c0afcf84dab3217a9c7dbc1767d.jpg'),
(140, '/assets/images/bae8790a2ce639411b716ba3ba050f7c.jpg', 'bae8790a2ce639411b716ba3ba050f7c.jpg'),
(141, '/assets/images/deb972fda318e70c21a8f36b64c0b734.jpg', 'deb972fda318e70c21a8f36b64c0b734.jpg'),
(142, '/assets/images/929bf174b9b084b9e66ed882c0547cc2.jpg', '929bf174b9b084b9e66ed882c0547cc2.jpg'),
(143, '/assets/images/e1f055bd74a13579c70107b2ba44a856.jpg', 'e1f055bd74a13579c70107b2ba44a856.jpg'),
(144, '/assets/images/b811ce11ea9c6609aeb9999719e59c8e.jpg', 'b811ce11ea9c6609aeb9999719e59c8e.jpg'),
(145, '/assets/images/3c3108b4bb991ea244dc0a33a71e2c02.jpg', '3c3108b4bb991ea244dc0a33a71e2c02.jpg'),
(146, '/assets/images/c738169c92f0e00706c67224c413f9b5.jpg', 'c738169c92f0e00706c67224c413f9b5.jpg'),
(147, '/assets/images/6190d79e2d8bf87dec6b85e1206b5f71.jpg', '6190d79e2d8bf87dec6b85e1206b5f71.jpg'),
(148, '/assets/images/5b11b48afaa5637e96fe054c65090932.jpg', '5b11b48afaa5637e96fe054c65090932.jpg'),
(149, '/assets/images/edc4688bf526ae8b5f4c1a2998d6225c.jpg', 'edc4688bf526ae8b5f4c1a2998d6225c.jpg'),
(150, '/assets/images/8a0f6abab1ae2579b3fda40252548f13.jpg', '8a0f6abab1ae2579b3fda40252548f13.jpg'),
(151, '/assets/images/3012609658d77331a7ee75ff9eb9851e.jpg', '3012609658d77331a7ee75ff9eb9851e.jpg'),
(152, '/assets/images/568530a9b608dda8ad594844dec337f7.jpg', '568530a9b608dda8ad594844dec337f7.jpg'),
(153, '/assets/images/506a0ea6d328a19c7cfe12db3c5d07aa.jpg', '506a0ea6d328a19c7cfe12db3c5d07aa.jpg'),
(154, '/assets/images/83cbfda244d8c985de2127ee1c463637.jpg', '83cbfda244d8c985de2127ee1c463637.jpg'),
(155, '/assets/images/aea025dbe8c12bda4e96f336170bb1d5.jpg', 'aea025dbe8c12bda4e96f336170bb1d5.jpg'),
(156, '/assets/images/b8f919b58f87b0d97e370024969ba9b5.jpg', 'b8f919b58f87b0d97e370024969ba9b5.jpg'),
(157, '/assets/images/c00669102e25db60fa17fb8e34639a2d.jpg', 'c00669102e25db60fa17fb8e34639a2d.jpg'),
(158, '/assets/images/0e0fdda1f2e94133df0dcb607d4ce76f.jpg', '0e0fdda1f2e94133df0dcb607d4ce76f.jpg'),
(159, '/assets/images/be632b5602c7d9361608c9e7e06b46a3.jpg', 'be632b5602c7d9361608c9e7e06b46a3.jpg'),
(160, '/assets/images/1c5b9aba9a120f354a52011d8fa2715c.jpg', '1c5b9aba9a120f354a52011d8fa2715c.jpg'),
(161, '/assets/images/ff87db8859150115bbd3a489ba222029.jpg', 'ff87db8859150115bbd3a489ba222029.jpg'),
(162, '/assets/images/1a30874c7b2309349c204a081e8f4231.jpg', '1a30874c7b2309349c204a081e8f4231.jpg'),
(163, '/assets/images/5033eff6f8a5c092a38e4bba94ee0b9a.jpg', '5033eff6f8a5c092a38e4bba94ee0b9a.jpg'),
(164, '/assets/images/c73bcd62ecca91ad8b2018773ea11437.jpg', 'c73bcd62ecca91ad8b2018773ea11437.jpg'),
(165, '/assets/images/52f5b0a3e427cb97e8a8be157071dcc6.jpg', '52f5b0a3e427cb97e8a8be157071dcc6.jpg'),
(166, '/assets/images/be3c472e7a83759b90cac230c61e1f4b.jpg', 'be3c472e7a83759b90cac230c61e1f4b.jpg'),
(167, '/assets/images/65d90b5fc08c88260f447a8532c36ce1.jpg', '65d90b5fc08c88260f447a8532c36ce1.jpg'),
(168, '/assets/images/1afeff23bf7d59f6fccb76bb23062ebc.jpg', '1afeff23bf7d59f6fccb76bb23062ebc.jpg'),
(169, '/assets/images/c5e19e06688d2bf2170a076ad7854017.jpg', 'c5e19e06688d2bf2170a076ad7854017.jpg'),
(170, '/assets/images/0fd587a616f9fb9dcbdc6b967dbc15fe.jpg', '0fd587a616f9fb9dcbdc6b967dbc15fe.jpg'),
(171, '/assets/images/c5f0c28135e2aac739bc07498bdfa290.jpg', 'c5f0c28135e2aac739bc07498bdfa290.jpg'),
(172, '/assets/images/64893f2e426d5835046cef67614d2809.jpg', '64893f2e426d5835046cef67614d2809.jpg'),
(173, '/assets/images/06a1484c1b1645e4c863e24d9b0c4048.jpg', '06a1484c1b1645e4c863e24d9b0c4048.jpg'),
(174, '/assets/images/cdb18f8c3eb65e48bb151ce6f7d7c9c3.jpg', 'cdb18f8c3eb65e48bb151ce6f7d7c9c3.jpg'),
(175, '/assets/images/b9c1e835a7cdf7be04727b3bfab12f3e.jpg', 'b9c1e835a7cdf7be04727b3bfab12f3e.jpg'),
(176, '/assets/images/f425983cbeaae6f9951dae9636ef1c00.jpg', 'f425983cbeaae6f9951dae9636ef1c00.jpg'),
(177, '/assets/images/71425b675ec9a0110693d548be2df031.jpg', '71425b675ec9a0110693d548be2df031.jpg'),
(178, '/assets/images/2a10e72555a4daf48765b0dad74e2ba8.jpg', '2a10e72555a4daf48765b0dad74e2ba8.jpg'),
(179, '/assets/images/f22634e742254b90c84ec0dd68cbfb0c.jpg', 'f22634e742254b90c84ec0dd68cbfb0c.jpg'),
(180, '/assets/images/2670ef2ad586b531a0032082697c022a.jpg', '2670ef2ad586b531a0032082697c022a.jpg'),
(181, '/assets/images/c8c200dc1eddd3c60b000b2a877fad10.jpg', 'c8c200dc1eddd3c60b000b2a877fad10.jpg'),
(182, '/assets/images/6415bd632a1a98e2177a0016d7f8e490.jpg', '6415bd632a1a98e2177a0016d7f8e490.jpg'),
(183, '/assets/images/7e2f714d8bc325152509d841b6dfb61a.jpg', '7e2f714d8bc325152509d841b6dfb61a.jpg'),
(184, '/assets/images/69f425d7442ad46909014edecc9c5eeb.jpg', '69f425d7442ad46909014edecc9c5eeb.jpg'),
(185, '/assets/images/e8f0ee94b414563f4fe31628bab2cb57.jpg', 'e8f0ee94b414563f4fe31628bab2cb57.jpg'),
(186, '/assets/images/e9517e6883e131caf329f1d3608fcc3c.jpg', 'e9517e6883e131caf329f1d3608fcc3c.jpg'),
(187, '/assets/images/54a615278cb3afce6354ac64b66cfe88.jpg', '54a615278cb3afce6354ac64b66cfe88.jpg'),
(188, '/assets/images/5e14854c39986dcc437865ec0c61e15e.jpg', '5e14854c39986dcc437865ec0c61e15e.jpg'),
(189, '/assets/images/4d183f82802ebcbd8d418ba22ced53af.jpg', '4d183f82802ebcbd8d418ba22ced53af.jpg'),
(190, '/assets/images/e4569e3dff80859fcf7d31d500b924b4.jpg', 'e4569e3dff80859fcf7d31d500b924b4.jpg'),
(191, '/assets/images/15eba16b381c5952ea0444963a6bb975.jpg', '15eba16b381c5952ea0444963a6bb975.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_conversation`
--
ALTER TABLE `tb_conversation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_images`
--
ALTER TABLE `tb_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_messages`
--
ALTER TABLE `tb_messages`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tb_screenshots`
--
ALTER TABLE `tb_screenshots`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_conversation`
--
ALTER TABLE `tb_conversation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_images`
--
ALTER TABLE `tb_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_messages`
--
ALTER TABLE `tb_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `tb_screenshots`
--
ALTER TABLE `tb_screenshots`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
