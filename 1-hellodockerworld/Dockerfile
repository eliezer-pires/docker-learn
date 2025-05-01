# Etapa 1: Base da imagem
FROM python:3.14.0a7-slim

# Etapa 2: Define o diretório de trabalho dentro do container
WORKDIR /app

# Etapa 3: Copia o código para dentro do container
COPY app.py .

# Etapa 4: Comando que será executado
CMD ["python", "app.py"]