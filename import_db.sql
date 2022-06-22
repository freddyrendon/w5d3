PRAGMA foreign_key = ON;


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    Fname VARCHAR(255) NOT NULL,
    Lname VARCHAR(255) NOT NULL
)

INSERT INTO 
    users (Fname, Lname)
    VALUES 
   ("Alo", "Ekezie");


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
)

INSERT INTO 
    questions (title, body, user_id)
SELECT 
    "Alo's question", "What is life", users(id)
FROM 
    users
WHERE 
users.Fname = "Alo" AND users.Lname = "Ekezie";


CREATE TABLE questions_follows (
    id INTEGER PRIMARY KEY,
    questions_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL, 
    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
)
INSERT INTO 
    questions_follows(user_id, question_id)
    VALUES 
    (SELECT users.id FROM user WHERE users.Fname = "Alo" AND users.Lname = "Ekezie"), 
    (SELECT question.id FROM question WHERE question.title = "Alo's question");



CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT  NULL, 
    reply_id INTEGER NOT NULL, 
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES question(id),
    FOREIGN KEY (reply_id) REFERENCES replies(id), 
    FOREIGN KEY (user_id) REFERENCES users(id),      
)
INSERT INTO 
        replies (question_id, reply_id, user_id, body)
    VALUES 
    ((SELECT question.id FROM question WHERE question.title = "Alo's question"),
    replies.reply.id,
    (SELECT users.id FROM user WHERE users.Fname = "Alo" AND users.Lname = "Ekezie"), 
    "The way it is");


CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY question_id REFERENCES question(id), 
    FOREIGN KEY user_id REFERENCES users(id),
)

INSERT INTO 
    question_likes ( user_id, question_id)
    VALUES 
    ((SELECT users.id FROM users WHERE users.Fname = "Alo" AND users.Lname = "Ekezie"),
    (SELECT questions.id FROM questions WHERE title = "Alo's questions"));

