CREATE DATABASE CorporateAffiliatesProgram;
GO

-- Use the CorporateAffiliatesProgram database
USE CorporateAffiliatesProgram;
GO

-- Create CareerServices Schema
CREATE SCHEMA CareerServices AUTHORIZATION dbo;
GO

-- Create Students Table in CareerServices Schema
CREATE TABLE CareerServices.Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EmailAddress NVARCHAR(100),
    Phone NVARCHAR(20),
    Major NVARCHAR(50),
    GraduationYear INT,
    ResumeFile VARBINARY(MAX)
);
GO

-- Create Employers Table in CareerServices Schema
CREATE TABLE CareerServices.Employers (
    EmployerID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName NVARCHAR(100),
    ContactPerson NVARCHAR(50),
    EmailAddress NVARCHAR(100),
    Phone NVARCHAR(20),
    Industry NVARCHAR(50),
    Location NVARCHAR(100)
);
GO

-- Create Job_Postings Table in CareerServices Schema
CREATE TABLE CareerServices.Job_Postings (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    EmployerID INT,
    Title NVARCHAR(100),
    Description NVARCHAR(255),
    PostedDate DATE,
    Deadline DATE,
    Location NVARCHAR(100),
    Salary DECIMAL(10,2),
    Requirements NVARCHAR(255),
    SkillRequired NVARCHAR(255),
    JobType NVARCHAR(50),
    FOREIGN KEY (EmployerID) REFERENCES CareerServices.Employers(EmployerID)
);
GO

-- Create Applications Table in CareerServices Schema
CREATE TABLE CareerServices.Applications (
    AppID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    JobID INT,
    AppliedDate DATE,
    Status NVARCHAR(50),
    FOREIGN KEY (StudentID) REFERENCES CareerServices.Students(StudentID),
    FOREIGN KEY (JobID) REFERENCES CareerServices.Job_Postings(JobID)
);
GO

-- Create Hires Table in CareerServices Schema
CREATE TABLE CareerServices.Hires (
    HiredID INT IDENTITY(1,1) PRIMARY KEY,
    AppID INT,
    StudentID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (AppID) REFERENCES CareerServices.Applications(AppID),
    FOREIGN KEY (StudentID) REFERENCES CareerServices.Students(StudentID)
);
GO

USE CorporateAffiliatesProgram;

INSERT INTO CareerServices.Students
VALUES ('Monica', 'Geller', 'mgeller2@u.pacific.edu', '888-000-0001', 'Marketing', 2023, 01),
('Ross', 'Geller', 'rgeller@u.pacific.edu', '888-000-0002', 'Science', 2023, 29),
('Rachel', 'Green', 'rgreen1@u.pacific.edu', '888-000-0003', 'Business', 2024, 44),
('Phoebe', 'Buffay', 'pbuffay14@u.pacific.edu', '888-000-0004', 'Finance', 2024, 13),
('Joey', 'Tribiani', 'jtribi3@u.pacific.edu', '888-000-0005', 'Theatre', 2023, 50),
('Chandler', 'Bing', 'cbing9@u.pacific.edu', '888-000-0006', 'Business', 2023, 60),
('Gunther', NULL, 'ggther@u.pacific.edu', '888-000-0007', 'Marketing', 2024, 34),
('Mike', 'Hannigan', 'mhannigan@u.pacific.edu', '888-000-0008', 'Finance', 2023, 24),
('Janice','Hosenstein', 'jhosen4@u.pacific.edu', '888-000-0009', 'Theatre', 2024, 22),
('Ursula','Buffay', 'ubuffay15@u.pacific.edu', '888-000-0010', 'Theatre', 2024, 15),
('Carole','Willick', 'cwillick8@u.pacific.edu', '888-000-0011', 'Science', 2023, 43);

SELECT * FROM CareerServices.Students;
---------------------------------------

INSERT INTO CareerServices.Employers
VALUES ('Amazon', 'Julie','jamz@amz.com','999-000-0001','Technology', 'Seattle, WA'),
('Goldman Sachs', 'Andrew','asach@gsachs.com','999-000-4511','Finance', 'New York, NY'),
('Walt Disney', 'Keria','kdland@disney.com','999-000-5674','Entertainment', 'Burbank, CA'),
('Johnson & Johnson', 'TJ','tj@jj.com','999-000-1243','Pharmaceutical', 'New Brunswick, NJ'),
('Warner Bros', 'Young','ybros@wbros.com','999-000-2255','Entertainment', 'Burbank, CA'),
('Tesla', 'Emusk','mla@elon.com','999-000-0099','Automotive & Technology', 'Austin, TX'),
('Moderna', 'Tobias','tmodern@mdn.com','999-098-7689','Pharmaceutical', 'Cambridge, MA'),
('JP Morgan', 'Xiaoyu','xy@chase.com','999-888-6666','Banking & Business', 'New York, NY'),
('PMG', 'Melisa','mel@pmg.com','999-124-0987','Marketing', 'Dallas, TX'),
('Nvdia', 'Hope','hhh099@nvd.com','999-123-7766','Technology', 'Santa Clara, CA');

