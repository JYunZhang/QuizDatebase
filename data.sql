
INSERT INTO Question VALUES
(782, 'MC', 'What do you promise when you take the oath of citizenship?', 'To pledge your loyalty to the Sovereign, Queen Elizabeth II'), 
(566, 'TF', 'The Prime Minister, Justin Trudeau, is Canada''s Head of State.', 'False'), 
(601, 'Numeric', 'During the "Quiet Revolution," Quebec experienced rapid change. In what
decade did this occur? (Enter the year that began the decade, e.g., 1840.)', '1960'),
(625, 'MC', 'What is the Underground Railroad?', 'A network used by slaves who escaped the United States into Canada'), 
(790, 'MC', 'During the War of 1812 the Americans burned down the Parliament Buildings in
York (now Toronto). What did the British and Canadians do in return?', 'They burned down the White House in Washington D.C.');

INSERT INTO QuestionOpt VALUES
(782, 'To pledge your loyalty to the Sovereign, Queen Elizabeth II', NULL),
(782, 'To pledge your allegiance to the flag and fulfill the duties of a Canadian', 'Think regally.'),
(782, 'To pledge your loyalty to Canada from sea to sea', NULL),
(601, '1800-1900', 'The Quiet Revolution happened during the 20th 
   Century.'),
(601, '1900-2000', NULL),
(601, '2000-2010', 'The Quiet Revolution happened some time ago.'),
(601, '2020-3000', 'The Quiet Revolution has already happened!'),
(625, 'The first railway to cross Canada', 'The Underground Railroad was generally south to north, 
      not east-west.'),
(625, 'The CPR''s secret railway line', 'The Underground Railroad was secret, but it had nothing to do 
      with trains.'),
(625, 'The TTC subway system', 'The TTC is relatively recent; the Underground Railroad was 
      in operation over 100 years ago.'),
(625, 'A network used by slaves who escaped the United States into Canada', NULL),
(790, 'They attacked American merchant ships', NULL),
(790, 'They expanded their defence system, including Fort York', NULL),
(790, 'They burned down the White House in Washington D.C.', NULL),
(790, 'They captured Niagara Falls', NULL);

INSERT INTO Student VALUES
(0998801234, 'Lena', 'Headey'), (0010784522, 'Peter', 'Dinklage'),
(0997733991, 'Emilia', 'Clarke'), (5555555555, 'Kit', 'Harrington'), 
(1111111111, 'Sophie', 'Turner'), (2222222222, 'Maisie', 'Williams');

INSERT INTO Room VALUES
('room 120', 'Mr Higgins'), ('room 366', 'Miss Nyers');
INSERT INTO Class VALUES
(1, 'room 120', 'grade 8'), (2, 'room 366', 'grade 5');

INSERT INTO BelongsTo VALUES
(0998801234, 1), (0010784522, 1), (0997733991, 1), (5555555555, 1), (1111111111, 1),
(2222222222, 2);

INSERT INTO Quiz VALUES
('Pr1-220310', 'Citizenship Test Practise Questions', '1:30 pm, Oct 1, 2017', 1, true);
INSERT INTO UseOf VALUES
(601, 'Pr1-220310', 2), (566, 'Pr1-220310', 1), (790, 'Pr1-220310', 3), (625, 'Pr1-220310', 2);

INSERT INTO Response VALUES
(0998801234, 601, '1950', '1900-2000'), (0010784522, 601, '1960', '1900-2000'),
(0997733991, 601, '1960', '1900-2000'), (0998801234, 566, 'False', NULL),
(0010784522, 566, 'False', NULL), (0997733991, 566, 'True', NULL), 
(5555555555, 566, 'False', NULL), (0998801234, 790, 'They expanded their defence system, including Fort York', NULL),
(0010784522, 790, 'They burned down the White House in Washington D.C.', NULL),
(0997733991, 790, 'They burned down the White House in Washington D.C.', NULL),
(5555555555, 790, 'They captured Niagara Falls', NULL), 
(0998801234, 625, 'A network used by slaves who escaped the United States into Canada', NULL),
(0010784522, 625, 'A network used by slaves who escaped the United States into Canada', NULL),
(0997733991, 625, 'The CPR''s secret railway line', NULL);








