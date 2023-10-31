-- Adminer 4.8.1 MySQL 5.5.5-10.11.5-MariaDB-1:10.11.5+maria~ubu2204 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `application_logs`;
CREATE TABLE `application_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `message` text DEFAULT NULL,
  `priority` enum('emergency','alert','critical','error','warning','notice','info','debug') DEFAULT NULL,
  `fileobject` varchar(1024) DEFAULT NULL,
  `info` varchar(1024) DEFAULT NULL,
  `component` varchar(190) DEFAULT NULL,
  `source` varchar(190) DEFAULT NULL,
  `relatedobject` int(11) unsigned DEFAULT NULL,
  `relatedobjecttype` enum('object','document','asset') DEFAULT NULL,
  `maintenanceChecked` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `component` (`component`),
  KEY `timestamp` (`timestamp`),
  KEY `relatedobject` (`relatedobject`),
  KEY `priority` (`priority`),
  KEY `maintenanceChecked` (`maintenanceChecked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `assets`;
CREATE TABLE `assets` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(11) unsigned DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '',
  `path` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `mimetype` varchar(190) DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT NULL,
  `modificationDate` int(11) unsigned DEFAULT NULL,
  `dataModificationDate` int(11) unsigned DEFAULT NULL,
  `userOwner` int(11) unsigned DEFAULT NULL,
  `userModification` int(11) unsigned DEFAULT NULL,
  `customSettings` longtext DEFAULT NULL,
  `hasMetaData` tinyint(1) NOT NULL DEFAULT 0,
  `versionCount` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fullpath` (`path`,`filename`),
  KEY `parentId` (`parentId`),
  KEY `filename` (`filename`),
  KEY `modificationDate` (`modificationDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

INSERT INTO `assets` (`id`, `parentId`, `type`, `filename`, `path`, `mimetype`, `creationDate`, `modificationDate`, `dataModificationDate`, `userOwner`, `userModification`, `customSettings`, `hasMetaData`, `versionCount`) VALUES
(1,	0,	'folder',	'',	'/',	NULL,	1698762384,	1698762384,	NULL,	1,	1,	NULL,	0,	0),
(2,	1,	'folder',	'Product Import',	'/',	NULL,	1698765538,	1698765538,	NULL,	2,	2,	'a:0:{}',	0,	1),
(3,	2,	'text',	'productImportExample.csv',	'/Product Import/',	'text/csv',	1698765542,	1698765542,	1698765542,	2,	2,	'a:1:{s:8:\"checksum\";s:32:\"65d1a655fbd71907a336f6c99f83abbe\";}',	0,	1);

DROP TABLE IF EXISTS `assets_image_thumbnail_cache`;
CREATE TABLE `assets_image_thumbnail_cache` (
  `cid` int(11) unsigned NOT NULL,
  `name` varchar(190) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `filename` varchar(190) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `modificationDate` int(11) unsigned DEFAULT NULL,
  `filesize` int(11) unsigned DEFAULT NULL,
  `width` smallint(5) unsigned DEFAULT NULL,
  `height` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`cid`,`name`,`filename`),
  CONSTRAINT `FK_assets_image_thumbnail_cache_assets` FOREIGN KEY (`cid`) REFERENCES `assets` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `assets_metadata`;
CREATE TABLE `assets_metadata` (
  `cid` int(11) unsigned NOT NULL,
  `name` varchar(190) NOT NULL,
  `language` varchar(10) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `type` enum('input','textarea','asset','document','object','date','select','checkbox') DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`cid`,`name`,`language`),
  KEY `name` (`name`),
  CONSTRAINT `FK_assets_metadata_assets` FOREIGN KEY (`cid`) REFERENCES `assets` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `bundle_data_hub_data_importer_last_execution`;
