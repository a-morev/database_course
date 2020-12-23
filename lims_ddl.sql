/*Лабораторная система управления информацией (LIMS) обеспечивает следующий функционал: отслеживание образцов поступающих в лабораторию, идентификация
 *сотрудников проводивших испытания, управление испытательным оборудованием, поддержка системы стандартизации и спецификации образцов, обеспечение
 *аудита проведенных испытаний.
 
 *Регистрация образцов производится путем ввода информации в компьютер. Возможна разработка нескольких сценариев запросов на регистрацию, в 
 *зависимости от того, что поступило на исследование. Может быть разработан сценарий для регистрации плановых образцов в случае, когда их тип и 
 *количество заранее известны. Возможна разработка сценария для внеплановой регистрации, когда материал неизвестен и не определены анализы, 
 *которые необходимо выполнить. Может быть составлено расписание регистрации образцов, если, например, необходимо строго соблюдать время отбора и 
 *регистрации проб. При этом система сама будет отслеживать выполнение расписания.
 
 *После того, как информация об образце будет занесена в систему, СУБД предусматривает, при необходимости, исправлять первоначальные требования к анализу и 
 *вводить дополнительные анализы для соответствия стандартам НД.

 *Рабочий журнал позволяет группировать взаимосвязанные анализы и необходимые для их проведения стандарты. С его помощью можно отслеживать количество и тип 
 *стандартов, необходимых для проведения указанных анализов. При формировании рабочего журнала его ведение может быть предписано конкретному человеку или 
 *всем сотрудникам лаборатории.

 *Ввод результатов осуществляется как автоматически с приборов, так и вручную. Можно вводить либо результаты конкретного анализа, а также заполнять 
 *рабочий журнал. При вводе результатов предусмотрена их автоматическая проверка на соответствие различным пределам и НД. Например, это может быть полезно 
 *при задании сортности или автоматического отслеживания значений, величина которых ниже предела чувствительности прибора.

 *Утверждение также может производиться в автоматическом и ручном режимах. Ответственное лицо имеет возможность просмотреть результаты и принять решение 
 *об их утверждении. Однако принимать решение об утверждении, основываясь на сравнении результатов с заданными пределами, можно и с помощью СУБД.

 *Следует отметить, что система строго разграничивает доступ к информации и возможности манипуляции с ней. Например, оператор может видеть и изменять только 
 *свои результаты, в то время как руководитель лаборатории имеет доступ к информации, получаемой всеми подразделениями.

 *Анализ деятельности лаборатории производится на основе сохраняющихся в СУБД данных и может состоять из различного рода статистических исследований, 
 *временных распределений.
*/

DROP DATABASE IF EXISTS lims;
CREATE DATABASE lims;
USE lims;

DROP TABLE IF EXISTS staff_access;
CREATE TABLE staff_access (
    id SERIAL PRIMARY KEY,
    password_hash VARCHAR(50),        
    is_admin ENUM('0', '1')
) COMMENT = 'Идентификация оператора';

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
    staff_access_id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),    
    email VARCHAR(120) UNIQUE,     
    INDEX staff_firstname_lastname_idx(firstname, lastname),
    FOREIGN KEY (staff_access_id) REFERENCES staff_access(id)
) COMMENT = 'Персонал';

DROP TABLE IF EXISTS sample_types;
CREATE TABLE sample_types (
    id SERIAL PRIMARY KEY,
    types_name CHAR(40) COMMENT 'Тип пробы',    
    INDEX idx_of_types_name(types_name)    
) COMMENT = 'Тип аналитических проб';

DROP TABLE IF EXISTS standards;
CREATE TABLE standards (
    id SERIAL PRIMARY KEY,
    name TEXT COMMENT 'Наименование методики',
    sample_types_id BIGINT UNSIGNED NOT NULL,
    
    INDEX idx_of_name(name(255)),
    FOREIGN KEY (sample_types_id) REFERENCES sample_types(id)
) COMMENT = 'Стандарты испытаний';

