-- For each question on quiz Pr1-220310, report the number of students in the grade 8 class in room 120 with
-- Mr Higgins who got the question right, the number who got it wrong, and the number who did not answer it.

drop table if exists q5 cascade;

create table q5(
-- The question id which is in the quiz.
qid INT primary key,
-- Number of students in class 1 answer it correct.
correct INT,
-- Number of students in class 1 answer it wrong.
wrong INT,
-- Number of students in class 1 did not answer it.
none INT
);

DROP VIEW IF EXISTS getQuestions CASCADE;
DROP VIEW IF EXISTS getStudent CASCADE;
DROP VIEW IF EXISTS correctCount CASCADE;
DROP VIEW IF EXISTS wrongCount CASCADE;
DROP VIEW IF EXISTS getNonePair CASCADE;
DROP VIEW IF EXISTS noneCount CASCADE;

-- Find all the questions in the quiz 220310.
CREATE VIEW getQuestions as
SELECT questionid as qid
FROM UseOf
WHERE quizid = 'Pr1-220310';

-- Find all the students in the class room 120 grade 8 (class 1).
CREATE VIEW getStudent as
SELECT studentid as sid
FROM BelongsTo 
WHERE classid in (SELECT Class.id FROM Class 
	WHERE Class.grade = 'grade 8' and Class.roomName = 'room 120');

-- Get the number that the students in class 1 correctly answer for each of the 
-- question on specific quiz.
CREATE VIEW correctCount as
SELECT Question.qid as qid, count(*) as correct
FROM Response, getStudent, getQuestions, Question
WHERE Response.studentid = getStudent.sid and Response.questionid = getQuestions.qid 
and Question.qid = getQuestions.qid and Response.response = Question.answer
GROUP BY Question.qid;

-- Get the number that the students in class 1 wrongly answer for each of the 
-- question on specific quiz.
CREATE VIEW wrongCount as
SELECT Question.qid as qid, count(*) as wrong
FROM Response, getStudent, getQuestions, Question
WHERE Response.studentid = getStudent.sid and Response.questionid = getQuestions.qid 
and Question.qid = getQuestions.qid and Response.response != Question.answer
GROUP BY Question.qid;

-- Get the pair of student and question that not in response.
CREATE VIEW getNonePair as
SELECT qid, sid
FROM getQuestions, getStudent
EXCEPT 
(SELECT questionid, studentid
FROM Response);

-- Get the number that the students in class 1 did not answer for each of the 
-- question on specific quiz.
CREATE VIEW noneCount as
SELECT qid, count(*) as none
FROM getNonePair
GROUP BY qid;

INSERT INTO q5 (SELECT correctCount.qid, correct, wrong, none 
FROM correctCount, wrongCount, noneCount
WHERE correctCount.qid = wrongCount.qid and wrongCount.qid = noneCount.qid);