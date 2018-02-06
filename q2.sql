-- For all questions in the database, report the question ID, question text, 
-- and the number of hints associated with it. For True-False questions, report 
-- NULL as the number of hints (since True-False questions cannot have
-- hints).
drop table if exists q2 cascade;

create table q2(
qid VARCHAR(20),
questiontext VARCHAR(50),
hintsCount INT DEFAULT 0
);

DROP VIEW IF EXISTS question_hint CASCADE;

-- Count the hint number for each question.
CREATE VIEW question_hint as
select QuestionOpt.qid as qid, count(QuestionOpt.hint) as hintNum
FROM Question Left join QuestionOpt on Question.qid = QuestionOpt.qid
GROUP BY QuestionOpt.qid;

INSERT INTO q2 (SELECT Question.qid as qid, Question.questiontext::VARCHAR(50), question_hint.hintNum
FROM Question LEFT JOIN question_hint on Question.qid = question_hint.qid);

UPDATE q2
SET hintsCount = 0
WHERE hintsCount is NULL;