CREATE PROCEDURE challenge.employees_hired (@year INT = 2021)
AS
BEGIN TRY
	DECLARE @start_TIME_LOG DATETIME = getdate();

	WITH aux
	AS (
		SELECT dep.id AS dep_id
			,j.id AS job_id
			,sum(CASE 
					WHEN DatePart(quarter, hired.DATETIME) = 1
						THEN 1
					ELSE 0
					END) AS Q1
			,sum(CASE 
					WHEN DatePart(quarter, hired.DATETIME) = 2
						THEN 1
					ELSE 0
					END) AS Q2
			,sum(CASE 
					WHEN DatePart(quarter, hired.DATETIME) = 3
						THEN 1
					ELSE 0
					END) AS Q3
			,sum(CASE 
					WHEN DatePart(quarter, hired.DATETIME) = 4
						THEN 1
					ELSE 0
					END) AS Q4
		FROM [challenge].[hired_employees] AS hired
		LEFT JOIN [challenge].[departments] AS dep ON dep.id = hired.department_id
		LEFT JOIN [challenge].[jobs] AS j ON hired.job_id = j.id
		WHERE year(hired.DATETIME) = @year
		GROUP BY dep.id
			,j.id
		)
	SELECT COALESCE(dep.department,'Unknown department') as department
		,COALESCE(j.job, 'Unknown Job') as job
		,a.Q1
		,a.Q2
		,a.Q3
		,a.Q4
	FROM aux AS a
	LEFT JOIN [challenge].[departments] AS dep ON a.dep_id = dep.id
	LEFT JOIN [challenge].[jobs] AS j ON a.job_id = j.id
	ORDER BY department
		,job
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