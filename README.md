# 🚀 WebApp Estático com Docker + NGINX

Este projeto serve uma aplicação **HTML/CSS estática** usando **NGINX containerizado com Docker**, simulando um ambiente real de produção leve, com boas práticas de DevOps.

---

## 📁 Estrutura do Projeto

webapp-nginx-docker/
├── docker-compose.yaml
└── proxy/
 ├── Dockerfile
 ├── nginx.conf
 └── html/
  └── web-app/
  ├── index.html
  ├── style.css
  └── assets/
   └── bird_2.jpg

   
---

## 🛠️ Tecnologias Utilizadas

- [Docker](https://www.docker.com/)
- [NGINX](https://nginx.org/)
- HTML5 / CSS3

---

## ⚙️ Pré-requisitos

- Docker instalado e funcionando (`docker -v`)
- Docker Compose instalado (`docker compose version`)

---

## ▶️ Como rodar o projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/webapp-nginx-docker.git
   cd webapp-nginx-docker
   ```
2. Build da imagem:
   ```bash
    docker compose build
   ```
3. Subir o container:
   ```bash
   docker compose up -d
   ```
4. Acesse o projeto em:
   
   http://localhost:8080
   
## 🧪 Testes e Debug

- Logs do container:
    ````bash
    docker compose logs -f proxy
    ````
- Parar o projeto:
    ````bash
    docker compose down
    ````

## 📦 Explicação Técnica

- Os arquivos estáticos são servidos diretamente do diretório:
```bash
proxy/html/web-app → /usr/share/nginx/html (via bind mount)
```
- O NGINX é configurado com nginx.conf customizado para tratar corretamente caminhos e arquivos faltantes.

## 🧠 Conceitos abordados

- Docker básico (Dockerfile, build, run)
- Docker Compose
- Bind Mounts (:ro)
- Servidor NGINX customizado
- Boas práticas de estruturação e segurança