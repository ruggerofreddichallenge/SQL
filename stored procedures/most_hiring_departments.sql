CREATE PROCEDURE challenge.most_hiring_departments (@year INT = 2021)
AS
BEGIN TRY
	DECLARE @start_TIME_LOG DATETIME = getdate()
	DECLARE @employees_count INT = (
			SELECT count(id)
			FROM [challenge].[hired_employees]
			WHERE year(DATETIME) = @year
			);
	DECLARE @departments_count INT = (
			SELECT count(DISTINCT department_id)
			FROM [challenge].[hired_employees]
			WHERE year(DATETIME) = @year
			);

	WITH departments_selected
	AS (
		SELECT department_id
			,count(id) AS hired
		FROM challenge.hired_employees
		WHERE year(DATETIME) = @year
		GROUP BY department_id
		HAVING count(id) > @employees_count / @departments_count
		)
	SELECT dep_sel.department_id AS id
		,dep.department
		,dep_sel.hired
	FROM departments_selected AS dep_sel
	JOIN [challenge].[departments] AS dep ON dep_sel.department_id = dep.id
	ORDER BY hired DESC
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