DROP TABLE IF EXISTS samples;
CREATE TABLE samples (
    id SERIAL PRIMARY KEY,
    sample_name VARCHAR(255) COMMENT 'Название пробы',
    sampling_date DATE COMMENT 'Дата пробоотбора',
    sample_numbers INT UNSIGNED NOT NULL COMMENT 'Кол-во однотипных проб',    
    staff_access_id BIGINT UNSIGNED NOT NULL,
    standards_id BIGINT UNSIGNED NOT NULL,
    sample_types_id BIGINT UNSIGNED NOT NULL,
    description TEXT COMMENT 'Примечание',    
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата поступления пробы',
    `status` ENUM('Зарегистрирована', 'В работе', 'Выдан протокол') NOT NULL DEFAULT 'Зарегистрирована',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX samples_sample_name_status_idx(sample_name, status),    
    FOREIGN KEY (staff_access_id) REFERENCES staff_access(id),    
    FOREIGN KEY (standards_id) REFERENCES standards(id),
    FOREIGN KEY (sample_types_id) REFERENCES sample_types(id)    
) COMMENT = 'Пробы';

DROP TABLE IF EXISTS indicators;
CREATE TABLE indicators (
    id SERIAL PRIMARY KEY,
    indicator_name CHAR(40) COMMENT 'Определяемый показатель',
    unit CHAR(10) COMMENT 'Единица измерения',    
    standards_id BIGINT UNSIGNED NOT NULL,
    
    INDEX (standards_id),
    INDEX idx_of_indicator_name(indicator_name),
    FOREIGN KEY (standards_id) REFERENCES standards(id)
) COMMENT = 'Показатели';

DROP TABLE IF EXISTS instruments;
CREATE TABLE instruments (
    id SERIAL PRIMARY KEY,
    machine_name CHAR(40) COMMENT 'Измерительное оборудование',
    unit CHAR(10) COMMENT 'Единица измерения',    
    
    INDEX idx_of_machine_name(machine_name)    
) COMMENT = 'Оборудование';

DROP TABLE IF EXISTS reagents;
CREATE TABLE reagents (
    id SERIAL PRIMARY KEY,
    reagent_name CHAR(40) COMMENT 'Название реактива',
    quantity INT COMMENT 'Количество реактива',    
    standards_id BIGINT UNSIGNED NOT NULL,
    
    INDEX (standards_id),
    INDEX reagents_reagent_name_quantity_idx(reagent_name, quantity),    
    FOREIGN KEY (standards_id) REFERENCES standards(id)
) COMMENT = 'Реактивы';
    
DROP TABLE IF EXISTS results;
CREATE TABLE results (    
    id SERIAL PRIMARY KEY,
    protocol_name VARCHAR(45),
    total_result DECIMAL(12, 4),
    staff_access_id BIGINT UNSIGNED NOT NULL,
    samples_id BIGINT UNSIGNED NOT NULL,
    standards_id BIGINT UNSIGNED NOT NULL,
    sample_types_id BIGINT UNSIGNED NOT NULL,
    instruments_id BIGINT UNSIGNED NOT NULL,
    indicators_id BIGINT UNSIGNED NOT NULL,
    date_analysis DATETIME DEFAULT NOW() COMMENT 'Дата анализа',
    
    INDEX idx_of_protocol_name(protocol_name),
    FOREIGN KEY (staff_access_id) REFERENCES staff_access(id),
    FOREIGN KEY (samples_id) REFERENCES samples(id),
    FOREIGN KEY (standards_id) REFERENCES standards(id),
    FOREIGN KEY (sample_types_id) REFERENCES sample_types(id),
    FOREIGN KEY (instruments_id) REFERENCES instruments(id),
    FOREIGN KEY (indicators_id) REFERENCES indicators(id)    
) COMMENT = 'Результаты измерений';    

DROP TABLE IF EXISTS validations;
CREATE TABLE validations (
    id SERIAL PRIMARY KEY,
    results_id BIGINT UNSIGNED NOT NULL,
    user_name VARCHAR(100), -- Имя начальника
    manual_comment ENUM('На рассмотрении', 'Утверждено', 'В переделке') NOT NULL DEFAULT 'На рассмотрении',     
    
    FOREIGN KEY (results_id) REFERENCES results(id)    
) COMMENT = 'Утверждение результатов';
