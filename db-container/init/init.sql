CREATE TABLE IF NOT EXISTS alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    curso VARCHAR(50)
):

INSERT INTO alunos (nome, curso) VALUES
('Ana', 'Docker 101'),
('Bruno', 'Banco de Dados com PostgreSQL');