CREATE TABLE `bundle_data_hub_data_importer_last_execution` (
  `configName` varchar(80) NOT NULL,
  `lastExecutionDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`configName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `bundle_data_hub_data_importer_queue`;
CREATE TABLE `bundle_data_hub_data_importer_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) DEFAULT NULL,
  `configName` varchar(80) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `executionType` varchar(20) DEFAULT NULL,
  `jobType` varchar(20) DEFAULT NULL,
  `dispatched` bigint(20) DEFAULT NULL,
  `workerId` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bundle_index_queue_configName_index` (`configName`),
  KEY `bundle_index_queue_executiontype_workerId` (`executionType`,`workerId`),
  KEY `bundle_index_queue_configName_index_executionType` (`configName`,`executionType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `cache_items`;
CREATE TABLE `cache_items` (
  `item_id` varbinary(255) NOT NULL,
  `item_data` mediumblob NOT NULL,
  `item_lifetime` int(10) unsigned DEFAULT NULL,
  `item_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `id` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `classes` (`id`, `name`) VALUES
('product',	'Product');

DROP TABLE IF EXISTS `classificationstore_collectionrelations`;
CREATE TABLE `classificationstore_collectionrelations` (
  `colId` int(11) unsigned NOT NULL,
  `groupId` int(11) unsigned NOT NULL,
  `sorter` int(10) DEFAULT 0,
  PRIMARY KEY (`colId`,`groupId`),
  KEY `FK_classificationstore_collectionrelations_groups` (`groupId`),
  CONSTRAINT `FK_classificationstore_collectionrelations_groups` FOREIGN KEY (`groupId`) REFERENCES `classificationstore_groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `classificationstore_collections`;
CREATE TABLE `classificationstore_collections` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `storeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT 0,
  `modificationDate` int(11) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `storeId` (`storeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `classificationstore_groups`;
CREATE TABLE `classificationstore_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `storeId` int(11) DEFAULT NULL,
  `parentId` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(190) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT 0,
  `modificationDate` int(11) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `storeId` (`storeId`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `classificationstore_keys`;
CREATE TABLE `classificationstore_keys` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `storeId` int(11) DEFAULT NULL,
  `name` varchar(190) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `type` varchar(190) DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT 0,
  `modificationDate` int(11) unsigned DEFAULT 0,
  `definition` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`definition`)),
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `enabled` (`enabled`),
  KEY `type` (`type`),
  KEY `storeId` (`storeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `classificationstore_relations`;
CREATE TABLE `classificationstore_relations` (
  `groupId` int(11) unsigned NOT NULL,
  `keyId` int(11) unsigned NOT NULL,
  `sorter` int(11) DEFAULT NULL,
  `mandatory` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`groupId`,`keyId`),
  KEY `FK_classificationstore_relations_classificationstore_keys` (`keyId`),
  KEY `mandatory` (`mandatory`),
  CONSTRAINT `FK_classificationstore_relations_classificationstore_groups` FOREIGN KEY (`groupId`) REFERENCES `classificationstore_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_classificationstore_relations_classificationstore_keys` FOREIGN KEY (`keyId`) REFERENCES `classificationstore_keys` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `classificationstore_stores`;
CREATE TABLE `classificationstore_stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(190) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `dependencies`;
CREATE TABLE `dependencies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sourcetype` enum('document','asset','object') NOT NULL DEFAULT 'document',
  `sourceid` int(11) unsigned NOT NULL DEFAULT 0,
  `targettype` enum('document','asset','object') NOT NULL DEFAULT 'document',
  `targetid` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `combi` (`sourcetype`,`sourceid`,`targettype`,`targetid`),
  KEY `targettype_targetid` (`targettype`,`targetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `documents`;
CREATE TABLE `documents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(11) unsigned DEFAULT NULL,
  `type` enum('page','link','snippet','folder','hardlink','email') DEFAULT NULL,
  `key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '',
  `path` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `index` int(11) unsigned DEFAULT 0,
  `published` tinyint(1) unsigned DEFAULT 1,
  `creationDate` int(11) unsigned DEFAULT NULL,
  `modificationDate` int(11) unsigned DEFAULT NULL,
  `userOwner` int(11) unsigned DEFAULT NULL,
  `userModification` int(11) unsigned DEFAULT NULL,
  `versionCount` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fullpath` (`path`,`key`),
  KEY `parentId` (`parentId`),
  KEY `key` (`key`),
  KEY `published` (`published`),
  KEY `modificationDate` (`modificationDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

INSERT INTO `documents` (`id`, `parentId`, `type`, `key`, `path`, `index`, `published`, `creationDate`, `modificationDate`, `userOwner`, `userModification`, `versionCount`) VALUES
(1,	0,	'page',	'',	'/',	999999,	1,	1698762384,	1698762384,	1,	1,	0);

DROP TABLE IF EXISTS `documents_editables`;
CREATE TABLE `documents_editables` (
  `documentId` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(750) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `type` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`documentId`,`name`),
  CONSTRAINT `fk_documents_editables_documents` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `documents_email`;
CREATE TABLE `documents_email` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `controller` varchar(500) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `replyTo` varchar(255) DEFAULT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `missingRequiredEditable` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_documents_email_documents` FOREIGN KEY (`id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `documents_hardlink`;
CREATE TABLE `documents_hardlink` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `sourceId` int(11) DEFAULT NULL,
  `propertiesFromSource` tinyint(1) DEFAULT NULL,
  `childrenFromSource` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sourceId` (`sourceId`),
  CONSTRAINT `fk_documents_hardlink_documents` FOREIGN KEY (`id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `documents_link`;
CREATE TABLE `documents_link` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `internalType` enum('document','asset','object') DEFAULT NULL,
  `internal` int(11) unsigned DEFAULT NULL,
  `direct` varchar(1000) DEFAULT NULL,
  `linktype` enum('direct','internal') DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_documents_link_documents` FOREIGN KEY (`id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `documents_page`;
CREATE TABLE `documents_page` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `controller` varchar(500) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(383) DEFAULT NULL,
  `prettyUrl` varchar(255) DEFAULT NULL,
  `contentMainDocumentId` int(11) DEFAULT NULL,
  `targetGroupIds` varchar(255) NOT NULL DEFAULT '',
  `missingRequiredEditable` tinyint(1) unsigned DEFAULT NULL,
  `staticGeneratorEnabled` tinyint(1) unsigned DEFAULT NULL,
  `staticGeneratorLifetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prettyUrl` (`prettyUrl`),
  CONSTRAINT `fk_documents_page_documents` FOREIGN KEY (`id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `documents_page` (`id`, `controller`, `template`, `title`, `description`, `prettyUrl`, `contentMainDocumentId`, `targetGroupIds`, `missingRequiredEditable`, `staticGeneratorEnabled`, `staticGeneratorLifetime`) VALUES
(1,	'App\\Controller\\DefaultController::defaultAction',	'',	'',	'',	NULL,	NULL,	'',	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `documents_snippet`;
CREATE TABLE `documents_snippet` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `controller` varchar(500) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `contentMainDocumentId` int(11) DEFAULT NULL,
  `missingRequiredEditable` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_documents_snippet_documents` FOREIGN KEY (`id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `documents_translations`;
CREATE TABLE `documents_translations` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `sourceId` int(11) unsigned NOT NULL DEFAULT 0,
  `language` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`sourceId`,`language`),
  KEY `id` (`id`),
  KEY `language` (`language`),
  CONSTRAINT `fk_documents_translations_documents` FOREIGN KEY (`id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `edit_lock`;
CREATE TABLE `edit_lock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) unsigned NOT NULL DEFAULT 0,
  `ctype` enum('document','asset','object') DEFAULT NULL,
  `userId` int(11) unsigned NOT NULL DEFAULT 0,
  `sessionId` varchar(255) DEFAULT NULL,
  `date` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ctype` (`ctype`),
  KEY `cidtype` (`cid`,`ctype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `element_workflow_state`;
CREATE TABLE `element_workflow_state` (
  `cid` int(10) NOT NULL DEFAULT 0,
  `ctype` enum('document','asset','object') NOT NULL,
  `place` text DEFAULT NULL,
  `workflow` varchar(100) NOT NULL,
  PRIMARY KEY (`cid`,`ctype`,`workflow`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `email_blocklist`;
CREATE TABLE `email_blocklist` (
  `address` varchar(190) NOT NULL DEFAULT '',
  `creationDate` int(11) unsigned DEFAULT NULL,
  `modificationDate` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `email_log`;
CREATE TABLE `email_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentId` int(11) unsigned DEFAULT NULL,
  `requestUri` varchar(500) DEFAULT NULL,
  `params` text DEFAULT NULL,
  `from` varchar(500) DEFAULT NULL,
  `replyTo` varchar(255) DEFAULT NULL,
  `to` longtext DEFAULT NULL,
  `cc` longtext DEFAULT NULL,
  `bcc` longtext DEFAULT NULL,
  `sentDate` int(11) unsigned DEFAULT NULL,
  `subject` varchar(500) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sentDate` (`sentDate`,`id`),
  KEY `document_id` (`documentId`),
  FULLTEXT KEY `fulltext` (`from`,`to`,`cc`,`bcc`,`subject`,`params`),
  CONSTRAINT `fk_email_log_documents` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `gridconfigs`;
CREATE TABLE `gridconfigs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ownerId` int(11) DEFAULT NULL,
  `classId` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `searchType` varchar(50) DEFAULT NULL,
  `type` enum('asset','object') NOT NULL DEFAULT 'object',
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`config`)),
  `description` longtext DEFAULT NULL,
  `creationDate` int(11) DEFAULT NULL,
  `modificationDate` int(11) DEFAULT NULL,
  `shareGlobally` tinyint(1) DEFAULT NULL,
  `setAsFavourite` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ownerId` (`ownerId`),
  KEY `classId` (`classId`),
  KEY `searchType` (`searchType`),
  KEY `shareGlobally` (`shareGlobally`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `gridconfig_favourites`;
CREATE TABLE `gridconfig_favourites` (
  `ownerId` int(11) NOT NULL,
  `classId` varchar(50) NOT NULL,
  `objectId` int(11) NOT NULL DEFAULT 0,
  `gridConfigId` int(11) NOT NULL,
  `searchType` varchar(50) NOT NULL DEFAULT '',
  `type` enum('asset','object') NOT NULL DEFAULT 'object',
  PRIMARY KEY (`ownerId`,`classId`,`searchType`,`objectId`),
  KEY `classId` (`classId`),
  KEY `searchType` (`searchType`),
  KEY `grid_config_id` (`gridConfigId`),
  CONSTRAINT `fk_gridconfig_favourites_gridconfigs` FOREIGN KEY (`gridConfigId`) REFERENCES `gridconfigs` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `gridconfig_shares`;
CREATE TABLE `gridconfig_shares` (
  `gridConfigId` int(11) NOT NULL,
  `sharedWithUserId` int(11) NOT NULL,
  PRIMARY KEY (`gridConfigId`,`sharedWithUserId`),
  KEY `sharedWithUserId` (`sharedWithUserId`),
  KEY `grid_config_id` (`gridConfigId`),
  CONSTRAINT `fk_gridconfig_shares_gridconfigs` FOREIGN KEY (`gridConfigId`) REFERENCES `gridconfigs` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `importconfigs`;
CREATE TABLE `importconfigs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ownerId` int(11) DEFAULT NULL,
  `classId` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`config`)),
  `description` longtext DEFAULT NULL,
  `creationDate` int(11) DEFAULT NULL,
  `modificationDate` int(11) DEFAULT NULL,
  `shareGlobally` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ownerId` (`ownerId`),
  KEY `classId` (`classId`),
  KEY `shareGlobally` (`shareGlobally`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `importconfig_shares`;
CREATE TABLE `importconfig_shares` (
  `importConfigId` int(11) NOT NULL,
  `sharedWithUserId` int(11) NOT NULL,
  PRIMARY KEY (`importConfigId`,`sharedWithUserId`),
  KEY `sharedWithUserId` (`sharedWithUserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `lock_keys`;
CREATE TABLE `lock_keys` (
  `key_id` varchar(64) NOT NULL,
  `key_token` varchar(44) NOT NULL,
  `key_expiration` int(10) unsigned NOT NULL,
  PRIMARY KEY (`key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `migration_versions`;
CREATE TABLE `migration_versions` (
  `version` varchar(1024) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

INSERT INTO `migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201007000000',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201008082752',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201008091131',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201008101817',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201008132324',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201009095924',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201012154224',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201014101437',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201113143914',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20201201084201',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210107103923',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210218142556',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210323082921',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210323110055',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210324152821',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210324152822',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210330132354',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210408153226',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210412112812',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210428145320',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210505093841',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210531125102',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210608094532',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210616114744',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210624085031',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210630062445',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210702102100',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210706090823',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210901130000',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20210928135248',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20211016084043',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20211018104331',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20211028134037',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20211028155535',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20211103055110',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20211117173000',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20211209131141',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20211221152344',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220119082511',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220120121803',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220120162621',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220201132131',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220214110000',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220317125711',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220318101020',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220402104849',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220411172543',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220419120333',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220425082914',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220502104200',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220506103100',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220511085800',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220614115124',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220617145524',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220718162200',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220725154615',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220809154926',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220809164000',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220816120101',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220829132224',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220830105212',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220906111031',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20220908113752',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221003115124',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221005090000',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221019042134',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221020195451',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221025165133',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221028115803',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221107084519',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221116115427',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221129084031',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221215071650',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221216140012',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221220152444',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221222134837',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221222181745',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20221228101109',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230107224432',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230110130748',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230111074323',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230113165612',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230120111111',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230124120641',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230125164101',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230202152342',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230221073317',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230222075502',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230222174636',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230223101848',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230320110429',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230320131322',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230321133700',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230322114936',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230405162853',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230406113010',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230412105530',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230424084415',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230428112302',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230508121105',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230516161000',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230517115427',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230525131748',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230606112233',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230616085142',	NULL,	NULL),
('Pimcore\\Bundle\\CoreBundle\\Migrations\\Version20230913173812',	NULL,	NULL),
('Pimcore\\Bundle\\DataHubBundle\\Migrations\\PimcoreX\\Version20210305134111',	NULL,	NULL),
('Pimcore\\Bundle\\DataHubBundle\\Migrations\\PimcoreX\\Version20211108160248',	NULL,	NULL),
('Pimcore\\Bundle\\DataHubBundle\\Migrations\\PimcoreX\\Version20221212152145',	NULL,	NULL),
('Pimcore\\Bundle\\DataHubBundle\\Migrations\\PimcoreX\\Version20230329133119',	NULL,	NULL),
('Pimcore\\Bundle\\DataHubBundle\\Migrations\\PimcoreX\\Version20230503165847',	NULL,	NULL),
('Pimcore\\Bundle\\DataImporterBundle\\Migrations\\Version20210305134111',	NULL,	NULL),
('Pimcore\\Bundle\\DataImporterBundle\\Migrations\\Version20211110174732',	NULL,	NULL),
('Pimcore\\Bundle\\DataImporterBundle\\Migrations\\Version20211201173215',	NULL,	NULL),
('Pimcore\\Bundle\\DataImporterBundle\\Migrations\\Version20220304130000',	NULL,	NULL);

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `ctype` enum('asset','document','object') DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `locked` tinyint(1) unsigned DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `cid_ctype` (`cid`,`ctype`),
  KEY `date` (`date`),
  KEY `user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `notes_data`;
CREATE TABLE `notes_data` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('text','date','document','asset','object','bool') DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `UNIQ_E5A8E5E2BF3967505E237E06` (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL DEFAULT 'info',
  `title` varchar(250) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `sender` int(11) DEFAULT NULL,
  `recipient` int(11) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `creationDate` timestamp NULL DEFAULT current_timestamp(),
  `modificationDate` timestamp NULL DEFAULT NULL,
  `linkedElementType` enum('document','asset','object') DEFAULT NULL,
  `linkedElement` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recipient` (`recipient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `objects`;
CREATE TABLE `objects` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(11) unsigned DEFAULT NULL,
  `type` enum('object','folder','variant') DEFAULT NULL,
  `key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '',
  `path` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `index` int(11) unsigned DEFAULT 0,
  `published` tinyint(1) unsigned DEFAULT 1,
  `creationDate` int(11) unsigned DEFAULT NULL,
  `modificationDate` int(11) unsigned DEFAULT NULL,
  `userOwner` int(11) unsigned DEFAULT NULL,
  `userModification` int(11) unsigned DEFAULT NULL,
  `classId` varchar(50) DEFAULT NULL,
  `className` varchar(255) DEFAULT NULL,
  `childrenSortBy` enum('key','index') DEFAULT NULL,
  `childrenSortOrder` enum('ASC','DESC') DEFAULT NULL,
  `versionCount` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fullpath` (`path`,`key`),
  KEY `key` (`key`),
  KEY `index` (`index`),
  KEY `published` (`published`),
  KEY `parentId` (`parentId`),
  KEY `type_path_classId` (`type`,`path`,`classId`),
  KEY `modificationDate` (`modificationDate`),
  KEY `classId` (`classId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

INSERT INTO `objects` (`id`, `parentId`, `type`, `key`, `path`, `index`, `published`, `creationDate`, `modificationDate`, `userOwner`, `userModification`, `classId`, `className`, `childrenSortBy`, `childrenSortOrder`, `versionCount`) VALUES
(1,	0,	'folder',	'',	'/',	999999,	1,	1698762384,	1698762384,	1,	1,	NULL,	NULL,	NULL,	NULL,	0),
(2,	1,	'folder',	'Products',	'/',	0,	1,	1698765737,	1698765737,	1,	0,	NULL,	NULL,	NULL,	NULL,	1),
(3,	2,	'object',	'TST0001',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(4,	2,	'object',	'TST0002',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(5,	2,	'object',	'TST0003',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(6,	2,	'object',	'TST0004',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(7,	2,	'object',	'TST0005',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(8,	2,	'object',	'TST0006',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(9,	2,	'object',	'TST0007',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(10,	2,	'object',	'TST0008',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(11,	2,	'object',	'TST0009',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2),
(12,	2,	'object',	'TST0010',	'/Products/',	0,	1,	1698765737,	1698765810,	0,	0,	'product',	'Product',	NULL,	NULL,	2);

DROP VIEW IF EXISTS `object_product`;
CREATE TABLE `object_product` (`oo_id` int(11) unsigned, `oo_classId` varchar(50), `oo_className` varchar(255), `sku` varchar(190), `title` longtext, `id` int(11) unsigned, `parentId` int(11) unsigned, `type` enum('object','folder','variant'), `key` varchar(255), `path` varchar(765), `index` int(11) unsigned, `published` tinyint(1) unsigned, `creationDate` int(11) unsigned, `modificationDate` int(11) unsigned, `userOwner` int(11) unsigned, `userModification` int(11) unsigned, `classId` varchar(50), `className` varchar(255), `childrenSortBy` enum('key','index'), `childrenSortOrder` enum('ASC','DESC'), `versionCount` int(10) unsigned);


DROP TABLE IF EXISTS `object_query_product`;
CREATE TABLE `object_query_product` (
  `oo_id` int(11) unsigned NOT NULL DEFAULT 0,
  `oo_classId` varchar(50) DEFAULT 'product',
  `oo_className` varchar(255) DEFAULT 'Product',
  `sku` varchar(190) DEFAULT NULL,
  `title` longtext DEFAULT NULL,
  PRIMARY KEY (`oo_id`),
  CONSTRAINT `fk_object_query_product__oo_id` FOREIGN KEY (`oo_id`) REFERENCES `objects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `object_query_product` (`oo_id`, `oo_classId`, `oo_className`, `sku`, `title`) VALUES
(3,	'product',	'Product',	'TST0001',	'Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit.'),
(4,	'product',	'Product',	'TST0002',	'Sed Maximus Risus Vel Purus Tincidunt, Quis Faucibus Libero Interdum.'),
(5,	'product',	'Product',	'TST0003',	'Sed Id Orci Efficitur, Egestas Dui Eu, Consectetur Elit.'),
(6,	'product',	'Product',	'TST0004',	'Morbi Eu Tortor Sit Amet Nisl Ultrices Ullamcorper Nec Nec Risus.'),
(7,	'product',	'Product',	'TST0005',	'Vivamus A Lorem Congue, Scelerisque Enim Ac, Vestibulum Augue.'),
(8,	'product',	'Product',	'TST0006',	'Quisque Sollicitudin Neque Eget Urna Placerat Posuere.'),
(9,	'product',	'Product',	'TST0007',	'Maecenas Et Leo Quis Arcu Porttitor Pulvinar Ut Eget Sem.'),
(10,	'product',	'Product',	'TST0008',	'Cras Eu Orci Ac Purus Venenatis Sollicitudin.'),
(11,	'product',	'Product',	'TST0009',	'Nullam A Tellus Dictum, Consectetur Nibh Non, Aliquam Dolor.'),
(12,	'product',	'Product',	'TST0010',	'Ut Dignissim Metus Eleifend, Vehicula Lorem Vitae, Elementum Sem.');

DROP TABLE IF EXISTS `object_relations_product`;
CREATE TABLE `object_relations_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `src_id` int(11) unsigned NOT NULL DEFAULT 0,
  `dest_id` int(11) unsigned NOT NULL DEFAULT 0,
  `type` enum('object','asset','document') NOT NULL,
  `fieldname` varchar(70) NOT NULL DEFAULT '0',
  `index` int(11) unsigned NOT NULL DEFAULT 0,
  `ownertype` enum('object','fieldcollection','localizedfield','objectbrick') NOT NULL DEFAULT 'object',
  `ownername` varchar(70) NOT NULL DEFAULT '',
  `position` varchar(70) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `forward_lookup` (`src_id`,`ownertype`,`ownername`,`position`),
  KEY `reverse_lookup` (`dest_id`,`type`),
  KEY `fieldname` (`fieldname`),
  CONSTRAINT `fk_object_relations_product__src_id` FOREIGN KEY (`src_id`) REFERENCES `objects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `object_store_product`;
CREATE TABLE `object_store_product` (
  `oo_id` int(11) unsigned NOT NULL DEFAULT 0,
  `sku` varchar(190) DEFAULT NULL,
  `title` longtext DEFAULT NULL,
  PRIMARY KEY (`oo_id`),
  CONSTRAINT `fk_object_store_product__oo_id` FOREIGN KEY (`oo_id`) REFERENCES `objects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `object_store_product` (`oo_id`, `sku`, `title`) VALUES
(3,	'TST0001',	'Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit.'),
(4,	'TST0002',	'Sed Maximus Risus Vel Purus Tincidunt, Quis Faucibus Libero Interdum.'),
(5,	'TST0003',	'Sed Id Orci Efficitur, Egestas Dui Eu, Consectetur Elit.'),
(6,	'TST0004',	'Morbi Eu Tortor Sit Amet Nisl Ultrices Ullamcorper Nec Nec Risus.'),
(7,	'TST0005',	'Vivamus A Lorem Congue, Scelerisque Enim Ac, Vestibulum Augue.'),
(8,	'TST0006',	'Quisque Sollicitudin Neque Eget Urna Placerat Posuere.'),
(9,	'TST0007',	'Maecenas Et Leo Quis Arcu Porttitor Pulvinar Ut Eget Sem.'),
(10,	'TST0008',	'Cras Eu Orci Ac Purus Venenatis Sollicitudin.'),
(11,	'TST0009',	'Nullam A Tellus Dictum, Consectetur Nibh Non, Aliquam Dolor.'),
(12,	'TST0010',	'Ut Dignissim Metus Eleifend, Vehicula Lorem Vitae, Elementum Sem.');

DROP TABLE IF EXISTS `object_url_slugs`;
CREATE TABLE `object_url_slugs` (
  `objectId` int(11) unsigned NOT NULL DEFAULT 0,
  `classId` varchar(50) NOT NULL DEFAULT '0',
  `fieldname` varchar(70) NOT NULL DEFAULT '0',
  `ownertype` enum('object','fieldcollection','localizedfield','objectbrick') NOT NULL DEFAULT 'object',
  `ownername` varchar(70) NOT NULL DEFAULT '',
  `position` varchar(70) NOT NULL DEFAULT '0',
  `slug` varchar(765) NOT NULL,
  `siteId` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`slug`,`siteId`),
  KEY `objectId` (`objectId`),
  KEY `classId` (`classId`),
  KEY `fieldname` (`fieldname`),
  KEY `position` (`position`),
  KEY `ownertype` (`ownertype`),
  KEY `ownername` (`ownername`),
  KEY `slug` (`slug`),
  KEY `siteId` (`siteId`),
  KEY `fieldname_ownertype_position_objectId` (`fieldname`,`ownertype`,`position`,`objectId`),
  CONSTRAINT `fk_object_url_slugs__objectId` FOREIGN KEY (`objectId`) REFERENCES `objects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `plugin_datahub_workspaces_asset`;
CREATE TABLE `plugin_datahub_workspaces_asset` (
  `cid` int(11) unsigned NOT NULL DEFAULT 0,
  `cpath` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `configuration` varchar(80) NOT NULL DEFAULT '0',
  `create` tinyint(1) unsigned DEFAULT 0,
  `read` tinyint(1) unsigned DEFAULT 0,
  `update` tinyint(1) unsigned DEFAULT 0,
  `delete` tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`cid`,`configuration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `plugin_datahub_workspaces_document`;
CREATE TABLE `plugin_datahub_workspaces_document` (
  `cid` int(11) unsigned NOT NULL DEFAULT 0,
  `cpath` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `configuration` varchar(80) NOT NULL DEFAULT '0',
  `create` tinyint(1) unsigned DEFAULT 0,
  `read` tinyint(1) unsigned DEFAULT 0,
  `update` tinyint(1) unsigned DEFAULT 0,
  `delete` tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`cid`,`configuration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `plugin_datahub_workspaces_object`;
CREATE TABLE `plugin_datahub_workspaces_object` (
  `cid` int(11) unsigned NOT NULL DEFAULT 0,
  `cpath` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `configuration` varchar(80) NOT NULL DEFAULT '0',
  `create` tinyint(1) unsigned DEFAULT 0,
  `read` tinyint(1) unsigned DEFAULT 0,
  `update` tinyint(1) unsigned DEFAULT 0,
  `delete` tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`cid`,`configuration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties` (
  `cid` int(11) unsigned NOT NULL DEFAULT 0,
  `ctype` enum('document','asset','object') NOT NULL DEFAULT 'document',
  `cpath` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `name` varchar(190) NOT NULL DEFAULT '',
  `type` enum('text','document','asset','object','bool','select') DEFAULT NULL,
  `data` text DEFAULT NULL,
  `inheritable` tinyint(1) unsigned DEFAULT 1,
  PRIMARY KEY (`cid`,`ctype`,`name`),
  KEY `getall` (`cpath`,`ctype`,`inheritable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `quantityvalue_units`;
CREATE TABLE `quantityvalue_units` (
  `id` varchar(50) NOT NULL,
  `group` varchar(50) DEFAULT NULL,
  `abbreviation` varchar(20) DEFAULT NULL,
  `longname` varchar(250) DEFAULT NULL,
  `baseunit` varchar(50) DEFAULT NULL,
  `factor` double DEFAULT NULL,
  `conversionOffset` double DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `converter` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_baseunit` (`baseunit`),
  CONSTRAINT `fk_baseunit` FOREIGN KEY (`baseunit`) REFERENCES `quantityvalue_units` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `recyclebin`;
CREATE TABLE `recyclebin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  `subtype` varchar(20) DEFAULT NULL,
  `path` varchar(765) DEFAULT NULL,
  `amount` int(3) DEFAULT NULL,
  `date` int(11) unsigned DEFAULT NULL,
  `deletedby` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recyclebin_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `schedule_tasks`;
CREATE TABLE `schedule_tasks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(11) unsigned DEFAULT NULL,
  `ctype` enum('document','asset','object') DEFAULT NULL,
  `date` int(11) unsigned DEFAULT NULL,
  `action` enum('publish','unpublish','delete','publish-version') DEFAULT NULL,
  `version` bigint(20) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT 0,
  `userId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `ctype` (`ctype`),
  KEY `active` (`active`),
  KEY `version` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `search_backend_data`;
CREATE TABLE `search_backend_data` (
  `id` int(11) NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '',
  `index` int(11) unsigned DEFAULT 0,
  `fullpath` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `maintype` varchar(8) NOT NULL DEFAULT '',
  `type` varchar(20) DEFAULT NULL,
  `subtype` varchar(190) DEFAULT NULL,
  `published` tinyint(1) unsigned DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT NULL,
  `modificationDate` int(11) unsigned DEFAULT NULL,
  `userOwner` int(11) DEFAULT NULL,
  `userModification` int(11) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `properties` text DEFAULT NULL,
  PRIMARY KEY (`id`,`maintype`),
  KEY `key` (`key`),
  KEY `index` (`index`),
  KEY `fullpath` (`fullpath`),
  KEY `maintype` (`maintype`),
  KEY `type` (`type`),
  KEY `subtype` (`subtype`),
  KEY `published` (`published`),
  FULLTEXT KEY `fulltext` (`data`,`properties`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `settings_store`;
CREATE TABLE `settings_store` (
  `id` varchar(190) NOT NULL DEFAULT '',
  `scope` varchar(190) NOT NULL DEFAULT '',
  `data` longtext DEFAULT NULL,
  `type` enum('bool','int','float','string') NOT NULL DEFAULT 'string',
  PRIMARY KEY (`id`,`scope`),
  KEY `scope` (`scope`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `settings_store` (`id`, `scope`, `data`, `type`) VALUES
('BUNDLE_INSTALLED__Pimcore\\Bundle\\ApplicationLoggerBundle\\PimcoreApplicationLoggerBundle',	'pimcore',	'1',	'bool'),
('BUNDLE_INSTALLED__Pimcore\\Bundle\\DataHubBundle\\PimcoreDataHubBundle',	'pimcore',	'1',	'bool'),
('BUNDLE_INSTALLED__Pimcore\\Bundle\\DataImporterBundle\\PimcoreDataImporterBundle',	'pimcore',	'1',	'bool');

DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mainDomain` varchar(255) DEFAULT NULL,
  `domains` text DEFAULT NULL,
  `rootId` int(11) unsigned DEFAULT NULL,
  `errorDocument` varchar(255) DEFAULT NULL,
  `localizedErrorDocuments` text DEFAULT NULL,
  `redirectToMainDomain` tinyint(1) DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT 0,
  `modificationDate` int(11) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rootId` (`rootId`),
  CONSTRAINT `fk_sites_documents` FOREIGN KEY (`rootId`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(10) unsigned DEFAULT NULL,
  `idPath` varchar(190) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idPath_name` (`idPath`,`name`),
  KEY `idpath` (`idPath`),
  KEY `parentid` (`parentId`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `tags_assignment`;
CREATE TABLE `tags_assignment` (
  `tagid` int(10) unsigned NOT NULL DEFAULT 0,
  `cid` int(10) NOT NULL DEFAULT 0,
  `ctype` enum('document','asset','object') NOT NULL,
  PRIMARY KEY (`tagid`,`cid`,`ctype`),
  KEY `ctype` (`ctype`),
  KEY `ctype_cid` (`cid`,`ctype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `tmp_store`;
CREATE TABLE `tmp_store` (
  `id` varchar(190) NOT NULL DEFAULT '',
  `tag` varchar(190) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `serialized` tinyint(2) NOT NULL DEFAULT 0,
  `date` int(11) unsigned DEFAULT NULL,
  `expiryDate` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tag` (`tag`),
  KEY `date` (`date`),
  KEY `expiryDate` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tmp_store` (`id`, `tag`, `data`, `serialized`, `date`, `expiryDate`) VALUES
('datahub_dataimporter_productImport',	NULL,	'10',	0,	1698765804,	1699370604),
('log-dev.log',	NULL,	'1698765966',	0,	1698765966,	1699370766),
('log-php.log',	NULL,	'1698765966',	0,	1698765966,	1699370766),
('log-usage.log',	NULL,	'1698765966',	0,	1698765966,	1699370766),
('maintenance.pid',	NULL,	'1698765966',	0,	1698765966,	1699370766);

DROP TABLE IF EXISTS `translations_admin`;
CREATE TABLE `translations_admin` (
  `key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `type` varchar(10) DEFAULT NULL,
  `language` varchar(10) NOT NULL DEFAULT '',
  `text` text DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT NULL,
  `modificationDate` int(11) unsigned DEFAULT NULL,
  `userOwner` int(11) unsigned DEFAULT NULL,
  `userModification` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`key`,`language`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `translations_admin` (`key`, `type`, `language`, `text`, `creationDate`, `modificationDate`, `userOwner`, `userModification`) VALUES
('English',	'simple',	'ca',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'cs',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'de',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'en',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'es',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'fr',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'hu',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'it',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'ja',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'nl',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'pl',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'pt',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'ru',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'sk',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'sv',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'th',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'tr',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'uk',	'',	1698765831,	1698765831,	2,	2),
('English',	'simple',	'zh_Hans',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'ca',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'cs',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'de',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'en',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'es',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'fr',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'hu',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'it',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'ja',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'nl',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'pl',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'pt',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'ru',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'sk',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'sv',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'th',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'tr',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'uk',	'',	1698765831,	1698765831,	2,	2),
('French',	'simple',	'zh_Hans',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'ca',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'cs',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'de',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'en',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'es',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'fr',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'hu',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'it',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'ja',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'nl',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'pl',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'pt',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'ru',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'sk',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'sv',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'th',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'tr',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'uk',	'',	1698765831,	1698765831,	2,	2),
('German',	'simple',	'zh_Hans',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'ca',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'cs',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'de',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'en',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'es',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'fr',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'hu',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'it',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'ja',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'nl',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'pl',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'pt',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'ru',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'sk',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'sv',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'th',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'tr',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'uk',	'',	1698765831,	1698765831,	2,	2),
('Main',	'simple',	'zh_Hans',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'ca',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'cs',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'de',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'en',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'es',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'fr',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'hu',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'it',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'ja',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'nl',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'pl',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'pt',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'ru',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'sk',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'sv',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'th',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'tr',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'uk',	'',	1698765831,	1698765831,	2,	2),
('Main (Admin Mode)',	'simple',	'zh_Hans',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'ca',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'cs',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'de',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'en',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'es',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'fr',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'hu',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'it',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'ja',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'nl',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'pl',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'pt',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'ru',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'sk',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'sv',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'th',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'tr',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'uk',	'',	1698765831,	1698765831,	2,	2),
('Main Information',	'simple',	'zh_Hans',	'',	1698765831,	1698765831,	2,	2),
('Product',	'simple',	'ca',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'cs',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'de',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'en',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'es',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'fr',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'hu',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'it',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'ja',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'nl',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'pl',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'pt',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'ru',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'sk',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'sv',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'th',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'tr',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'uk',	'Product',	1698765028,	1698765028,	2,	2),
('Product',	'simple',	'zh_Hans',	'Product',	1698765028,	1698765028,	2,	2),
('Product Data',	'simple',	'ca',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'cs',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'de',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'en',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'es',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'fr',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'hu',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'it',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'ja',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'nl',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'pl',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'pt',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'ru',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'sk',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'sv',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'th',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'tr',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'uk',	'',	1698765831,	1698765831,	2,	2),
('Product Data',	'simple',	'zh_Hans',	'',	1698765831,	1698765831,	2,	2),
('Sku',	'simple',	'ca',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'cs',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'de',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'en',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'es',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'fr',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'hu',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'it',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'ja',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'nl',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'pl',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'pt',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'ru',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'sk',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'sv',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'th',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'tr',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'uk',	'',	1698765832,	1698765832,	2,	2),
('Sku',	'simple',	'zh_Hans',	'',	1698765832,	1698765832,	2,	2),
('bottom',	'simple',	'ca',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'cs',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'de',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'en',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'es',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'fr',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'hu',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'it',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'ja',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'nl',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'pl',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'pt',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'ru',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'sk',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'sv',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'th',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'tr',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'uk',	'',	1698765321,	1698765321,	2,	2),
('bottom',	'simple',	'zh_Hans',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'ca',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'cs',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'de',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'en',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'es',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'fr',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'hu',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'it',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'ja',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'nl',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'pl',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'pt',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'ru',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'sk',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'sv',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'th',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'tr',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'uk',	'',	1698765321,	1698765321,	2,	2),
('global',	'simple',	'zh_Hans',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'ca',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'cs',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'de',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'en',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'es',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'fr',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'hu',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'it',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'ja',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'nl',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'pl',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'pt',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'ru',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'sk',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'sv',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'th',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'tr',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'uk',	'',	1698765321,	1698765321,	2,	2),
('ignoreCase',	'simple',	'zh_Hans',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'ca',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'cs',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'de',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'en',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'es',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'fr',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'hu',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'it',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'ja',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'nl',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'pl',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'pt',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'ru',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'sk',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'sv',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'th',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'tr',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'uk',	'',	1698765321,	1698765321,	2,	2),
('multiline',	'simple',	'zh_Hans',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'ca',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'cs',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'de',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'en',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'es',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'fr',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'hu',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'it',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'ja',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'nl',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'pl',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'pt',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'ru',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'sk',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'sv',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'th',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'tr',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'uk',	'',	1698765321,	1698765321,	2,	2),
('sticky',	'simple',	'zh_Hans',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'ca',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'cs',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'de',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'en',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'es',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'fr',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'hu',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'it',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'ja',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'nl',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'pl',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'pt',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'ru',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'sk',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'sv',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'th',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'tr',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'uk',	'',	1698765321,	1698765321,	2,	2),
('unicode',	'simple',	'zh_Hans',	'',	1698765321,	1698765321,	2,	2);

DROP TABLE IF EXISTS `translations_messages`;
CREATE TABLE `translations_messages` (
  `key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `type` varchar(10) DEFAULT NULL,
  `language` varchar(10) NOT NULL DEFAULT '',
  `text` text DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT NULL,
  `modificationDate` int(11) unsigned DEFAULT NULL,
  `userOwner` int(11) unsigned DEFAULT NULL,
  `userModification` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`key`,`language`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `tree_locks`;
CREATE TABLE `tree_locks` (
  `id` int(11) NOT NULL DEFAULT 0,
  `type` enum('asset','document','object') NOT NULL DEFAULT 'asset',
  `locked` enum('self','propagate') DEFAULT NULL,
  PRIMARY KEY (`id`,`type`),
  KEY `type` (`type`),
  KEY `locked` (`locked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(11) unsigned DEFAULT NULL,
  `type` enum('user','userfolder','role','rolefolder') NOT NULL DEFAULT 'user',
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(190) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `language` varchar(10) DEFAULT NULL,
  `contentLanguages` longtext DEFAULT NULL,
  `admin` tinyint(1) unsigned DEFAULT 0,
  `active` tinyint(1) unsigned DEFAULT 1,
  `permissions` text DEFAULT NULL,
  `roles` varchar(1000) DEFAULT NULL,
  `welcomescreen` tinyint(1) DEFAULT NULL,
  `closeWarning` tinyint(1) DEFAULT NULL,
  `memorizeTabs` tinyint(1) DEFAULT NULL,
  `allowDirtyClose` tinyint(1) unsigned DEFAULT 1,
  `docTypes` text DEFAULT NULL,
  `classes` text DEFAULT NULL,
  `twoFactorAuthentication` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `activePerspective` varchar(255) DEFAULT NULL,
  `perspectives` longtext DEFAULT NULL,
  `websiteTranslationLanguagesEdit` longtext DEFAULT NULL,
  `websiteTranslationLanguagesView` longtext DEFAULT NULL,
  `lastLogin` int(11) unsigned DEFAULT NULL,
  `keyBindings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`keyBindings`)),
  `passwordRecoveryToken` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_name` (`type`,`name`),
  KEY `parentId` (`parentId`),
  KEY `name` (`name`),
  KEY `password` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`id`, `parentId`, `type`, `name`, `password`, `firstname`, `lastname`, `email`, `language`, `contentLanguages`, `admin`, `active`, `permissions`, `roles`, `welcomescreen`, `closeWarning`, `memorizeTabs`, `allowDirtyClose`, `docTypes`, `classes`, `twoFactorAuthentication`, `provider`, `activePerspective`, `perspectives`, `websiteTranslationLanguagesEdit`, `websiteTranslationLanguagesView`, `lastLogin`, `keyBindings`, `passwordRecoveryToken`) VALUES
(0,	0,	'user',	'system',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	0,	'user',	'pimcore',	'$2y$10$RkokU5Ua8Q8I3Al63bmUZeqvjooW2axh4QP4sotaKUK3uzMJVucAi',	NULL,	NULL,	NULL,	'en',	'',	1,	1,	'',	'',	0,	1,	1,	0,	'',	'',	'null',	NULL,	NULL,	'',	'',	'',	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `users_permission_definitions`;
CREATE TABLE `users_permission_definitions` (
  `key` varchar(50) NOT NULL DEFAULT '',
  `category` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users_permission_definitions` (`key`, `category`) VALUES
('application_logging',	'Pimcore Application Logger Bundle'),
('assets',	''),
('asset_metadata',	''),
('classes',	''),
('classificationstore',	''),
('clear_cache',	''),
('clear_fullpage_cache',	''),
('clear_temp_files',	''),
('dashboards',	''),
('documents',	''),
('document_types',	''),
('emails',	''),
('fieldcollections',	''),
('notes_events',	''),
('notifications',	''),
('notifications_send',	''),
('objectbricks',	''),
('objects',	''),
('objects_sort_method',	''),
('plugin_datahub_adapter_dataImporterDataObject',	'Datahub'),
('plugin_datahub_adapter_graphql',	'Datahub'),
('plugin_datahub_admin',	'Datahub'),
('plugin_datahub_config',	'Datahub'),
('predefined_properties',	''),
('quantityValueUnits',	''),
('recyclebin',	''),
('redirects',	''),
('seemode',	''),
('selectoptions',	''),
('share_configurations',	''),
('sites',	''),
('system_settings',	''),
('tags_assignment',	''),
('tags_configuration',	''),
('tags_search',	''),
('thumbnails',	''),
('translations',	''),
('users',	''),
('website_settings',	''),
('workflow_details',	'');

DROP TABLE IF EXISTS `users_workspaces_asset`;
CREATE TABLE `users_workspaces_asset` (
  `cid` int(11) unsigned NOT NULL DEFAULT 0,
  `cpath` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `userId` int(11) unsigned NOT NULL DEFAULT 0,
  `list` tinyint(1) DEFAULT 0,
  `view` tinyint(1) DEFAULT 0,
  `publish` tinyint(1) DEFAULT 0,
  `delete` tinyint(1) DEFAULT 0,
  `rename` tinyint(1) DEFAULT 0,
  `create` tinyint(1) DEFAULT 0,
  `settings` tinyint(1) DEFAULT 0,
  `versions` tinyint(1) DEFAULT 0,
  `properties` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`cid`,`userId`),
  UNIQUE KEY `cpath_userId` (`cpath`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `fk_users_workspaces_asset_assets` FOREIGN KEY (`cid`) REFERENCES `assets` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_workspaces_asset_users` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `users_workspaces_document`;
CREATE TABLE `users_workspaces_document` (
  `cid` int(11) unsigned NOT NULL DEFAULT 0,
  `cpath` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `userId` int(11) unsigned NOT NULL DEFAULT 0,
  `list` tinyint(1) unsigned DEFAULT 0,
  `view` tinyint(1) unsigned DEFAULT 0,
  `save` tinyint(1) unsigned DEFAULT 0,
  `publish` tinyint(1) unsigned DEFAULT 0,
  `unpublish` tinyint(1) unsigned DEFAULT 0,
  `delete` tinyint(1) unsigned DEFAULT 0,
  `rename` tinyint(1) unsigned DEFAULT 0,
  `create` tinyint(1) unsigned DEFAULT 0,
  `settings` tinyint(1) unsigned DEFAULT 0,
  `versions` tinyint(1) unsigned DEFAULT 0,
  `properties` tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`cid`,`userId`),
  UNIQUE KEY `cpath_userId` (`cpath`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `fk_users_workspaces_document_documents` FOREIGN KEY (`cid`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_workspaces_document_users` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `users_workspaces_object`;
CREATE TABLE `users_workspaces_object` (
  `cid` int(11) unsigned NOT NULL DEFAULT 0,
  `cpath` varchar(765) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `userId` int(11) unsigned NOT NULL DEFAULT 0,
  `list` tinyint(1) unsigned DEFAULT 0,
  `view` tinyint(1) unsigned DEFAULT 0,
  `save` tinyint(1) unsigned DEFAULT 0,
  `publish` tinyint(1) unsigned DEFAULT 0,
  `unpublish` tinyint(1) unsigned DEFAULT 0,
  `delete` tinyint(1) unsigned DEFAULT 0,
  `rename` tinyint(1) unsigned DEFAULT 0,
  `create` tinyint(1) unsigned DEFAULT 0,
  `settings` tinyint(1) unsigned DEFAULT 0,
  `versions` tinyint(1) unsigned DEFAULT 0,
  `properties` tinyint(1) unsigned DEFAULT 0,
  `lEdit` text DEFAULT NULL,
  `lView` text DEFAULT NULL,
  `layouts` text DEFAULT NULL,
  PRIMARY KEY (`cid`,`userId`),
  UNIQUE KEY `cpath_userId` (`cpath`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `fk_users_workspaces_object_objects` FOREIGN KEY (`cid`) REFERENCES `objects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_workspaces_object_users` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `versions`;
CREATE TABLE `versions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(11) unsigned DEFAULT NULL,
  `ctype` enum('document','asset','object') DEFAULT NULL,
  `userId` int(11) unsigned DEFAULT NULL,
  `note` text DEFAULT NULL,
  `stackTrace` text DEFAULT NULL,
  `date` int(11) unsigned DEFAULT NULL,
  `public` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `serialized` tinyint(1) unsigned DEFAULT 0,
  `versionCount` int(10) unsigned NOT NULL DEFAULT 0,
  `binaryFileHash` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `binaryFileId` bigint(20) unsigned DEFAULT NULL,
  `autoSave` tinyint(4) NOT NULL DEFAULT 0,
  `storageType` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `ctype_cid` (`ctype`,`cid`),
  KEY `date` (`date`),
  KEY `binaryFileHash` (`binaryFileHash`),
  KEY `autoSave` (`autoSave`),
  KEY `stackTrace` (`stackTrace`(1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `webdav_locks`;
CREATE TABLE `webdav_locks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner` varchar(100) DEFAULT NULL,
  `timeout` int(10) unsigned DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  `token` varbinary(100) DEFAULT NULL,
  `scope` tinyint(4) DEFAULT NULL,
  `depth` tinyint(4) DEFAULT NULL,
  `uri` varbinary(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`),
  KEY `uri` (`uri`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `website_settings`;
CREATE TABLE `website_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(190) NOT NULL DEFAULT '',
  `type` enum('text','document','asset','object','bool') DEFAULT NULL,
  `data` text DEFAULT NULL,
  `language` varchar(15) NOT NULL DEFAULT '',
  `siteId` int(11) unsigned DEFAULT NULL,
  `creationDate` int(11) unsigned DEFAULT 0,
  `modificationDate` int(11) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `siteId` (`siteId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `object_product`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `object_product` AS select `object_query_product`.`oo_id` AS `oo_id`,`object_query_product`.`oo_classId` AS `oo_classId`,`object_query_product`.`oo_className` AS `oo_className`,`object_query_product`.`sku` AS `sku`,`object_query_product`.`title` AS `title`,`objects`.`id` AS `id`,`objects`.`parentId` AS `parentId`,`objects`.`type` AS `type`,`objects`.`key` AS `key`,`objects`.`path` AS `path`,`objects`.`index` AS `index`,`objects`.`published` AS `published`,`objects`.`creationDate` AS `creationDate`,`objects`.`modificationDate` AS `modificationDate`,`objects`.`userOwner` AS `userOwner`,`objects`.`userModification` AS `userModification`,`objects`.`classId` AS `classId`,`objects`.`className` AS `className`,`objects`.`childrenSortBy` AS `childrenSortBy`,`objects`.`childrenSortOrder` AS `childrenSortOrder`,`objects`.`versionCount` AS `versionCount` from (`object_query_product` join `objects` on(`objects`.`id` = `object_query_product`.`oo_id`));

-- 2023-10-31 15:29:07
