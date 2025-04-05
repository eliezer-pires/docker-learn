# Explicando o bloco user_data
```bash
user_data = <<-EOF
    #!/bin/bash
```
### Atualiza pacotes
```bash
    dnf update -y
```

### Instala o Docker
```bash
    dnf install docker -y
```

### Inicia e habilita docker
```bash
    systemctl start docker
    systemctl enable docker
```

### Adiciona ec2-user ao grupo docker
```bash
    usermod -aG docker ec2-user
```
    
### Espera o serviço do Docker inicializar
```bash
    sleep 10
```

### Ativa o IP forwarding
````bash
    echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
````

### Permite o NAT (mas em geral o Docker já faz isso com o docker0)
````bash
    sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
````

### Roda o container nginx com mapeamento de porta
````bash
    docker run -d --name meu-nginx -p 80:80 nginx
````

### Loga Saída para facilitar debug
````bash
    docker ps > /tmp/docker-ps.log
    ss -tunlp > /tmp/ports.log
````
