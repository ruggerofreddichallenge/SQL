CREATE TABLE challenge.hired_employees (
	id INT CONSTRAINT PK_id_hired_employees PRIMARY KEY CLUSTERED
	,name NVARCHAR(50)
	,[datetime] DATETIME
	,department_id INT FOREIGN KEY REFERENCES challenge.departments(id)
	,job_id INT FOREIGN KEY REFERENCES challenge.jobs(id)
	)