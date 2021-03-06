INSERT INTO staff_access VALUES 
	(NULL, 'ab59007fb100b40ca005a2f6573b35e91f263e48','0'),
	(NULL, '90f0475b2175af802af928c2f5b698d7295b511f','1'),
	(NULL, '55a6fbbdfbab66675a6a56e437aeb94b30c8c68b','0'),
	(NULL, '90f0475b2175af802af928c2f5b698d7295b511f','1'),
	(NULL, 'c4bae3fee08318e23c3bf2f5a6a32375f35d23f8','0');
	
INSERT INTO staff VALUES 
	('1','Nat','Mayer','fwhite@example.com'),
	('2','Albert','Casper','mercedes40@example.net'),
	('3','Halle','Parker','chanelle.windler@example.com'),
	('4','Myriam','Tillman','schamberger.thelma@example.net'),
	('5','Linnea','Harvey','pblanda@example.net');
	
INSERT INTO sample_types VALUES
	('1','Вода'),
	('2','Почва'),
	('3','Воздух');

INSERT INTO standards VALUES
	('1','рН воды', '1'),
	('2','ХО воды', '1'),
	('3','Общая жесткость воды', '1'),
	('4','Cu, Zn, Fe растворенные формы', '1'),
	('5','рН почвенной вытяжки', '2'),
	('6','K, N, P в плодородном слое', '2'),
	('7','Углеводороды в плодородном слое', '2'),
	('8','Hg в донных отложениях', '2'),
	('9','Углеводороды в атмосферном воздухе', '3'),
	('10','Pb, As в промышленных выбросах', '3');

INSERT INTO samples VALUES 
	('1','Донный ил','2019-09-02','7','1','8','2','Ил очистных сооружений №7','2020-04-12 20:40:36','Зарегистрирована','2020-04-12 20:40:36'),
	('2','Дерново-подзолистые почвы','2019-04-20','3','2','6','2','Плодородный слой под пшеницу','2020-04-12 20:40:36','В работе','2020-04-13 04:48:21'),
	('3','Артезианский источник -150 м','2019-10-09','2','3','3','1','Прозрачный образец с резким запахом','2020-04-12 20:40:36','Зарегистрирована','2020-04-12 20:40:36'),
	('4','ПВ доменного цеха','2020-03-22','2','4','10','3','Квартальный забор','2020-04-12 20:40:36','В работе','2020-04-13 17:04:09'); 

INSERT INTO indicators VALUES 
	('1','Кислотный показатель', 'ед. рН','1'),
	('2','ХПК', 'мг[O]/л','2'),
	('3','Жесткость общ','Ж','3'),
	('4','Cu','мг/л','4'),
	('5','Zn','мг/л','4'),
	('6','Fe','мг/л','4'),
	('7','Кислотный показатель вытяжек','ед. рН','5'),
	('8','K','мг/кг','6'),
	('9','N','мг/кг','6'),
	('10','P','мг/кг','6'),
	('11','Алканы','мг/кг','7'),
	('12','Hg','мг/кг','8'),
        ('13','ПАУ','мг/м3','9'),
        ('14','Pb','мг/м3','10'),
        ('15','As','мг/м3','10');
       
INSERT INTO instruments VALUES
	('1','рН-метр','ед. рН'),
	('2','КФК','мг/л'),
	('3','ААС Квант','мг/кг'),
	('4','ГХ Кристалл 5000','мг/м3');

INSERT INTO reagents VALUES
	('1','Перманганат калия','1','2'),
	('2','Кислота соляная','5','10'),
	('3','Кислота азотная','5','4'),
	('4','ГСО ПАУ','1','9'),
	('5','ГСО меди','1','4'),
	('6','ГСО цинка','1','4'),
	('7','ГСО ртути','1','8');

INSERT INTO results VALUES
	('1','Протокол №1/88','2.1300','1','1','1','1','1','1','1988-08-10 08:50:56'),
	('2','Протокол №1/94','0.3576','2','2','2','2','2','2','1994-09-08 22:02:24'),
	('3','Протокол №1/2010','1.0671','3','3','3','3','3','3','2010-06-23 10:04:48'),
	('4','Протокол №1/2001','2.0021','4','4','4','1','4','4','2001-12-15 01:02:24'),
	('5','Протокол №1/2015','1.7500','5','4','5','2','1','5','2015-09-24 11:19:10'),
	('6','Протокол №1/2013','2.0450','1','4','6','3','2','6','2013-01-28 20:13:38'),
	('7','Протокол №2/2001','4.8685','2','4','7','1','3','7','2001-04-07 09:27:30'),
	('8','Протокол №1/78','0.2247','3','4','8','2','4','8','1978-08-25 16:54:51'),
	('9','Протокол №1/98','1.0000','4','3','9','3','1','9','1998-03-22 18:19:23'),
	('10','Протокол №1/2007','4.6240','2','1','10','1','2','10','2007-09-18 16:12:59');

INSERT INTO validations VALUES
	('1','1','Smith','В переделке'),
	('2','2','Elza','В переделке'),
	('3','3','Kessler','На рассмотрении'),
	('4','4','Kiehn','Утверждено'),
	('5','5','Torp','На рассмотрении'),
	('6','6','Hessel','Утверждено'),
	('7','7','Keyshawn','На рассмотрении'),
	('8','8','Con','В переделке'),
	('9','9','Rico','В переделке'),
	('10','10','Grant','Утверждено');



