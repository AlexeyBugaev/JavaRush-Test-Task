
DROP TABLE IF EXISTS parts;
CREATE TABLE parts(id INT(11) NOT NULL AUTO_INCREMENT, name VARCHAR(45), need TINYINT(20), quantity INT(11), PRIMARY KEY (id))
ENGINE = InnoDB DEFAULT CHARACTER SET = 'utf8' COLLATE='utf8_general_ci';
INSERT INTO parts(ID, name, need, quantity) VALUES ('1', 'Processor', '1', '4');
INSERT INTO parts(ID, name, need, quantity) VALUES ('2', 'Mother Board', '1', '5');
INSERT INTO parts(ID, name, need, quantity) VALUES ('3', 'Hard Drive', '1', '5');
INSERT INTO parts(ID, name, need, quantity) VALUES ('4', 'Video Card', '1', '6');
INSERT INTO parts(ID, name, need, quantity) VALUES ('5', 'USB card', '0', '4');
INSERT INTO parts(ID, name, need, quantity) VALUES ('6', 'System Block', '1', '5');
INSERT INTO parts(ID, name, need, quantity) VALUES ('7', 'Monitor', '1', '4');
INSERT INTO parts(ID, name, need, quantity) VALUES ('8', 'Keyboard', '1', '6');
INSERT INTO parts(ID, name, need, quantity) VALUES ('9', 'Cable HDMI', '0', '4');
INSERT INTO parts(ID, name, need, quantity) VALUES ('10', 'Mouse', '1', '5');
INSERT INTO parts(ID, name, need, quantity) VALUES ('11', 'Speakers', '0', '2');
INSERT INTO parts(ID, name, need, quantity) VALUES ('12', 'Power Supply', '1', '6');
INSERT INTO parts(ID, name, need, quantity) VALUES ('13', 'Cooler', '1', '5');
INSERT INTO parts(ID, name, need, quantity) VALUES ('14', 'DVD drive', '0', '6');
INSERT INTO parts(ID, name, need, quantity) VALUES ('15', 'Audio Card', '1', '7');
INSERT INTO parts(ID, name, need, quantity) VALUES ('16', 'DRAM', '1', '8');
INSERT INTO parts(ID, name, need, quantity) VALUES ('17', 'APC', '0', '4');
INSERT INTO parts(ID, name, need, quantity) VALUES ('18', 'WIFI adapter', '0', '4');
INSERT INTO parts(ID, name, need, quantity) VALUES ('19', 'Web Camera', '0', '3');
INSERT INTO parts(ID, name, need, quantity) VALUES ('20', 'USB Hub', '0', '5');
INSERT INTO parts(ID, name, need, quantity) VALUES ('21', 'Windows Software', '0', '5');
INSERT INTO parts(ID, name, need, quantity) VALUES ('22', 'Mouse Pad', '0', '6');



