CREATE TABLE log_table (
	[KeyLog] [bigint] IDENTITY(1, 1) NOT NULL CONSTRAINT PK_KeyLog PRIMARY KEY CLUSTERED
	,[SchemaProc] [nvarchar](100) NULL
	,[ProcName] [nvarchar](100) NULL
	,[ExecStatus] [int] NULL
	,[SQL_ERROR_LINE] [int] NULL
	,[SQL_ERROR_MESSAGE] [nvarchar](4000) NULL
	,[SQL_ERROR_NUMBER] [int] NULL
	,[SQL_ERROR_PROCEDURE] [nvarchar](128) NULL
	,[SQL_ERROR_SEVERITY] [int] NULL
	,[SQL_ERROR_STATE] [int] NULL
	,[StartDate] [datetime] NULL
	,[EndDate] [datetime] NULL
	)