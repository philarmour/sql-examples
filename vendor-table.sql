--liquibase formatted sql


-- changeset phil:20200117_cor_123_01
CREATE TABLE vendor.`vendor_reservation` (
  `vendor_reservation_id`                    int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_reference_id` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `raw_data`              MEDIUMTEXT,
  `vendor_code`           varchar(25)     NOT NULL,
  `vendor_code_id`        int(11)         NOT NULL,
  `version`               int(8) unsigned NOT NULL,
  `created_datetime_utc`  datetime        not null default CURRENT_TIMESTAMP,
  `modified_datetime_utc` datetime        not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created_by`            varchar(100)    not null,
  `modified_by`           varchar(100)        null,
  PRIMARY KEY (`vendor_reservation_id`),
  FOREIGN KEY (id) references vendor_code(vendor_code_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- changeset phil:20200117_cor_123_02
CREATE TABLE vendor.`vendor_code` (
  `id`          int(11)     NOT NULL AUTO_INCREMENT,
  `vendor_code`             varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_datetime_utc`    datetime     not null,
  `modified_datetime_utc`   datetime     not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created_by`              varchar(100) not null,
  `modified_by`             varchar(100)     null,
  PRIMARY KEY (`vendor_code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- changeset phil:20200117_cor_123_03
insert into vendor.vendor_code (
  vendor_code_id, vendor_code
)
values (1,'SABRE');



-- changeset phil:20200117_cor_123_04 endDelimiter:# stripComments:false
CREATE  TRIGGER `BEFORE_INSERT_vendor_code` BEFORE INSERT ON `vendor_code` FOR EACH ROW

BEGIN
  IF `NEW`.`created_by` IS NULL THEN
    SET `NEW`.`created_by` = session_user();
  END IF;
END
#
-- changeset phil:20200117_cor_123_05 endDelimiter:# stripComments:false
CREATE  TRIGGER `BEFORE_INSERT_vendor_reservation` BEFORE INSERT ON `vendor_reservation` FOR EACH ROW

BEGIN
  IF `NEW`.`created_by` IS NULL THEN
    SET `NEW`.`created_by` = session_user();
  END IF;
END

-- changeset phil:20200117_cor_123_06 endDelimiter:# stripComments:false
CREATE  TRIGGER `BEFORE_UPDATE_1_vendor_code` BEFORE UPDATE ON `vendor_code` FOR EACH ROW

BEGIN
  IF `NEW`.`modified_by` IS NULL THEN
    SET `NEW`.`modified_by` = session_user();
  END IF;
END
#

-- changeset phil:20200117_cor_123_07 endDelimiter:# stripComments:false
CREATE  TRIGGER `BEFORE_UPDATE_1_vendor_reservation` BEFORE UPDATE ON `vendor_reservation` FOR EACH ROW

BEGIN
  IF `NEW`.`modified_by` IS NULL THEN
    SET `NEW`.`modified_by` = session_user();
  END IF;
END
#
