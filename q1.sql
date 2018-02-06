-- Report the full name and student number of all students in the database.
drop table if exists q1 cascade;

create table q1(
name VARCHAR(100),
id BIGINT);

INSERT INTO q1 (SELECT (fname || ' ' || lname) as name, id FROM Student);
