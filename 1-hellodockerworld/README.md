## 🧩 Projeto 1: Hello Docker World

### 📌 Objetivo
Criar uma aplicação mínima em Python (pode ser Node.js, se preferir), empacotá-la com Docker e executá-la em um container.

### 🛠️ Tecnologias
Docker
Python 3 (ou Node.js se preferir)

### 📁 Estrutura de Pastas
````bash
hello-docker/
├── app.py
├── Dockerfile
└── .dockerignore
````
### 💡 Passo a Passo

1. app.py – A aplicação base
2. Dockerfile – Receita da imagem Docker
3. .dockerignore – Evita arquivos desnecessários

### 🔨 Comandos Docker

````bash
# Build da imagem
docker build -t hello-docker .

# Rodar o container
docker run hello-docker
````
