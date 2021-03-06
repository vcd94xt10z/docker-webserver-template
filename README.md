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
  
## Possíveis problemas
Caso ocorra algum erro em subir o container, tente:
1) Reiniciar o docker;
2) Deletar imagens e volumes antigos e rebuildar tudo;
3) Liberar permissão de leitura e gravação no diretório montado no container
4) Verificar se o firewall o antivirus esta bloqueando o funcionamento do docker
5) Se tiver proxy na sua rede, vá nas configurações do docker > proxies e informe
os dados do proxy no formato "servidor:porta"