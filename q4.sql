-- For every student in the grade 8 class in room 120 with Mr Higgins, and every question from quiz Pr1-220310
-- that they did not answer, report the student ID, the question ID, and the question text.

drop table if exists q4 cascade;

create table q4(
sid BIGINT,
-- Question id.
qid INT,
questiontext VARCHAR(50) NOT NULL,
primary key (sid, qid)
);

DROP VIEW IF EXISTS allQuestion CASCADE;
DROP VIEW IF EXISTS allStudent CASCADE;
DROP VIEW IF EXISTS allPairs CASCADE;
DROP VIEW IF EXISTS notIn CASCADE;

-- Find all the questions that in quiz 220310.
CREATE VIEW allQuestion as
SELECT questionid
FROM UseOf
WHERE quizid = 'Pr1-220310';

-- Find all the students in the class 1 (room 120 grade 8).
CREATE VIEW allStudent as 
SELECT BelongsTo.studentid as sid
FROM BelongsTo
WHERE BelongsTo.classid IN (SELECT Class.id FROM Class 
	WHERE Class.roomName = 'room 120' and Class.grade = 'grade 8');

-- Combine all the questions in the quiz and all the students in the class.
CREATE VIEW allPairs as
SELECT questionid as qid, sid
FROM allQuestion, allStudent;

-- Find the pairs that are not in the real response in database.
CREATE VIEW notIn as
SELECT sid, qid
FROM allPairs
EXCEPT
(SELECT studentid as sid, questionid as qid FROM Response);


INSERT INTO q4 (SELECT notIn.sid as sid, notIn.qid as qid, 
	Question.questiontext::VARCHAR(50) as questiontext
FROM notIn, Question
WHERE notIn.qid = Question.qid);