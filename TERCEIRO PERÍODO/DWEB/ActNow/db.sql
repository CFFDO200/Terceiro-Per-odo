/*DELIMITER $$
CREATE function extrairParametros(parametros Varchar(1000), numparametro int) RETURNS VARCHAR(100)
BEGIN
    DECLARE i INT DEFAULT 0;
    declare parametro Varchar(100);
    if numparametro==1 then
        SET parametro = LEFT(parametros,LOCATE(',', parametros)-1);
    else
        WHILE i <= numparametro DO
            if i=numparametro then
                SET parametro = LEFT(parametros,LOCATE(',', parametros)-1);
                leave;
            else
                set parametros = RIGHT(parametros,LENGTH(parametros) - LOCATE(',', parametros)+2);
            end if;
            SET i = i + 1;
        END WHILE;
    end if;
    return parametro;
END$$
DELIMITER ;
*/
DELIMITER $$

CREATE FUNCTION extrairParametros(parametros VARCHAR(1000), numparametro INT) RETURNS VARCHAR(100)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE parametro VARCHAR(100);
    
    IF numparametro = 1 THEN
        SET parametro = LEFT(parametros, LOCATE(',', parametros) - 1);
    ELSE
        WHILE i <= numparametro DO
            IF i = numparametro THEN
                SET parametro = LEFT(parametros, LOCATE(',', parametros) - 1);
                LEAVE;
            ELSE
                SET parametros = SUBSTRING(parametros, LOCATE(',', parametros) + 1);
            END IF;
            SET i = i + 1;
        END WHILE;
    END IF;
    
    RETURN parametro;
END$$

DELIMITER ;
