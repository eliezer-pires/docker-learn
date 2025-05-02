from flask import Flask
import redis
import os
import time

app = Flask(__name__)

# Configurações do Redis (Usando nome do serviço no docker-compose como hostname)
REDIS_HOST = os.getenv('REDIS_HOST', 'redis')
REDIS_PORT = int(os.getenv('REDIS_PORT', 6379))

# Inicializa Redis com retry (caso Redis ainda não esteja disponível)
while True:
    try:
        r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT)
        r.ping()
        break
    except redis.exceptions.ConnectionError:
        print("🔄 Aguardando o Redis subir...")
        time.sleep(1)

@app.route('/')
def index():
    # Incrementa contador
    visitas = r.incr('contador')
    return f'👋 Número de acessos: {visitas}\n'

@app.route('/reset')
def reset():
    r.set('contador', 0)
    return '🔄 Contador resetado!\n'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)