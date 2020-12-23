
DROP PROCEDURE IF EXISTS sp_common_types;
 
DELIMITER //

CREATE PROCEDURE sp_common_types (sample_id BIGINT)
BEGIN
	-- пробы одного типа
	SELECT s2.id 
	FROM samples s1 
	JOIN samples s2 ON s1.sample_types_id = s2.sample_types_id
	WHERE s1.id = sample_id AND s2.id != sample_id
UNION 
	-- пробы измеренные на одинаковом оборудовании
	SELECT r2.samples_id 
	FROM results r1 
	JOIN results r2 ON r1.instruments_id = r2.instruments_id
	WHERE r1.samples_id = sample_id AND r2.samples_id != sample_id;	
	
END //

-- триггер, на обязательную проверку подписи начальника
DROP TRIGGER IF EXISTS check_signature_before_insert //
CREATE TRIGGER check_signature_before_insert
BEFORE INSERT ON validations
FOR EACH ROW
BEGIN  
  IF NEW.user_name IS NULL IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'User_name cannot be NULL';
  END IF;
END //

DELIMITER ;

CALL sp_common_types(1);

