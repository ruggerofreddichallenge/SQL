CREATE PROCEDURE challenge.delete_all_tables
AS
BEGIN TRY
	DECLARE @start_TIME_LOG DATETIME = getdate();

	DELETE challenge.hired_employees

	DELETE challenge.jobs

	DELETE challenge.departments
END TRY

BEGIN CATCH
	INSERT INTO log_table (
		ProcName
		,SchemaProc
		,ExecStatus
		,SQL_ERROR_LINE
		,SQL_ERROR_MESSAGE
		,SQL_ERROR_NUMBER
		,SQL_ERROR_PROCEDURE
		,SQL_ERROR_SEVERITY
		,SQL_ERROR_STATE
		,StartDate
		,EndDate
		)
	SELECT OBJECT_NAME(@@PROCID)
		,OBJECT_SCHEMA_NAME(@@PROCID)
		,- 1
		,ERROR_LINE()
		,ERROR_MESSAGE()
		,ERROR_NUMBER()
		,ERROR_PROCEDURE()
		,ERROR_SEVERITY()
		,ERROR_STATE()
		,@start_TIME_LOG
		,getdate();
END CATCH