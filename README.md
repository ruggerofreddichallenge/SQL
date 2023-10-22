# sql
**Schema:**
- schema: the schema containing tables and stored procedures.

**Tables:**
- departments: data from departments.csv.
  - Primary Key: id
- jobs: data from jobs.csv.
  - Primary Key: id
- hired_employees: data from hired_employees.csv.
  - Primary Key: id
  - Foreign Key: department_id on departments.id
  - Foreign Key: job_id on jobs.id

**Stored Procedure:**
- delete_all_tables:
  - empties tables departments, jobs and hired_employees.
- employees_hired: answers to point one of question two.
  - Parameters: year (default value 2021).
- most_hiring_departments: answers to point two of question two.
  - Parameters: year (default value 2021).

**Important Note:** on table hired_employees there are missing values for the department_id and the job_id. Stored Procedure employees_hired will expose 'Unknown department' and 'Unknown Job' whenever the respective value will not be available.

  
