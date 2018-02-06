-- Question answering.
-- Question 1: Some of the domain I cannot enforce: A class at least has one student; a room
-- can maximum has two class in it; students can only respond to the questions 
-- that in the quiz which is assigned to his/her class. For the principles, NULL 
-- situation has to occur in some situations.
-- Question 2: A room can havs maximum two classes in it could have been enforced but then
-- the class table will only contains its id (maked up by me) and a grade, which is 
-- not convenient to use for the queries.


-- Relational schema for assignment 3 part 1.
DROP SCHEMA IF EXISTS quizschema CASCADE;
CREATE SCHEMA quizschema;
SET SEARCH_PATH to quizschema;

-- Create a domain for question type which MC mean mutiple choice, TF means true or false question and 
-- Numeric means numeric question.
CREATE domain TYPE as VARCHAR(10) NOT NULL check (value in ('MC', 'TF', 'Numeric'));
CREATE domain TORF as VARCHAR(10) NOT NULL check (value in ('True', 'False'));

-- A student that study in this school with a student id, first name and last name.
CREATE TABLE Student(
  id BIGINT primary key,
  -- The first name of the student.
  fname VARCHAR(50) NOT NULL,
  -- The last name of the student.
  lname VARCHAR(50) NOT NULL
);

-- A room which is at most assigned to one instructor.
CREATE TABLE Room(
  -- The room name of the room, eg "room 366".
  roomName VARCHAR(10) primary key,
  -- The name of the instructor.
  instructor VARCHAR(50)
);

-- A class of the school.
CREATE TABLE Class(
  -- The id of the class.
  id INT primary key,
  -- The room name of the room eg. 'room 336' for the class.
  roomName VARCHAR(10) NOT NULL REFERENCES Room(roomName),
  -- The grade of this class.
  grade VARCHAR(10) NOT NULL,

  UNIQUE (roomName, grade)
);

-- The relationship that the student of the studentid are in the class of the classid.
CREATE TABLE BelongsTo(
  -- Student id that indicates who is the student of this relation.
  studentid BIGINT REFERENCES Student(id),
  -- Class id that indicates which class of this relation.
  classid INT REFERENCES Class(id),
  primary key (studentid, classid)
);

-- A question in the question bank with an id, type, text and correct answer.
CREATE TABLE Question(
  -- The id of the question.
  qid INT primary key,
  -- The question type of the question, one of "MC", "TF" or "Numeric".
  type TYPE,
  -- The text of the question.
  questiontext VARCHAR(500) NOT NULL,
  -- The answer to the question.
  answer VARCHAR(500) NOT NULL
);


-- A quiz in the quiz bank with id, title, due date, class id that was assigned tto
-- and a flag that indicate whether hints are given when student answer wrong.
CREATE TABLE Quiz(
  -- The id of the quiz.
  quizid VARCHAR(20) primary key,
  -- The title of the quiz
  title VARCHAR(50) NOT NULL,
  -- The due date of the quiz.
  dueDate VARCHAR(50) NOT NULL,
  -- The class id to indicate that which class was assigned this quiz.
  classid INT NOT NULL REFERENCES Class(id),
  -- Whether a student should get a hint or not if their answer is wrong.
  hint boolean NOT NULL
);

-- A relationship that the question of the quesionid is used in the quiz of the 
--quizid and the quesion has a weight in the quiz.
CREATE TABLE UseOf(
  -- The question id which is used in the quiz.
  questionid INT NOT NULL REFERENCES Question(qid),
  -- The quiz id which the question is used in.
  quizid VARCHAR(20) NOT NULL REFERENCES Quiz(quizid),
  -- The weight of that question in that quiz.
  weight INT NOT NULL,
  primary key (questionid, quizid)
);

-- The student of the student id answered the question of the quesiton id
-- with the reponse.
CREATE TABLE Response(
  -- Student id that indicates who response the question.
  studentid BIGINT NOT NULL REFERENCES Student(id),
  -- Question id that indicates which question this response for.
  questionid INT NOT NULL REFERENCES Question(qid),
  -- The response of the student for the question.
  response VARCHAR(100) NOT NULL,
  -- The range that the answer belongs to (just for the numeric question).
  range VARCHAR(50)
);

-- For MC question and numeric question of the qid, the option is either a
-- choice in mutiple choice question or a range in numeric question.
CREATE TABLE QuestionOpt(
  -- Question id that refer to the Question table.
  qid INT NOT NULL REFERENCES Question(qid),
  -- one of MC option.
  option VARCHAR(100) NOT NULL,
  -- The hint for this option or range in this question.
  hint VARCHAR(100),

  primary key (qid, option)
);


















