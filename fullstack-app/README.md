# 🚀 Projeto Full Stack com Docker: React + Flask + PostgreSQL

Este projeto demonstra a criação de uma aplicação full stack utilizando containers Docker com **React no frontend**, **Flask (Python) no backend**, e **PostgreSQL como banco de dados**, com foco em práticas de **DevOps**, **Docker networking**, e **ambientes multi-container**.

---

## 📚 Objetivos de Aprendizado

### 🔧 DevOps & Docker
- Utilização de **Docker Compose** para orquestrar múltiplos serviços (frontend, backend, banco de dados)
- Conceitos de **rede de containers** e comunicação entre serviços via `service_name`
- **Build automatizado** usando `volumes` e `bind mounts` para facilitar o desenvolvimento
- **Rebuild eficiente** com `Dockerfile` otimizado e camadas reutilizáveis
- Separação de responsabilidades por container, promovendo escalabilidade e manutenção simplificada

### 💻 Integração Full Stack
- Frontend moderno com **React** consumindo uma API REST
- Backend com **Flask** servindo dados e realizando comunicação com o banco
- Banco de dados **PostgreSQL** persistente via volume nomeado
- Comunicação integrada entre camadas por meio de chamadas HTTP e conexão a banco relacional

---

## 📁 Estrutura de Pastas

O ChatGPT disse:
Perfeito! Aqui está um README.md completo e bem estruturado para o seu projeto, com foco pedagógico em DevOps com Docker e integração full stack 👇

markdown
Copiar
Editar
# 🚀 Projeto Full Stack com Docker: React + Flask + PostgreSQL

Este projeto demonstra a criação de uma aplicação full stack utilizando containers Docker com **React no frontend**, **Flask (Python) no backend**, e **PostgreSQL como banco de dados**, com foco em práticas de **DevOps**, **Docker networking**, e **ambientes multi-container**.

---

## 📚 Objetivos de Aprendizado

### 🔧 DevOps & Docker
- Utilização de **Docker Compose** para orquestrar múltiplos serviços (frontend, backend, banco de dados)
- Conceitos de **rede de containers** e comunicação entre serviços via `service_name`
- **Build automatizado** usando `volumes` e `bind mounts` para facilitar o desenvolvimento
- **Rebuild eficiente** com `Dockerfile` otimizado e camadas reutilizáveis
- Separação de responsabilidades por container, promovendo escalabilidade e manutenção simplificada

### 💻 Integração Full Stack
- Frontend moderno com **React** consumindo uma API REST
- Backend com **Flask** servindo dados e realizando comunicação com o banco
- Banco de dados **PostgreSQL** persistente via volume nomeado
- Comunicação integrada entre camadas por meio de chamadas HTTP e conexão a banco relacional

---

## 📁 Estrutura de Pastas

````bash
├── backend/
│ ├── app
│ │  ├── __init__.py
│ │  ├── config.py
│ │  ├── models.py
│ │  └── routes.py
│ ├── app.py
│ ├── requirements.txt
│ └── Dockerfile
│
├── frontend/
│ ├── src/
│ │ └── components
│ │     └── UserList.jsx
│ │ ├── App.jsx
│ │ └── main.jsx
│ ├── .env
│ ├── index.html
│ ├── package.json
│ ├── vite.config.js
│ └── Dockerfile
│
├── init/
│ └── init.sql # Scripts opcionais de criação do schema
│
├── .env
├── docker-compose.yml
└── README.md
````


---

## ⚙️ Como Funciona

### 🌐 Docker Compose

O `docker-compose.yml` define os três serviços principais:
- **frontend**: um app React, servido por NGINX
- **backend**: uma API REST em Flask
- **postgres**: banco de dados relacional com volume persistente

Esses serviços se comunicam por **nomes de container**, como `backend` e `postgres`, através da **bridge network** padrão criada pelo Docker Compose.

### 📡 Comunicação entre Serviços
- O **frontend** envia requisições HTTP para `http://localhost:5000/alunos`
- O **backend** conecta ao banco com host `postgres`, usando o driver psycopg2
- O **PostgreSQL** persiste os dados em volume nomeado e pode ser acessado via pgAdmin ou CLI

---

## ▶️ Executando o Projeto

```bash
# Inicializar todos os serviços
docker-compose up --build
```
## Acesso:

🖥️ Frontend: http://localhost:3000

🧠 Backend: http://localhost:5000/alunos

🛢️ Banco (pgAdmin): http://localhost:8080

## 🧪 Testando a API

