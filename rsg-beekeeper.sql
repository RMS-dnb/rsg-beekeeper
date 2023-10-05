DROP TABLE IF EXISTS `beekeeper_stock`;
CREATE TABLE IF NOT EXISTS `beekeeper_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beekeeper` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `item` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `beekeeper_shop`;
CREATE TABLE IF NOT EXISTS `beekeeper_shop` (
  `shopid` varchar(255) NOT NULL,
  `jobaccess` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `displayname` varchar(255) NOT NULL,
  `money` double(11,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`shopid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `beekeeper_shop` (`shopid`, `jobaccess`, `displayname`, `money`) VALUES
('valbeekeepershop', 'valbeekeeper', 'Valentine Beekeeper Shop', 0),
('strawbeekeepershop', 'strawbeekeeper', 'Strawberry Beekeeper Shop', 0),
('blackbeekeepershop', 'blackbeekeeper', 'Blackwater Beekeeper Shop', 0),
('mcfarbeekeepershop', 'mcfarbeekeeper', 'Mcfarlanes Beekeeper Shop', 0),
('rhodesbeekeepershop', 'rhodesbeekeeper', 'Rhodes Beekeeper Shop', 0),
('braithbeekeepershop', 'braithbeekeeper', 'Braithwaite Beekeeper Shop', 0);

DROP TABLE IF EXISTS `beekeepershop_stock`;
CREATE TABLE `beekeepershop_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shopid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `items` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `price` double(11,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
