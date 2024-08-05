/*
 Navicat Premium Data Transfer

 Source Server         : 122.9.184.225_3306
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : 122.9.184.225:3306
 Source Schema         : medince

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 24/07/2024 20:05:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for drug_info
-- ----------------------------
DROP TABLE IF EXISTS `drug_info`;
CREATE TABLE `drug_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `indications` text,
  `dosage` varchar(255) DEFAULT NULL,
  `side_effects` text,
  `data_source` varchar(255) DEFAULT NULL,
  `usage_method` varchar(255) DEFAULT NULL,
  `frequency_per_day` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4011 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of drug_info
-- ----------------------------
BEGIN;
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1001, '感冒灵颗粒', '解热镇痛。', '用于感冒引起的头痛，发热，鼻塞，流涕，咽痛。', '1', '偶见皮疹，荨麻疹，药热及粒细胞减少;可见困倦、嗜睡、虚弱感，长期大量用药会导致肝肾功能异常', NULL, '开水冲服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1002, '连花清瘟胶囊', '清瘟解毒，宣肺泄热。', '用于治疗流行性感冒属热毒袭肺证，症见:发热或高热，恶寒、肌肉酸痛，鼻塞流涕，咳嗽，头痛，咽干咽痛。', '4', '上市后监测数据显示可见以下胃肠道不良反应如恶心、呕吐、腹痛、腹泻、腹胀、反胃，以及皮疹、瘙痒、口干、头晕等。', NULL, '口服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1003, '布洛芬缓释胶囊', '适用于缓解以下症状:牙痛、头痛、原发性痛经肩痛、肌痛及运动后损伤性疼痛;劳损、腱鞘炎滑囊炎引起的疼痛;骨关节炎引起的关节肿痛以及普通感冒或流行性感冒引起的发热。', '', '1', '1.一般为肠、胃部不适，少数病人可能出现恶心.呕吐、腹痛、腹泻、肠胃气胀、便秘、胃烧灼感或轻度消化不良、胃肠道溃疡及出血。头痛、耳鸣、氨基转移酶升高、头晕、视力模糊、精神紧张、嗜睡、下肢水肿或体重骤增。2.偶见皮疹、荨麻疹瘙痒。极罕见严重皮肤过敏反应.剥脱性皮炎、史蒂文斯-约翰逊综合征(StevensJohnsonSyndrome)或大疱性皮肤病，如多形性红斑和表皮坏死松解症。', NULL, '口服，成人及12岁以上儿童，一次1粒，每日服用两次(早晚各一次)。', '2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1004, '健胃消食片', '健胃消食。', '用于脾胃虚弱所致的食积，症见不思饮食、嗳腐酸臭、脘腹胀满;消化不良见上述证候者。', '3', '尚不明确。', NULL, '口服，可以咀嚼', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1005, '养胃舒颗粒', '滋阴养胃。', '用于慢性胃炎，胃脘灼热，隐隐作痛。', '2', '尚不明确。', NULL, '开水冲服', '2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1006, '乳酸菌素片', '用于肠内异常发酵、消化不良、肠炎和小儿腹泻,。', '', '2', '尚不明确。', NULL, '咀嚼', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1007, '肠炎宁片', '清热利湿，行气。', '用于大肠湿热所致的泄泻，症见大便泄泻、腹痛腹胀;急慢性肠胃炎、腹泻、小儿消化不良见上述证侯者。', '3~4', '本品可见恶心、呕吐等胃肠道反应，及皮疹、瘙痒、头晕、口干等不良反应。', NULL, '口服', '3~4');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1008, '蒙脱石散', '用于成人及儿童急、慢性腹泻。', '', '1', '少数人可能产生轻度便秘。', NULL, '口服。成人每次1袋(3克)，一日3次。儿童1岁以下每日1袋，分3次服;1-2岁每日1-2袋，分3次服;2岁以上每日2-3袋，分3次服，服用时将本品倒入半杯温开水(约50毫升)中混匀快速服完。', '2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1009, '温胃舒颗粒', '温胃止痛。', '用于慢性胃炎，胃脘凉痛，饮食生冷受寒痛甚', '1~2', '尚不明确。', NULL, '开水冲服', '2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (1010, '藿香正气口服液', '解表化湿，理气和中。', '用于外感风寒、内伤湿滞或夏伤暑湿所致的感冒，症见头痛昏重、胸膈闷脘腹胀痛、呕吐泄泻;胃肠型感冒见上述证候者', '5~10', '尚不明确。', NULL, '开水冲服', '2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2001, '正柴胡饮颗粒', '风寒感冒,流行性感冒,上呼吸道感染,。', '无适应症。', '1', '尚不明确。', NULL, '开水冲服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2002, '复方对乙酰氨基酚片(Ⅱ)', '用于普通感冒或流行性感冒引起的发热，也用于缓解轻至中度疼痛如头痛、关节痛、偏头痛、牙痛、肌肉痛、神经痛、痛经。', '', '0.5~2（详见使用方法）', '偶见白血球缺乏症，正铁血红蛋自血症和血小板较少症，以及厌食、恶心、呕吐等其他过敏反应。详见说明书。', NULL, '口服，儿童每次0.5~1片，成人每次1~2片。', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2003, '双黄连口服液', '疏风解表，清热解毒。', '用于外感风热所致的感冒，症见发热、咳嗽、咽痛。', '20（详见使用方法）', '监测数据显示，双黄连口服制剂有皮疹、瘙痒、恶心、呕吐、腹痛、腹泻、胸闷、潮红、过敏或过敏样反应、头晕、呼吸困难、心悸等不良反应报告有肝功能生化指标异常、过敏性休克个例报告。', NULL, '口服。一次20毫升，一日3次;小儿酌减或遵医嘱。', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2004, '感通片', '清热解毒，疏风解表。', '用于感冒，症见发烧、头痛鼻塞、咳嗽痰黄、口干咽痛、咽喉红肿、全身酸痛。', '2', '1、偶见皮疹、荨麻疹，有报道，极少数患者使用对乙酰氨基酚可能出现致命的、严重的皮肤不良反应;偶见药热及粒细胞减少。长期大量用药会导致肝肾功能异常。2、偶见头痛、恶心、呕吐。', NULL, '口服', '2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2005, '藿香祛暑软胶囊', '祛暑化湿，解表和中。', '用于内蕴湿滞、受暑感寒引起的恶寒发热、头痛无汗、四肢酸懒、恶心呕吐、腹痛腹泻。', '2~4', '尚不明确。', NULL, '口服', '2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2006, '银翘解毒片', '疏风解表，清热解毒。', '用于风热感冒，症见发热头痛、咳嗽口干、咽喉疼痛。', '4', '尚不明确。', NULL, '口服', '2~3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2007, '小柴胡颗粒', '解表散热，疏肝和胃。', '用于外感病，邪犯少阳证症见寒热往来、胸胁苦满、食欲不振、心烦喜呕口苦咽干。', '1~2', '尚不明确', NULL, '开水冲服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2008, '桑菊感冒片', '疏风清热，宣肺止咳。', '用于风热感冒初起，头痛咳嗽，口干，咽痛。', '4~8。', '尚不明确。', NULL, '口服', '2~3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2009, '四季抗病毒合剂', '清热解毒，消炎退热。', '用于上呼吸道感染，病毒性感冒，流感等病毒性感染疾患，症见头痛、发热、流涕、咳嗽等。', '10~20', '尚不明确。', NULL, '口服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (2010, '通宣理肺片', '解表散寒，宣肺止嗽。', '用于风寒感冒所致的咳嗽发热恶寒，鼻塞流涕，头痛无汗，肢体酸痛。', '4', '尚不明确。', NULL, '口服', '2~3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3001, '蜜炼川贝枇杷膏', '清热润肺，止咳平喘，理气化痰。', '适用于肺燥之咳嗽，痰多，胸闷，咽喉痛痒，声音沙哑。', '22', '监测数据显示，川贝枇杷制剂有恶心、呕吐、腹痛、腹泻、胃不适、头晕、皮疹、瘙痒等不良反应报告。', NULL, '口服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3002, '碳酸钙D3片', '用于妊娠和哺乳期妇女、更年期妇女钙补充剂，并帮助防治骨质疏松症。', '', '1', '尚不明确。', NULL, '口服', '1~2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3003, '糠酸莫米松乳膏', '用于湿疹、神经性皮炎，异位性皮炎及皮肤瘙痒症。', '', '适量', '极少见，如烧灼感、瘙痒刺痛和皮肤萎缩等。', NULL, '局部外用。取本品适量涂于患处，', '1');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3004, '叶酸片', '1.预防胎儿先天性神经管畸形。', '2.妊娠期、哺乳期妇女预防用药。', '0.4', '不良反应较少，罕见过敏反应。长期用药可出现畏食、恶心、腹胀等胃肠道症状。大量服用叶酸时，可使尿液呈黄色。', NULL, '1.预防胎儿先天性神经管畸形:口服，育龄妇女从计划怀孕时起至怀孕后三个月末，一次0.4mg，日1次。2.妊娠期、哺乳期妇女预防用药:一次0.4mg，一日1次。', '1');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3005, '蓝芩颗粒', '清热解毒，清咽消肿。', '用于急性咽炎、肺胃实热证所致的咽痛、咽干、咽部灼热等症。', '1', '尚不明确。', NULL, '开水冲服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3006, '杞菊地黄丸(浓缩丸)', '滋肾养肝。', '用于肝肾阴亏，眩晕耳鸣，羞明畏光迎风流泪，视物昏花。', '8', '尚不明确。', NULL, '口服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3007, '荆防颗粒', '发汗解表，散风祛湿。', '用于风寒感冒，头痛身痛恶寒无汗，鼻塞清涕，咳嗽白痰。', '1', '尚不明确。', NULL, '开水冲服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3008, '碳酸钙D3咀嚼片(Ⅲ)', '用于妊娠和哺乳期妇女、更年期妇女、老年人、儿童等的钙补充剂，预防和辅助治疗骨质疏松症，。', '无适应症。', '1', '嗳气、便秘、腹胀、皮疹。', NULL, '口服，咀嚼后咽下。', '1');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3009, '健脾丸(浓缩丸)', '健脾开胃。', '用于脾胃虚弱，脘腹胀满，食少便溏。', '8', '1.忌食生冷油腻不易消化食物。 2.不适用于急性肠炎腹泻，主要表现为腹痛、水样大便频繁，或发烧。', NULL, '口服', '3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (3010, '琥珀酸亚铁片', '用于缺铁性贫血的预防和治疗。', '无适应症。', '详见使用方法', '1.可见胃肠道不良反应,如恶心、呕吐、上腹疼痛便秘。2.本品可减少肠蠕动,', NULL, '口服，用于预防:成人一日1片，孕妇一日2片，儿童一日0.5片。用于治疗:成人一日2~4片，儿童一日1~3片。', NULL);
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4001, '复方薄荷脑软膏', '用于有伤风感冒所致的鼻塞、昆虫叮咬、皮肤皲裂、轻度烧烫伤、擦伤、晒伤及皮肤瘙痒等。', '', '适量', '偶见皮肤刺激症状。', NULL, '外用。伤风感冒涂于鼻下;昆虫叮咬或皮肤皲裂等，涂于患处', '3~4');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4002, '云南白药创可贴', '止血，镇痛，消炎，愈创。', '用于小面积开放性创伤。', '适量', '过敏性体质患者可能有胶布过敏反应或药物接触性反应。', NULL, '清洁创面，从防沾胶纸上揭下云南白药创可贴，使药带贴于创面，松紧适当即可', NULL);
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4003, '风油精', '清凉，止痛，驱风，止痒。', '用于蚊虫叮咬及伤风感冒引起的头痛，头晕，晕车不适。', '适量', '尚不明确', NULL, '外用，涂擦于患处。口服，一次', NULL);
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4004, '糠酸莫米松凝胶', '用于湿疹、神经性皮炎、异位性皮炎及皮肤瘙痒症。', '', '适量', '使用本品的局部不良反应极少见，如烧灼感、瘙痒刺痛和皮肤萎缩。', NULL, '局部外用。取本品适量涂于患处', '1');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4005, '尿素乳膏', '用于手足皲裂;也可用于角化型手足癣所引起的皲裂。', '', '适量', '偶见皮肤刺激和过敏反应，', NULL, '局部外用，涂于患处并轻轻揉搓', '2-3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4006, '复方樟薄软膏', '芳香通窍，祛风止痒，清凉。', '无适应症。', '适量', '尚不明确。', NULL, '外用，涂擦患处', NULL);
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4007, '烧烫伤膏', '清热解毒，消肿止痛。', '用于轻度水、火烫伤。用于程度较轻的烧伤(', '适量', '尚不明确。', NULL, '涂敷患处', NULL);
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4008, '克林霉素磷酸酯凝胶', '用于治疗寻常痤疮。', '', '适量', '可引起皮肤干燥、局部刺激、皮疹等过敏反应。偶见胃肠不适及腹泻。', NULL, '局部外用，用温水洗净患处，轻轻擦干后，取适量凝胶在患处涂一薄层', '2');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4009, '丹皮酚软膏', '抗过敏药，有消炎止痒作用。', '用于各种湿疹，皮炎，皮肤瘙痒，蚊臭虫叮咬红肿等各种皮肤疾患对过敏性鼻炎和防治感冒也有一定效果。', '适量', '尚不明确。', NULL, '外用，涂敷患处;防治感冒可涂鼻下上唇处，鼻炎涂鼻腔内。', '2~3');
INSERT INTO `drug_info` (`id`, `name`, `description`, `indications`, `dosage`, `side_effects`, `data_source`, `usage_method`, `frequency_per_day`) VALUES (4010, '戊酸雌二醇片', '用于促进和调节女性生殖器官和副性征的正常发育，补充雌激素不足，缓解绝经妇女因雌激素缺乏导致的症状。', '通常与孕激素联合使用建立人工月经周期，补充与自然、人工绝经相关的雌激素缺乏，辅助治疗血管舒缩性疾病（如潮热），生殖泌尿道营养性疾病（如外阴阴道萎缩、性交困难、尿失禁）以及精神性疾病（如睡眠障碍、衰弱）。', '1', '服用本品后可能出现的常见（1/100~1/10）不良反应有体重变化、头痛、腹痛、恶心、皮疹、子宫/阴道出血等。', NULL, '外用，涂搽患处', '.');
COMMIT;

-- ----------------------------
-- Table structure for medication_drugs
-- ----------------------------
DROP TABLE IF EXISTS `medication_drugs`;
CREATE TABLE `medication_drugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medication_id` int(11) DEFAULT NULL,
  `drug_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_medication_id` (`medication_id`),
  KEY `idx_drug_id` (`drug_id`),
  CONSTRAINT `medication_drugs_ibfk_1` FOREIGN KEY (`medication_id`) REFERENCES `medications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_drugs_ibfk_2` FOREIGN KEY (`drug_id`) REFERENCES `drug_info` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of medication_drugs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for medications
-- ----------------------------
DROP TABLE IF EXISTS `medications`;
CREATE TABLE `medications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `dosage` varchar(255) NOT NULL,
  `frequency` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `notes` text,
  `taken_today` int(11) DEFAULT '0',
  `next_dose_time` longtext,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `medications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of medications
-- ----------------------------
BEGIN;
INSERT INTO `medications` (`id`, `user_id`, `name`, `dosage`, `frequency`, `start_date`, `end_date`, `notes`, `taken_today`, `next_dose_time`) VALUES (31, 1002, '感冒灵颗粒', '1', '3', '2024-07-24', '2024-08-03', '开水口服', 10, '[\"08:00\",\"12:00\",\"17:00\"]');
INSERT INTO `medications` (`id`, `user_id`, `name`, `dosage`, `frequency`, `start_date`, `end_date`, `notes`, `taken_today`, `next_dose_time`) VALUES (36, 1002, '连花清瘟胶囊', '1', '3', '2024-07-24', '2024-08-24', '开水口服', 30, '[\"12:00\",\"17:00\",\"21:00\"]');
INSERT INTO `medications` (`id`, `user_id`, `name`, `dosage`, `frequency`, `start_date`, `end_date`, `notes`, `taken_today`, `next_dose_time`) VALUES (37, 1002, '布洛芬缓释胶囊', '1', '2', '2024-07-24', '2024-08-24', '开水服用', 30, '[\"12:00\",\"21:00\"]');
COMMIT;

-- ----------------------------
-- Table structure for pharmacies
-- ----------------------------
DROP TABLE IF EXISTS `pharmacies`;
CREATE TABLE `pharmacies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` text,
  `phone` varchar(20) DEFAULT NULL,
  `hours` varchar(255) DEFAULT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pharmacies
-- ----------------------------
BEGIN;
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (1, '益丰大药房（品扬店）', '上海市宝山区大华一路210号', '021-56166098', '周一至周日8:30-21:00', 31.257100, 121.428700);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (2, '复美大药房（真华店）', '上海市宝山区真华路888号', '021-56338990', '周一至周日全天', 31.261800, 121.424800);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (3, '第一医药（大华店）', '上海市宝山区大华路456号', '021-56701982', '周一至周日全天', 31.267400, 121.418900);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (4, '益丰大药房（上海益丰虎城店）', '上海市宝山区虎城路300号', '021-56050987', '周一至周日8:30-21:00', 31.264500, 121.436200);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (5, '益丰大药房（万里店）', '上海市宝山区万里路600号', '021-56782143', '周一至周日8:30-21:00', 31.281400, 121.422300);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (6, '华氏大药房（西部甘泉店）', '上海市宝山区甘泉路200号', '021-56038904', '周一至周日8:30-20:30', 31.266200, 121.413500);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (7, '第一医药（高平路店）', '上海市宝山区高平路128号', '021-56780920', '周一至周日全天', 31.273500, 121.432100);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (8, '华氏大药房（永和分店）', '上海市宝山区永和路78号', '021-56761234', '周一至周日8:30-20:30', 31.265800, 121.421800);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (9, '华氏大药房（新村店）', '上海市宝山区新村路128号', '021-56790543', '周一至周日8:30-20:30', 31.268900, 121.417200);
INSERT INTO `pharmacies` (`id`, `name`, `address`, `phone`, `hours`, `latitude`, `longitude`) VALUES (10, '复美大药房（华池店）', '上海市宝山区华池路299号', '021-56176821', '周一至周日全天', 31.262700, 121.429400);
COMMIT;

-- ----------------------------
-- Table structure for pharmacy_drugs
-- ----------------------------
DROP TABLE IF EXISTS `pharmacy_drugs`;
CREATE TABLE `pharmacy_drugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pharmacy_id` int(11) DEFAULT NULL,
  `drug_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pharmacy_id` (`pharmacy_id`),
  KEY `idx_drug_id_pharmacy` (`drug_id`),
  CONSTRAINT `pharmacy_drugs_ibfk_1` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_drugs_ibfk_2` FOREIGN KEY (`drug_id`) REFERENCES `drug_info` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pharmacy_drugs
-- ----------------------------
BEGIN;
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (1, 1, 1001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (2, 1, 1002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (3, 1, 1003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (4, 1, 1004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (5, 1, 1005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (6, 1, 1006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (7, 1, 1007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (8, 1, 1008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (9, 1, 1009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (10, 1, 1010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (11, 2, 3001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (12, 2, 3002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (13, 2, 3003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (14, 2, 3004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (15, 2, 3005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (16, 2, 3006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (17, 2, 3007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (18, 2, 3008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (19, 2, 3009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (20, 2, 3010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (21, 3, 4001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (22, 3, 4002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (23, 3, 4003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (24, 3, 4004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (25, 3, 4005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (26, 3, 4006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (27, 3, 4007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (28, 3, 4008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (29, 3, 4009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (30, 3, 4010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (31, 4, 1001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (32, 4, 1002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (33, 4, 1003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (34, 4, 1004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (35, 4, 1005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (36, 4, 1006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (37, 4, 1007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (38, 4, 1008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (39, 4, 1009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (40, 4, 1010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (41, 5, 1001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (42, 5, 1002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (43, 5, 1003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (44, 5, 1004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (45, 5, 1005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (46, 5, 1006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (47, 5, 1007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (48, 5, 1008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (49, 5, 1009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (50, 5, 1010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (51, 6, 2001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (52, 6, 2002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (53, 6, 2003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (54, 6, 2004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (55, 6, 2005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (56, 6, 2006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (57, 6, 2007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (58, 6, 2008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (59, 6, 2009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (60, 6, 2010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (61, 7, 4001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (62, 7, 4002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (63, 7, 4003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (64, 7, 4004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (65, 7, 4005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (66, 7, 4006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (67, 7, 4007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (68, 7, 4008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (69, 7, 4009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (70, 7, 4010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (71, 8, 2001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (72, 8, 2002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (73, 8, 2003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (74, 8, 2004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (75, 8, 2005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (76, 8, 2006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (77, 8, 2007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (78, 8, 2008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (79, 8, 2009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (80, 8, 2010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (81, 9, 2001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (82, 9, 2002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (83, 9, 2003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (84, 9, 2004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (85, 9, 2005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (86, 9, 2006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (87, 9, 2007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (88, 9, 2008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (89, 9, 2009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (90, 9, 2010);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (91, 10, 3001);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (92, 10, 3002);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (93, 10, 3003);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (94, 10, 3004);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (95, 10, 3005);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (96, 10, 3006);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (97, 10, 3007);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (98, 10, 3008);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (99, 10, 3009);
INSERT INTO `pharmacy_drugs` (`id`, `pharmacy_id`, `drug_id`) VALUES (100, 10, 3010);
COMMIT;

-- ----------------------------
-- Table structure for reminders
-- ----------------------------
DROP TABLE IF EXISTS `reminders`;
CREATE TABLE `reminders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `medication_id` int(11) DEFAULT NULL,
  `reminder_time` timestamp NOT NULL,
  `sent` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `medication_id` (`medication_id`),
  KEY `idx_user_id_medication_id` (`user_id`,`medication_id`),
  CONSTRAINT `reminders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reminders_ibfk_2` FOREIGN KEY (`medication_id`) REFERENCES `medications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of reminders
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `times` longtext,
  `breakfast_time` time DEFAULT NULL,
  `lunch_time` time DEFAULT NULL,
  `dinner_time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1028 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1001, 'MAX', '马翔', 'maxiang@163.com', '12296361234', 'max666', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1002, 'LogicGu', '孤傲风云', '1403176153@qq.com', '17701818335', '$2b$10$sOxY9MuG7/NRAJVMTrDN1.W.GTY73eGKBa0ToRQ0bEpYNdatJnf7.', '[\"08:00\",\"12:00\",\"17:00\",\"21:00\",\"23:00\"]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1003, 'user1', 'Alice', 'alice@example.com', '1234567890', 'password1', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1004, 'user2', 'Bob', 'bob@example.com', '0987654321', 'password2', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1005, 'user3', 'Charlie', 'charlie@example.com', '1234509876', 'password3', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1006, 'user4', 'David', 'david@example.com', '0987612345', 'password4', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1007, 'user5', 'Eve', 'eve@example.com', '5678901234', 'password5', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1008, 'user6', 'Frank', 'frank@example.com', '8765432109', 'password6', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1009, 'user7', 'Grace', 'grace@example.com', '3456789012', 'password7', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1010, 'user8', 'Hank', 'hank@example.com', '6543210987', 'password8', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1011, 'user9', 'Ivy', 'ivy@example.com', '1234567000', 'password9', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1012, 'user10', 'Jack', 'jack@example.com', '9876543210', 'password10', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1013, '18621717402', '尤沛霖', '1528654438@qq.com', '18621717402', '$2b$10$S3DAcwOcjtO7lwIlFf0uV.sDixUDkOB/nf7DXukYFn1EmL8JeKymS', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1022, '孕', '孕孕孕', 'default@example.com', '15806317200', '$2b$10$JzGzK5AP2s83i8q/YYY/4eKcu0BgBAoucGdIxBrFV8.1YFJWf/82W', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1023, '13701715945', '13701715945', 'default@example.com', '13701715945', '$2b$10$w4VRoE7PbgWJnh9eCpnjpeBV9L8RUdsXXe23xptvfnwKdMhlTg3ZO', '[]', NULL, NULL, NULL);
INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `password`, `times`, `breakfast_time`, `lunch_time`, `dinner_time`) VALUES (1024, '17701818', 'New User', 'default@example.com', '17701818', '$2b$10$B/p6.V7csYngiCZE6GHKLez7NzMUd5jYAHssC.h8MqLZOVg6DSJOC', '[]', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Triggers structure for table medications
-- ----------------------------
DROP TRIGGER IF EXISTS `check_medication_dates`;
delimiter ;;
CREATE TRIGGER `check_medication_dates` BEFORE INSERT ON `medications` FOR EACH ROW BEGIN
    IF NEW.start_date > NEW.end_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Start date cannot be later than end date';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table reminders
-- ----------------------------
DROP TRIGGER IF EXISTS `set_reminder_time`;
delimiter ;;
CREATE TRIGGER `set_reminder_time` BEFORE INSERT ON `reminders` FOR EACH ROW BEGIN
    DECLARE breakfast TIME;
    DECLARE lunch TIME;
    DECLARE dinner TIME;
    DECLARE freq INT;

    SELECT breakfast_time, lunch_time, dinner_time INTO breakfast, lunch, dinner
    FROM users WHERE id = NEW.user_id;

    SELECT frequency INTO freq FROM medications WHERE id = NEW.medication_id;

    IF freq = 1 THEN
        SET NEW.reminder_time = TIMESTAMPADD(HOUR, 1, breakfast);
    ELSEIF freq = 2 THEN
        INSERT INTO reminders (user_id, medication_id, reminder_time, sent)
        VALUES (NEW.user_id, NEW.medication_id, TIMESTAMPADD(HOUR, 1, breakfast), NEW.sent);
        SET NEW.reminder_time = TIMESTAMPADD(HOUR, 1, dinner);
    ELSEIF freq = 3 THEN
        INSERT INTO reminders (user_id, medication_id, reminder_time, sent)
        VALUES (NEW.user_id, NEW.medication_id, TIMESTAMPADD(HOUR, 1, breakfast), NEW.sent);
        INSERT INTO reminders (user_id, medication_id, reminder_time, sent)
        VALUES (NEW.user_id, NEW.medication_id, TIMESTAMPADD(HOUR, 1, lunch), NEW.sent);
        SET NEW.reminder_time = TIMESTAMPADD(HOUR, 1, dinner);
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table reminders
-- ----------------------------
DROP TRIGGER IF EXISTS `check_reminder_time`;
delimiter ;;
CREATE TRIGGER `check_reminder_time` BEFORE INSERT ON `reminders` FOR EACH ROW BEGIN
    IF NEW.reminder_time < '00:00:00' OR NEW.reminder_time > '23:59:59' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Reminder time must be within a valid range (00:00:00 - 23:59:59).';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table users
-- ----------------------------
DROP TRIGGER IF EXISTS `after_update_user_mealtime`;
delimiter ;;
CREATE TRIGGER `after_update_user_mealtime` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    DECLARE freq INT;

    IF NEW.breakfast_time <> OLD.breakfast_time OR NEW.lunch_time <> OLD.lunch_time OR NEW.dinner_time <> OLD.dinner_time THEN
        
        UPDATE reminders r
        JOIN medications m ON r.medication_id = m.id
        SET r.reminder_time = TIMESTAMPADD(HOUR, 1, NEW.breakfast_time)
        WHERE r.user_id = NEW.id AND m.frequency = 1;

        UPDATE reminders r
        JOIN medications m ON r.medication_id = m.id
        SET r.reminder_time = TIMESTAMPADD(HOUR, 1, NEW.breakfast_time)
        WHERE r.user_id = NEW.id AND m.frequency = 2;

        UPDATE reminders r
        JOIN medications m ON r.medication_id = m.id
        SET r.reminder_time = TIMESTAMPADD(HOUR, 1, NEW.dinner_time)
        WHERE r.user_id = NEW.id AND m.frequency = 2;

        UPDATE reminders r
        JOIN medications m ON r.medication_id = m.id
        SET r.reminder_time = TIMESTAMPADD(HOUR, 1, NEW.breakfast_time)
        WHERE r.user_id = NEW.id AND m.frequency = 3;

        UPDATE reminders r
        JOIN medications m ON r.medication_id = m.id
        SET r.reminder_time = TIMESTAMPADD(HOUR, 1, NEW.lunch_time)
        WHERE r.user_id = NEW.id AND m.frequency = 3;

        UPDATE reminders r
        JOIN medications m ON r.medication_id = m.id
        SET r.reminder_time = TIMESTAMPADD(HOUR, 1, NEW.dinner_time)
        WHERE r.user_id = NEW.id AND m.frequency = 3;

    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
