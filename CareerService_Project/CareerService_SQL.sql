/*Career Service Project
Anh Ta (989446104)
Minhue He (989439989)
Xiaoyu Lyu (989456897)*/

USE CorporateAffiliatesProgram;

--Q1: Return a list of students that were hired in the past month. Return details on the positions.
CREATE PROCEDURE spStudentsHiredPastMonth
AS
BEGIN
    DECLARE @PastMonth DATE = DATEADD(MONTH, -1, GETDATE());

    SELECT s.FirstName, s.LastName, j.Title, h.StartDate, h.EndDate
    FROM CareerServices.Students s
    INNER JOIN CareerServices.Applications a ON s.StudentID = a.StudentID
    INNER JOIN CareerServices.Hires h ON a.AppID = h.AppID
    INNER JOIN CareerServices.Job_Postings j ON a.JobID = j.JobID
    WHERE h.StartDate >= @PastMonth;
END;

----example----
EXEC spStudentsHiredPastMonth;

/*Q2:Write a script that creates a stored procedure named spInsertJobPosting that inserts a row into the job posting table. 
If the value for the salary column is a negative number, the stored procedure should return a message indicating this number does not exist.*/
GO
CREATE PROC spInsertJobPosting
    @EmployerID INT,
    @Title NVARCHAR(100),
    @Description NVARCHAR(255),
    @PostedDate DATE,
    @Deadline DATE,
    @Location NVARCHAR(100),
    @Salary DECIMAL(10,2),
    @Requirements NVARCHAR(255),
    @SkillRequired NVARCHAR(255),
    @JobType NVARCHAR(50)
AS
IF @Salary < 0
PRINT 'This number does not exist'
BEGIN 
      INSERT INTO CareerServices.Job_Postings
	  VALUES (@EmployerID, @Title, @Description, @PostedDate, @Deadline, @Location,
            @Salary, @Requirements, @SkillRequired, @JobType);
END;

----example----
EXEC spInsertJobPosting 
    @EmployerID = 3,
    @Title = 'Business Analytics',
    @Description = 'This is description for business analytics intern job',
    @PostedDate = '2023-09-01',
    @Deadline ='2023-12-30',
    @Location = 'CA',
    @Salary = 7000,
    @Requirements = 'Master Degree',
    @SkillRequired = 'SQL,Python',
    @JobType = 'Part Time';

/* Q3: Given the job location and skill required, return the employer name, job title, job description, salary, requirements, job location, and deadline to apply.
Requirements: 
1. It should return current job positions that are open for application if both job location and skill required exists (Deadline > Current Date)
2. It should show an error message if both Location and Skill are not entered
3. It should show error message if Location or Skill does not exist in dataset
4. If Location is not entered, should return all jobs that have Skill entered
5. If Skill is not entered, should return all jobs that is in the given Location
*/

CREATE PROC spLocationSkill
	@location VARCHAR(20) = NULL,
	@skill VARCHAR(50) = NULL
AS
	IF @location IS NULL AND @skill IS NULL
		THROW 50001, 'Please provide either a location or a skill', 1 

	IF NOT EXISTS (SELECT Location FROM CareerServices.Job_Postings WHERE Location LIKE '%' + ISNULL(@location, '') + '%') 
		--ISNULL(@location, '') is used to handle empty string
		THROW 50002, 'There is no jobs available in the selected location', 2

	IF NOT EXISTS (SELECT SkillRequired FROM CareerServices.Job_Postings WHERE SkillRequired LIKE '%' + ISNULL(@skill, '') + '%')
		--ISNULL(@skill, '') is used to handle empty string
       	THROW 50003, 'There is no jobs available with the skill entered', 3
	BEGIN
		IF @location IS NULL
			SELECT *
                FROM CareerServices.Job_Postings
                WHERE SkillRequired LIKE '%' + @skill + '%';
            ELSE IF @skill IS NULL
                SELECT *
                FROM CareerServices.Job_Postings
                WHERE Location LIKE '%' + @location + '%';
            ELSE
                SELECT CompanyName AS 'Company', Title AS 'Job Title', Description AS 'Job Description', Salary, Requirements, j.Location, Deadline AS 'Deadline To Apply'
                FROM CareerServices.Employers e
                LEFT JOIN CareerServices.Job_Postings j ON e.EmployerID = j.EmployerID
                WHERE j.Location LIKE '%' + @location + '%'
                AND SkillRequired LIKE '%' + @skill + '%'
                AND Deadline >= GETDATE()
END;

----example----
EXEC spLocationSkill 
--@skill and @location are not entered, should return error message

EXEC spLocationSkill 'NY' 
--no @skill entered, should return CareerServices.Job_Postings table with all jobs that have @skill in SkillRequired

EXEC spLocationSkill @skill = 'Python' 
--no @location entered, should return CareerServices.Job_Postings table with all jobs that have @location in Location

EXEC spLocationSkill 'NY', 'Word'
--because ‘Word’ is not in SkillRequired of any jobs in the dataset, should return an error message

EXEC spLocationSkill 'AK', 'Python'
--because ‘AK’ is not in Location of any jobs in the dataset, should return an error message

EXEC spLocationSkill 'Remote', 'SQL'


