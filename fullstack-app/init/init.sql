CREATE TABLE IF NOT EXISTS alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    curso VARCHAR(50) NOT NULL
);

INSERT INTO alunos (nome, curso) VALUES
('Joana', 'React Básico'),
('Carlos', 'Flask API Avançado');
