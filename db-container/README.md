# 🐘 Projeto: Banco de Dados Containerizado com PostgreSQL + pgAdmin

Este projeto utiliza Docker Compose para levantar um banco de dados PostgreSQL com persistência de dados, inicialização via scripts SQL, e interface gráfica de administração através do **pgAdmin 4**.

---

## 📦 Tecnologias Utilizadas

- PostgreSQL (bitnami/postgresql)
- pgAdmin4 (elestio/pgadmin)
- Docker & Docker Compose
- Volumes e persistência de dados
- Redes isoladas entre containers

---

## 📁 Estrutura do Projeto

````bash
db-container-project/
├── docker-compose.yaml
├── README.md
├── .env # Variáveis de Ambiente Sensíveis
├── init
└── init.sql # Script SQL para criar tabelas/dados
└── pg_data/ # Volume Docker (criado automaticamente)
````

---

## ⚙️ Variáveis de Ambiente

Crie um arquivo `.env` com o seguinte conteúdo:

```bash
# PostgreSQL
DB_POSTGRESQL_USER=admin
DB_POSTGRESQL_PASS=admin123

# pgAdmin
ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=admin123

```

## 🚀 Como Subir o Projeto

````bash
docker compose up -d
````

## 🌐 Acesso às Ferramentas

| Ferramenta | Endereço                                       |
| ---------- | ---------------------------------------------- |
| PostgreSQL | `localhost:5432`                               |
| pgAdmin    | [http://localhost:8080](http://localhost:8080) |

## 📡 Arquitetura da Solução

````bash
+------------------------+
|      pgAdmin UI       |
| Porta: 8080           |
| Acesso: Navegador     |
+------------------------+
           |
           v
+------------------------+
|     PostgreSQL DB      |
| Porta: 5432            |
| Volume: pg_data        |
| Init: ./init/init.sql  |
+------------------------+
````
Ambos os containers estão na mesma rede db-net e se comunicam por hostname interno (postgresql).

## 🛠️ Scripts de Inicialização
Scripts .sql colocados em ./init serão automaticamente executados na primeira vez que o banco subir. Exemplo:
````bash
CREATE TABLE IF NOT EXISTS alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    curso VARCHAR(50)
);

INSERT INTO alunos (nome, curso) VALUES
('Ana', 'Docker 101'),
('Bruno', 'PostgreSQL com Docker');
````

## 🧠 Conceitos Aplicados

- Volumes: Persistência dos dados (pg_data)
- Variáveis de ambiente: Parametrização do container sem hardcode
- Rede Docker: Comunicação interna isolada e segura
- Init scripts: Automatização de criação de tabelas/dados

## ✅ Verificando a Conexão

1. Acesse o pgAdmin via navegador.
2. Crie uma conexão apontando para o host interno postgresql.
3. Use as credenciais definidas no .env.

## 💼 Autor

**Eliezer Pires**  

[LinkedIn](https://www.linkedin.com/in/eliezer-pires-sre-devops-aws)

