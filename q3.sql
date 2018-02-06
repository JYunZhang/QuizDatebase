--Compute the grade and total score on quiz Pr1-220310 for every student in the 
--grade 8 class in room 120 with Mr Higgins. Report the student number, last name, and total grade.

drop table if exists q3 cascade;

create table q3(
sid BIGINT,
lname VARCHAR(50),
totalGrade INT
);

DROP VIEW IF EXISTS getClass CASCADE;
DROP VIEW IF EXISTS getStudent CASCADE;
DROP VIEW IF EXISTS question_weight CASCADE;
DROP VIEW IF EXISTS getScore CASCADE;

-- Find the class id of the class room 120 and grade 8.
CREATE VIEW getClass as
SELECT id as cid FROM Class WHERE roomName = 'room 120' and grade = 'grade 8';

-- Find all the students from class 1.
CREATE VIEW getStudent as
SELECT Student.id as sid, Student.lname 
FROM (BelongsTo INNER JOIN getClass on BelongsTo.classid = getClass.cid) 
	INNER JOIN Student on Student.id = BelongsTo.studentid;

-- Get the question weight on the quiz for each question.
CREATE VIEW question_weight as
SELECT Question.qid as qid, UseOf.weight as weight, Question.answer as answer
FROM Question, UseOf 
WHERE Question.qid = UseOf.questionid and UseOf.quizid = 'Pr1-220310';

-- Get the weight for the question that the student correctly answered.
CREATE VIEW getScore as
SELECT getStudent.sid as sid, lname, weight
FROM (getStudent LEFT JOIN Response on getStudent.sid = Response.studentid) 
	LEFT JOIN question_weight ON question_weight.qid = Response.questionid
WHERE Response.response = question_weight.answer;

INSERT INTO q3 (SELECT sid, lname, sum(weight) as totalGrade FROM getScore GROUP BY sid, lname);