# docker-webserver-template
Ambiente de desenvolvimento Web usando Docker com: Fedora Linux + Apache + PHP + MySQL

## Como usar no Windows
1) Baixe o zip do projeto e extraia no seu PC, é recomendado que o nome da pasta seja "docker-webserver"
2) Instale o docker e certifique-se que ele esteja rodando, usando "docker ps"
3) Abra o powershell e navegue até a pasta raiz deste projeto, que contém o arquivo "docker-compose.yml"
4) Certifique-se que não as portas: 80, 443 e 3306 esteja livres para serem abertas no seu PC; 
5) Execute o comando "docker-compose up -d"
6) Pronto! Agora você tem um ambiente de desenvolvimento configurado e funcionando com o Apache, PHP e MySQL

## Comandos básicos do dia a dia
- "docker-compose down" Para a execução dos containers
- "docker-compose up -d" Inicia a execução dos containers em background
- "docker exec -it <ID DO CONTAINER> /bin/bash" Entra no bash do container que esta rodando. Para sair do bash "ctrl + d"