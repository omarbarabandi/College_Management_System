
use university;
set FOREIGN_KEY_CHECKS = 0;
DROP TABLE if EXISTS user;
DROP TABLE if EXISTS student;
DROP TABLE if EXISTS sysAdmin;
DROP TABLE if EXISTS gradSecretary;
DROP TABLE if EXISTS facultyInstructors;
DROP TABLE if EXISTS semester;
DROP TABLE if EXISTS school;
DROP TABLE if EXISTS degree;
DROP TABLE if EXISTS major;
DROP TABLE if EXISTS course;
DROP TABLE if EXISTS section;
DROP TABLE if EXISTS meetingDetails;
DROP TABLE if EXISTS studentRecords;
DROP TABLE if EXISTS prereqs;

CREATE TABLE user (
    email VARCHAR(100),
    username VARCHAR(100),
    password VARCHAR(100),
    firstname VARCHAR(1000),
    lastname VARCHAR(1000),
    address VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    zip VARCHAR(100),
    country VARCHAR(100),
    phone VARCHAR(100),
    dob DATE,
    ssn VARCHAR(100),
    gender VARCHAR(100),
    pronouns VARCHAR(100),
    race VARCHAR(100),
    universityid INTEGER(8) NOT NULL,
    PRIMARY KEY (universityid),
    UNIQUE (email),
    UNIQUE(username)
);

DROP TABLE IF EXISTS student;

CREATE TABLE student (
    user INTEGER NOT NULL,
    status VARCHAR(15),
    armedforcesstatus VARCHAR(15),
    hispanicstatus VARCHAR(15),
    language VARCHAR(15),
    birthcountry VARCHAR(20),
    birthcity VARCHAR(20),
    birthstate VARCHAR(15),
    citizenstatus VARCHAR(15),
    hourscompleted INTEGER,
    hoursinprogress INTEGER,
    degreepercentage INTEGER,
    classification VARCHAR(8),
    rdygrad BOOLEAN,
    advisorid INTEGER,
    PRIMARY KEY (user),
    FOREIGN KEY(user) REFERENCES user (universityid)
);
DROP TABLE IF EXISTS applications;
CREATE TABLE applications (
    UID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Password VARCHAR(255),
    Address VARCHAR(255),
    SSN VARCHAR(255),
    DegreeSought VARCHAR(255),
    AdmissionDate DATE,
    Status VARCHAR(255),
    FOREIGN KEY (UID) REFERENCES user(universityid)
);

DROP TABLE IF EXISTS advisor;
CREATE TABLE advisor (
    user INTEGER NOT NULL,
    FOREIGN KEY(user) REFERENCES user (universityid)
);


DROP TABLE IF EXISTS sysAdmin;

CREATE TABLE sysAdmin (
    user INTEGER NOT NULL,
    FOREIGN KEY(user) REFERENCES user (universityid)
);

DROP TABLE IF EXISTS gradSecretary;

CREATE TABLE gradSecretary (
    user INTEGER NOT NULL,
    FOREIGN KEY(user) REFERENCES user (universityid)
);

DROP TABLE IF EXISTS facultyInstructors;

