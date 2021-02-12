CREATE DEFINER=`root`@`localhost` PROCEDURE `export_tables`(IN toPath VARCHAR(250))
BEGIN
	-- ----------------------------------------------------------------------------------
    -- Create CSV files with the column names of all empty files.
    -- This allows us to make sure that all fields are included when we create test data.
    -- ----------------------------------------------------------------------------------
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE tblName VARCHAR(50) DEFAULT "";
    DECLARE fullPath VARCHAR(300) DEFAULT "";
        
	DECLARE curTblNames 
	CURSOR FOR 			
		SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_SCHEMA = 'salaroo_uk_pension_test' AND TABLE_ROWS = 0;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN curTblNames;    
    createFiles: LOOP
		FETCH curTblNames INTO tblName;        
        IF finished = 1 THEN LEAVE createFiles; END IF;
        
        SET @allCols = 
			(SELECT GROUP_CONCAT(CONCAT("'",COLUMN_NAME,"'"))
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = tblName
				AND TABLE_SCHEMA = 'salaroo_uk_pension_test'
				ORDER BY ORDINAL_POSITION);        
   
        SET @fullPath = 
			concat("SELECT ", @allCols, " UNION ALL SELECT ", @allCols, 
            " INTO OUTFILE '", toPath, tblName, ".csv'",
			" FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' FROM salaroo_uk_pension_test." , tblName);

		PREPARE createFiles FROM @fullPath;
		EXECUTE createFiles;DEALLOCATE PREPARE createFiles;
       
    END LOOP createFiles;    
END