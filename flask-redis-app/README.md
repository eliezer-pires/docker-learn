# 🐳 Flask + Redis com Docker Compose

Projeto de aprendizado para entender como containers se comunicam via Docker Compose, utilizando:
- 🐍 Flask (API em Python)
- 📦 Redis (armazenamento em memória)
- 🐳 Docker Compose (orquestração)

A aplicação é uma **API simples** com duas rotas:

- `GET /` → incrementa e retorna um contador armazenado no Redis  
- `GET /reset` → reseta o contador

---

## 🧠 Arquitetura e Comunicação entre Containers

┌───────────────┐       HTTP       ┌─────────────┐
│ Navegador     │ ───────────────▶ │ Flask (app) │
└───────────────┘                  │   Container │
                                  └──────┬───────┘
                                         │
                         rede: app-net   │ Redis protocol
                                         ▼
                                  ┌─────────────┐
                                  │ Redis       │
                                  │ Container   │
                                  └────┬────────┘
                                       │
                                 Volume: redis_data


- O container Flask acessa Redis via hostname `redis` (resolvido pela rede Docker)
- Redis persiste os dados no volume `redis_data`

---

## 📁 Estrutura de Pastas

flask-redis-app/
├── app/
│   ├── app.py
│   └── requirements.txt
├── docker-compose.yaml
├── Dockerfile
├── .dockerignore
└── README.md


---

## 📝 Explicação dos Arquivos

### `app.py`
- Contém duas rotas:
  - `/` → incrementa contador no Redis
  - `/reset` → zera o contador
- Usa `redis-py` para conectar via `Redis(host='redis')`

### `Dockerfile`
- Usa imagem `python:3.11-slim`
- Instala dependências e roda `app.py`

### `requirements.txt`
```txt
flask==2.3.3
redis==5.0.1
```

### `docker-compose.yaml`
- Sobe 2 containers: `app` (Flask) e `redis`
- Define uma rede chamada `app-net`
- Cria um volume chamado `redis_data` para persistência

## ▶️ Como executar o projeto

1. Clone o repositório:
````bash
git clone https://github.com/seu-usuario/flask-redis-app.git
cd flask-redis-app
````

2. Build + up
````bash
docker compose up --build -d
````

3. Acesse a aplicação:

- http://localhost:5000/ → Ver contador
- http://localhost:5000/reset → Resetar contador

4. Ver Logs:
````bash
docker compose logs -f app
````

5. Parar tudo:
````bash
docker compose down
````

## 📌 Conceitos praticados

- Dockerfile Python com pip e Flask
- Redis como serviço auxiliar em container
- Comunicação via rede Docker
- Bind de porta
- Volume para persistência
- Orquestração com Docker Compose
- Uso de depends_on e DNS interno

## 💼 Autor

**Eliezer Pires**  

[LinkedIn](https://www.linkedin.com/in/eliezer-pires-sre-devops-aws)