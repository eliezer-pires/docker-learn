# Este Dockerfile é para buildar a imagem do Flask
# Imagem base com Python
FROM python:3.11-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos do projeto
COPY ./app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app/app.py .

# Expoe a porta (5000 é a padrão do Flask)
EXPOSE 5000

# Comando para iniciar a aplicação
CMD ["python", "app.py"]