SELECT * FROM CareerServices.Employers;
---------------------------------------

INSERT INTO CareerServices.Job_Postings
VALUES (6, 'Data Analyst', 'this is description for data analyst job', '2023-06-01', '2023-12-31','CA, NY, Remote', 6000.00, 
'Master Degree, 2 years experience', 'SQL, Python, R', 'Full Time'),
(8, 'Auditor', 'this is description for auditor job', '2023-07-01', '2023-10-31', 'NY, TX, CA, NJ, FL',4000.99, 
'Bachelor Degree', 'Excel, Accounting', 'Internship'),
(3, 'Director Assistant', 'this is description for director assistant job', '2023-06-01', '2023-11-01', 'CA', 3500.00, 
'0-2 years experience', 'Time management, Communication', 'Part Time'),
(4, 'Intern - Scientist', 'this is description for science intern job', '2023-06-10', '2023-12-31', 'NJ', 5500.00, 
'Master Degree or PhD', 'Chemical Engineering, Research, Analysis', 'Internship'),
(3, 'Marketing Associate', 'this is description for marketing associate job', '2023-09-01', '2024-02-20', 'CA', 3800.05, 
'Bachelor Degree', 'Time management, Communication, Microsoft Office', 'Full Time'),
(6, 'Data Scientist Intern', 'this is description for data science intern job', '2023-08-11', '2024-01-01', 'TX, Remote', 6999.99, 
'Master Degree', 'Data Engineering, Data Research, Data Analysis, Machine Learning, Python, Json', 'Internship'),
(7, 'Research Associate', 'this is description for research associate job', '2023-09-01', '2023-09-30', 'MA', 6500.00, 
'Master Degree or PhD, Knowledge of Pharmaceutical field', 'Chemical Engineering, Research, Analysis', 'Full Time'),
(8, 'Customer Value Banking Associate', 'this is description for banking associate job', '2023-08-16', '2024-01-31', 'NY, CA, MN, KY', 4999.99, 
'Bachelor Degree, 1 year experience', 'Microsoft Office, Quickbooks, Customer Service, Communication', 'Full Time'),
(1, 'Marketing Analyst', 'this is description for marketing analyst job', '2023-09-25', '2023-11-30', 'TX', 5100.99, 
'Bachelor or Master Degree', 'Excel, Analysis, Communication', 'Part Time'),
(10, 'Software Engineering', 'this is description for software engineering job', '2023-06-01', '2023-07-01', 'CA', 10999.00, 
'Master Degree, Machine Learning Certifications', 'AI, Research, Analysis, Analytics, Python, Programming, Machine Learning', 'Full Time'),
(6, 'UX Developer', 'this is description for UX developer job', '2023-07-16', '2023-11-30', 'Remote', 8889.00, 
'Bachelor or Master Degree, Proficiency in Python, Java', 'Python, Programming, Visualization', 'Full Time')
;

SELECT * FROM CareerServices.Job_Postings;
--------------------------------------

INSERT INTO CareerServices.Applications
VALUES (1, 3, '2023-06-01', 'Rejected'),
(2, 2, '2023-07-11', 'Hired'),
(1, 4, '2023-06-21', 'Rejected'),
(4, 2, '2023-08-31', 'Hired'),
(4, 11, '2023-09-08', 'Rejected'),
(6, 5, '2023-11-03', 'Review In Progress'),
(7, 6, '2023-10-10', 'Rejected'),
(8, 7, '2023-09-18', 'Hired'),
(9, 9, '2023-10-23', 'Review In Progress'),
(10, 10, '2023-06-10', 'Hired'),
(11, 8, '2023-08-21', 'Rejected'),
(1, 4, '2023-11-13', 'Review In Progress'),
(3, 5, '2023-09-29', 'Review In Progress'),
(9, 9, '2023-11-11', 'Review In Progress'),
(5, 6, '2023-08-21', 'Rejected'),
(10, 7, '2023-09-09', 'Hired'),
(8, 2, '2023-07-21', 'Rejected'),
(4, 6, '2023-08-31', 'Rejected'),
(3, 3, '2023-06-24', 'Hired'),
(11, 1, '2023-08-31', 'Review In Progress');

SELECT * FROM CareerServices.Applications;
--------------------------------------------------

INSERT INTO CareerServices.Hires
VALUES (2, 2, '2024-06-01', '2024-08-31'),
(4, 4, '2024-05-16', '2024-07-31'),
(8, 8, '2024-02-02', NULL),
(10, 10, '2024-10-01', NULL),
(16, 10, '2024-05-30', '2024-08-30'),
(19, 3, '2024-01-03', NULL);

SELECT * FROM CareerServices.Hires;