### Obter Alunos (GET):
````bash
GET http://localhost:5000/alunos
````

### Criar Aluno (POST):
````bash
POST http://localhost:5000/alunos
{
  "nome": "Maria",
  "curso": "Python para Iniciantes"
}
````

# 💡 Principais Conceitos Docker Aplicados

| Conceito                   | Aplicação no Projeto                                        |
| -------------------------- | ----------------------------------------------------------- |
| **Multi-container**        | Serviços independentes (React, Flask, Postgres)             |
| **Bridge Network**         | Comunicação entre serviços por nome (`backend`, `postgres`) |
| **Volumes**                | Persistência de dados em `postgres_data`                    |
| **Bind Mount**             | Hot reload e build automatizado no desenvolvimento          |
| **Dockerfile com camadas** | Imagens otimizadas para backend e frontend                  |

# 🔍 Tecnologias Usadas
- Frontend: React + Vite + Axios
- Backend: Flask + SQLAlchemy + psycopg2
- Database: PostgreSQL (via imagem Bitnami)
- DevOps: Docker, Docker Compose

# 📦 Dependências

Instaladas automaticamente via Docker:
- Flask
- SQLAlchemy
- psycopg2-binary
- React / Vite (Node)
- NGINX (para servir frontend em produção)

---

## 🛠️ Problemas Encontrados e Soluções Aplicadas

Durante o desenvolvimento, diversos desafios foram enfrentados e solucionados, contribuindo para o aprendizado prático em DevOps com Docker e integração full stack:

### 1. ❌ `ERR_NAME_NOT_RESOLVED` ao tentar acessar o backend via frontend

- **Problema**: O frontend tentava acessar `http://backend:5000/alunos` mas não resolvia o nome `backend`.
- **Causa**: O React no navegador não conhece o nome do serviço Docker (`backend`), que só funciona dentro da rede interna dos containers.
- **Solução**: Alterar o valor de `VITE_API_URL` no `.env` do frontend para `http://localhost:5000` durante o desenvolvimento local (ou usar proxy reverso em produção).

---

### 2. ❌ Backend Flask dizendo "Not Found" na raiz `/`

- **Problema**: Ao acessar diretamente `http://localhost:5000`, o navegador exibia "Not Found".
- **Causa**: A aplicação Flask só respondia à rota `/alunos` e não tinha rota `/`.
- **Solução**: Criar uma rota básica para `/` ou ignorar o erro, já que o frontend consome somente a rota `/alunos`.

---

### 3. ❌ Flask escutando apenas em `127.0.0.1`

- **Problema**: O container do backend iniciava, mas o serviço não era acessível externamente.
- **Causa**: O Flask estava sendo executado com host padrão (`127.0.0.1`).
- **Solução**: Modificar o `app.run()` em `app.py` para usar `host='0.0.0.0'`, permitindo conexões externas.

```python
app.run(host='0.0.0.0', port=5000)
```

---

### 4. ❌ Dados não persistiam entre reinícios do banco

- **Problema**: Sempre que o container do banco era reiniciado, os dados sumiam.
- **Causa**: O banco não estava utilizando volumes persistentes.
- **Solução**: Configurar volume nomeado `postgres_data` no `docker-compose.yml`.

````bash
volumes:
  - postgres_data:/var/lib/postgresql/data
````

---

### 5. ❌ Frontend não atualizava automaticamente durante o desenvolvimento

-**Problema**: Alterações no código React não refletiam ao vivo.
-**Causa**: A imagem do frontend usava NGINX e não o servidor de desenvolvimento do Vite.
-**Solução**: Usar volumes com bind mount e iniciar com npm run dev localmente.

---

### 6. ❌ Banco de dados não estava aceitando conexões do backend

-**Problema**: Erros de conexão ao tentar iniciar a API.
-**Causa**: Configuração incorreta da string de conexão ou ordem de inicialização dos serviços.
-**Solução**: Verificar `SQLALCHEMY_DATABASE_URI` no backend e adicionar `depends_on`: postgres no serviço backend.

---

Esses obstáculos foram superados com inspeção dos **logs dos containers** (`docker compose logs`), uso de variáveis de ambiente, e ajustes finos nas configurações de Docker e aplicação.

# 📌 Considerações Finais

Este projeto visa consolidar o entendimento de:
- Integração entre tecnologias web modernas
- Criação de ambientes isolados e consistentes com Docker
- Automatização de builds e ambientes de desenvolvimento
- Princípios fundamentais de DevOps aplicados em escala reduzida