CREATE TABLE facultyInstructors (
    user INTEGER NOT NULL,
    FOREIGN KEY(user) REFERENCES user (universityid)
);
CREATE TABLE semester (
    id INTEGER NOT NULL,
    name VARCHAR(15) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
CREATE TABLE school (
    id INTEGER NOT NULL,
    name VARCHAR(15) NOT NULL,
    abbreviation VARCHAR(4) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name),
    UNIQUE (abbreviation)
);
CREATE TABLE degree (
    id INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
CREATE TABLE major (
    id INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
CREATE TABLE course (
    id INTEGER NOT NULL,
    type VARCHAR(10),
    department VARCHAR(50),
    number VARCHAR(50),
    title VARCHAR(50),
    hours INTEGER,
    description TEXT,
    PRIMARY KEY (id)
);
CREATE TABLE section (
    crn INTEGER NOT NULL,
    number INTEGER,
    course INTEGER NOT NULL,
    semester VARCHAR(15),
    professor INTEGER,
    studentsEnrolled INTEGER,
    seatsAvailable INTEGER,
    waitlist INTEGER,
    waitlistmax INTEGER,
    PRIMARY KEY (crn, course),
    FOREIGN KEY(course) REFERENCES course (id),
    FOREIGN KEY(professor) REFERENCES facultyInstructors (user)
);
CREATE TABLE meetingDetails (
    id INTEGER NOT NULL,
    day VARCHAR(10) NOT NULL,
    starttime INTEGER NOT NULL,
    endtime INTEGER NOT NULL,
    building VARCHAR(50),
    campus VARCHAR(50),
    room VARCHAR(50),
    FOREIGN KEY (id) REFERENCES section (crn)
);
CREATE TABLE studentRecords (
    student INTEGER NOT NULL,
    section INTEGER,
    course INTEGER NOT NULL,
    semester VARCHAR(50),
    finalgrade VARCHAR(4),
    FOREIGN KEY(student) REFERENCES student (user),
    FOREIGN KEY(section) REFERENCES section (crn),
    FOREIGN KEY(course) REFERENCES course (id)
);
CREATE TABLE prereqs(
    crn INTEGER NOT NULL,
    prereq1 INTEGER NOT NULL,
    prereq2 INTEGER,
    FOREIGN KEY(crn) REFERENCES course(id),
    FOREIGN KEY(prereq1) REFERENCES course(id),
    FOREIGN KEY(prereq2) REFERENCES course(id),
    PRIMARY KEY(crn)
);
--ADS
DROP TABLE IF EXISTS alumni;
CREATE TABLE alumni(
    UID INT,
    FOREIGN KEY (UID) REFERENCES user(universityid)
);
DROP TABLE IF EXISTS form1;
CREATE TABLE form1(
  UID   INTEGER(8) NOT NULL,
  department VARCHAR(50),
  number  INTEGER, 
  foreign key(UID) references user(universityid),
    --FOREIGN KEY (department) REFERENCES course(department),
    FOREIGN KEY(number) REFERENCES course(id)
);
DROP TABLE IF EXISTS thesis;
CREATE TABLE thesis(
  thesis LONGTEXT,
  uid INTEGER,
  decision BOOLEAN,
  FOREIGN KEY (uid) REFERENCES student(user)
);
--APPS
--SEPERATE

DROP TABLE IF EXISTS Academic_Information;
CREATE TABLE Academic_Information (
    --ID INT PRIMARY KEY AUTO_INCREMENT,
    UID INT PRIMARY KEY,
    Degree VARCHAR(255),
    YearOfGraduation YEAR,
    GPA FLOAT,
    University VARCHAR(255),
    FOREIGN KEY (UID) REFERENCES Applicants (UID)
);
DROP TABLE IF EXISTS GRE_Scores;
CREATE TABLE GRE_Scores (
    --ID INT PRIMARY KEY AUTO_INCREMENT,
    UID INT PRIMARY KEY,
    VerbalScore INT,
    QuantitativeScore INT,
    SubjectScore INT,   
    YearOfExam YEAR,
    FOREIGN KEY (UID) REFERENCES Applicants (UID)
);
DROP TABLE IF EXISTS Work_Experience;
CREATE TABLE Work_Experience (
    --ID INT PRIMARY KEY AUTO_INCREMENT,
    UID INT PRIMARY KEY,
    Experience TEXT,
    FOREIGN KEY (UID) REFERENCES Applicants (UID)
);
DROP TABLE IF EXISTS Transcripts;
CREATE TABLE Transcripts (
    -- ID INT PRIMARY KEY AUTO_INCREMENT,
    UID INT PRIMARY KEY,
    TranscriptReceivedStatus BOOLEAN,
    FOREIGN KEY (UID) REFERENCES Applicants (UID)
);
DROP TABLE IF EXISTS RecommendationLetters;
CREATE TABLE RecommendationLetters (
    -- ID INT PRIMARY KEY AUTO_INCREMENT,
    UID INT PRIMARY KEY,
    LetterWriterName VARCHAR(255),
    LetterWriterEmail VARCHAR(255),
    LetterWriterTitle VARCHAR(255),
    LetterWriterAffiliation VARCHAR(255),
    LetterRequestEmailSentStatus BOOLEAN,
    LetterReceivedStatus BOOLEAN,
    RecommendationRating INT,
    GenericRating BOOLEAN,
    CredibilityRating BOOLEAN,
    RecommendationComments TEXT,
    FOREIGN KEY (UID) REFERENCES Applicants (UID)
);
DROP TABLE IF EXISTS Reviewers;
CREATE TABLE Reviewers (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ReviewerName VARCHAR(255),
    ReviewerEmail VARCHAR(255),
    Password VARCHAR(255),
    user INTEGER NOT NULL,
    FOREIGN KEY(user) REFERENCES user (universityid)
);

DROP TABLE IF EXISTS Committee;
CREATE TABLE Committee (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    CommitteeMemberName VARCHAR(255),
    CommitteeMemberEmail VARCHAR(255),
    user INTEGER NOT NULL,
    FOREIGN KEY(user) REFERENCES user (universityid)
);

CREATE TABLE CommitteeReviewForms (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ReviewFormID INT,
    CommitteeID INT,
    CommitteeReviewComments TEXT,
    FinalDecision VARCHAR(255),
    FOREIGN KEY (ReviewFormID) REFERENCES ReviewForms (ID),
    FOREIGN KEY (CommitteeID) REFERENCES Committee (ID)
);

DROP TABLE IF EXISTS ReviewForms;
CREATE TABLE ReviewForms (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    UID INT,
    ReviewerID INT,
    ReviewerComments TEXT,
    RecommendationRating INT,
    FOREIGN KEY (UID) REFERENCES applications (UID),
    FOREIGN KEY (ReviewerID) REFERENCES Reviewers (ID)
);
-- DROP TABLE IF EXISTS Committee;
-- CREATE TABLE Committee (
--     ID INT PRIMARY KEY AUTO_INCREMENT,
--     CommitteeMemberName VARCHAR(255),
--     CommitteeMemberEmail VARCHAR(255)
-- -- );
-- DROP TABLE IF EXISTS CommitteeReviewForms;
-- CREATE TABLE CommitteeReviewForms (
--     ID INT PRIMARY KEY AUTO_INCREMENT,
--     ReviewFormID INT,
--     CommitteeID INT,
--     CommitteeReviewComments TEXT,
--     FinalDecision VARCHAR(255),
--     FOREIGN KEY (ReviewFormID) REFERENCES ReviewForms (ID),
--     FOREIGN KEY (CommitteeID) REFERENCES Committee (ID)
-- );

-- testing for APP




INSERT INTO user (email, username, password, firstname, lastname, address, city, state, zip, country, phone, dob, ssn, gender, pronouns, race, universityid) VALUES ('sysadmin1@example.com', 'sysAdmin1', 'password123', 'John', 'Smith', '123 Main St', 'New York', 'NY', '10001', 'USA', '555-123-4567', '1980-01-01', '123-45-6789', 'Male', 'he/him', 'White', 10000001);
INSERT INTO user (email, username, password, firstname, lastname, address, city, state, zip, country, phone, dob, ssn, gender, pronouns, race, universityid) VALUES ('facultyrev1@example.com', 'facultyReviewer1', 'password456', 'Jane', 'Doe', '456 Elm St', 'Los Angeles', 'CA', '90001', 'USA', '555-987-6543', '1975-02-15', '234-56-7890', 'Female', 'she/her', 'Asian', 10000002);
INSERT INTO user (email, username, password, firstname, lastname, address, city, state, zip, country, phone, dob, ssn, gender, pronouns, race, universityid) VALUES ('chaircom1@example.com', 'chairOfCommittee1', 'password789', 'James', 'Brown', '789 Oak St', 'Chicago', 'IL', '60601', 'USA', '555-111-2233', '1965-03-20', '345-67-8901', 'Male', 'he/him', 'Black', 10000003);
INSERT INTO user (email, username, password, firstname, lastname, address, city, state, zip, country, phone, dob, ssn, gender, pronouns, race, universityid) VALUES ('applicant1@example.com', 'applicant1', 'password321', 'Emily', 'Johnson', '321 Pine St', 'Houston', 'TX', '77001', 'USA', '555-444-5555', '1990-04-25', '456-78-9012', 'Female', 'she/her', 'Hispanic', 10000004);
INSERT INTO user (email, username, password, firstname, lastname, address, city, state, zip, country, phone, dob, ssn, gender, pronouns, race, universityid) VALUES ('sysadmin2@example.com', 'sysAdmin2', 'password124', 'Michael', 'Williams', '125 Main St', 'Philadelphia', 'PA', '19019', 'USA', '555-222-3333', '1982-05-10', '567-89-0123', 'Male', 'he/him', 'White', 10000005);
INSERT INTO sysAdmin (user) VALUES (10000001);
INSERT INTO sysAdmin (user) VALUES (10000005);
INSERT INTO Committee (CommitteeMemberName, CommitteeMemberEmail) VALUES ('James Brown', 'chaircom1@example.com');
INSERT INTO applications (UID, FirstName, LastName, Email, Password, Address, SSN, DegreeSought, AdmissionDate, Status) VALUES (10000004, 'Emily', 'Johnson', 'applicant1@example.com', 'password321', '321 Pine St', '456-78-9012', 'Master', '2023-08-23', 'Pending');
INSERT INTO Reviewers (ReviewerName, ReviewerEmail, Password) VALUES ('Jane Doe', 'facultyrev1@example.com', 'password456');

-- Delete previous records in the Reviewers and Committee tables
DELETE FROM Reviewers WHERE ReviewerEmail = 'facultyrev1@example.com';
DELETE FROM Committee WHERE CommitteeMemberEmail = 'chaircom1@example.com';

-- Delete previous records in the user table
DELETE FROM user WHERE email = 'facultyrev1@example.com';
DELETE FROM user WHERE email = 'chaircom1@example.com';

-- Insert Jane Doe into the user table
INSERT INTO user (email, username, password, firstname, lastname) VALUES ('facultyrev1@example.com', 'janedoe', 'password456', 'Jane', 'Doe');

-- Insert Jane Doe into the Reviewers table using the universityid of the last inserted user
INSERT INTO Reviewers (ReviewerName, ReviewerEmail, Password, user) VALUES ('Jane Doe', 'facultyrev1@example.com', 'password456', 10000002);

-- Insert James Brown into the user table
INSERT INTO user (email, username, password, firstname, lastname, universityid) VALUES ('chaircom1@example.com', 'jamesbrown', 'password789', 'James', 'Brown', 10000003);

-- Insert James Brown into the Committee table using the universityid of the last inserted user
INSERT INTO Committee (CommitteeMemberName, CommitteeMemberEmail, user) VALUES ('James Brown', 'chaircom1@example.com', 10000003);
-- Delete James Brown from the Committee table
DELETE FROM Committee WHERE CommitteeMemberEmail = 'chaircom1@example.com';

-- Delete James Brown from the user table
DELETE FROM user WHERE email = 'chaircom1@example.com';





-- END -------------------------------------------------




INSERT INTO user (email, username, password, firstname, lastname, address, city, state, zip, country, phone, dob, ssn, gender, pronouns, race, universityid) VALUES ('bn@gwu.edu', 'bhaguser', 'bhagpass', 'Bhagirath', 'Narahari', '123 Elm St', 'Anytown', 'CA', '90001', 'USA', '555-123-4567', '1990-05-22', '123-45-6789', 'Male', 'he/him', 'White', 3);
INSERT INTO user (email, username, password, firstname, lastname, address, city, state, zip, country, phone, dob, ssn, gender, pronouns, race, universityid) VALUES ('hc@gwu.edu', 'hyeonguser', 'hyeongpass', 'Hyeong-Ah', 'Choi', '123 Elm St', 'Anytown', 'CA', '90001', 'USA', '555-123-4567', '1990-05-22', '123-45-6789', 'Male', 'he/him', 'White', 4);

INSERT INTO student (user, status, armedforcesstatus, hispanicstatus, language, birthcountry, birthcity, birthstate, citizenstatus, hourscompleted, hoursinprogress, degreepercentage, classification)
VALUES (10000001, 'Active', 'None', 'No', 'English', 'USA', 'New York', 'NY', 'Citizen', 0, 0, 0, 'Freshman');

NSERT INTO user (email, username, password, firstname, lastname, universityid)
VALUES ('applicant@example.com', 'applicant', 'password123', 'John', 'Doe', 1);

INSERT INTO applications (UID, FirstName, LastName, Email, Password, Status)
VALUES (1, 'John', 'Doe', 'applicant@example.com', 'password123', 'Pending');

INSERT INTO facultyInstructors (user) VALUES (3);

INSERT INTO facultyInstructors (user) VALUES (4);

INSERT INTO semester (id, name) VALUES (1, 'Spring 2023');
INSERT INTO semester (id, name) VALUES (2, 'Summer 2023');
INSERT INTO semester (id, name) VALUES (3, 'Fall 2023');

INSERT INTO course (id, type, department, number, title, hours, description) VALUES (1, 'Lecture', 'CSCI', '6221', 'SW Paradigms', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (2, 'Lecture', 'CSCI', '6461', 'Computer Architecture', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (3, 'Lecture', 'CSCI', '6212', 'Algorithms', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (4, 'Lecture', 'CSCI', '6232', 'Networks 1', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (5, 'Lecture', 'CSCI', '6233', 'Networks 2', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (6, 'Lecture', 'CSCI', '6241', 'Database 1', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (7, 'Lecture', 'CSCI', '6242', 'Database 2', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (8, 'Lecture', 'CSCI', '6246', 'Compilers', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (9, 'Lecture', 'CSCI', '6251', 'Cloud Computing', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (10, 'Lecture', 'CSCI', '6254', 'SW Engineering', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (11, 'Lecture', 'CSCI', '6260', 'Multimedia', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (12, 'Lecture', 'CSCI', '6262', 'Graphics 1', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (13, 'Lecture', 'CSCI', '6283', 'Security 1', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (14, 'Lecture', 'CSCI', '6284', 'Cryptography', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (15, 'Lecture', 'CSCI', '6286', 'Network Security', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (16, 'Lecture', 'CSCI', '6384', 'Cryptography 2', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (17, 'Lecture', 'ECE', '6241', 'Communication Theory', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (18, 'Lecture', 'ECE', '6242', 'Information Theory', 2, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (19, 'Lecture', 'MATH', '6210', 'Logic', 2, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (20, 'Lecture', 'CSCI', '6339', 'Embedded Systems', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (21, 'Lecture', 'CSCI', '6220', 'Machine Learning', 3, '');
INSERT INTO course (id, type, department, number, title, hours, description) VALUES (22, 'Lecture', 'CSCI', '6325', 'Algorithms 2', 3, '');



INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (1, 1, 1, 'Spring 2023', 3, 25, 30, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (2, 1, 2, 'Spring 2023', 3, 30, 40, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (3, 1, 3, 'Spring 2023', 4, 25, 30, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (4, 1, 4, 'Spring 2023', 3, 30, 30, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (5, 1, 5, 'Spring 2023', 3, 25, 35, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (6, 1, 6, 'Spring 2023', 3, 27, 30, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (7, 1, 7, 'Spring 2023', 3, 23, 25, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (8, 1, 8, 'Spring 2023', 3, 30, 50, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (9, 1, 9, 'Spring 2023', 3, 25, 35, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (10, 1, 10, 'Spring 2023', 3, 30, 35, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (11, 1, 11, 'Spring 2023', 3, 25, 30, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (12, 1, 12, 'Spring 2023', 3, 30, 34, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (13, 1, 13, 'Spring 2023', 3, 28, 35, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (14, 1, 14, 'Spring 2023', 3, 27, 30, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (15, 1, 15, 'Spring 2023', 3, 18, 20, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (16, 1, 16, 'Spring 2023', 3, 20, 25, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (17, 1, 17, 'Spring 2023', 3, 15, 20, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (18, 1, 18, 'Spring 2023', 3, 30, 30, 0, 10);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (19, 1, 19, 'Spring 2023', 3, 25, 25, 0, 5);
INSERT INTO section (crn, number, course, semester, professor, studentsEnrolled, seatsAvailable, waitlist, waitlistmax) VALUES (20, 1, 20, 'Spring 2023', 3, 30, 30, 0, 10);



INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (1, 'Monday', 1500, 1730, 'Building A', 'Main Campus', 'A101');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (2, 'Tuesday', 1500, 1730, 'Building A', 'Main Campus', 'A101');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (3, 'Wednesday', 1500, 1730, 'Building B', 'Main Campus', 'B201');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (4, 'Monday', 1800, 2030, 'Building B', 'Main Campus', 'B201');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (5, 'Tuesday', 1800, 2030, 'Building C', 'Main Campus', 'C301');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (6, 'Wednesday', 1800, 2030, 'Building A', 'Main Campus', 'A101');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (7, 'Thursday', 1800, 2030, 'Building A', 'Main Campus', 'A101');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (8, 'Tuesday', 1500, 1730, 'Building B', 'Main Campus', 'B201');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (9, 'Monday', 1800, 2030, 'Building B', 'Main Campus', 'B201');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (10, 'Monday', 1530, 1800, 'Building C', 'Main Campus', 'C301');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (11, 'Thursday', 1800, 2030, 'Building A', 'Main Campus', 'A101');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (12, 'Wednesday', 1800, 2030, 'Building A', 'Main Campus', 'A101');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (13, 'Tuesday', 1800, 2030, 'Building B', 'Main Campus', 'B201');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (14, 'Monday', 1800, 2030, 'Building B', 'Main Campus', 'B201');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (15, 'Wednesday', 1800, 2030, 'Building C', 'Main Campus', 'C301');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (16, 'Wednesday', 1500, 1730, 'Building A', 'Main Campus', 'A101');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (17, 'Monday', 1800, 2030, 'Building A', 'Main Campus', 'A101');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (18, 'Tuesday', 1800, 2030, 'Building B', 'Main Campus', 'B201');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (19, 'Wednesday', 1800, 2030, 'Building B', 'Main Campus', 'B201');
INSERT INTO meetingDetails (id, day, starttime, endtime, building, campus, room) VALUES (20, 'Thursday', 1600, 1830, 'Building C', 'Main Campus', 'C301');
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (5, 4, NULL);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (7, 6, NULL);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (10, 1, NULL);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (15, 13, 4);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (8, 2, 3);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (9, 2, NULL);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (13, 3, NULL);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (14, 3, NULL);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (20, 2, 3);
INSERT INTO prereqs (crn, prereq1, prereq2) VALUES (16, 14, NULL);



INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,1,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,2,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,3,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,4,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,5,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,6,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,7,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,8,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,9,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,10,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,11,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,12,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,13,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,14,'Spring 2023','A');
INSERT INTO studentRecords (student, section, course, semester, finalgrade) VALUES (10000001,1,15,'Spring 2023','A');
