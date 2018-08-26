#!/bin/bash

# baixando bin
#curl -L -O -s https://docs.google.com/uc?id=0B3X9GlR6EmbnWksyTEtCM0VfaFE&export=download
#mv uc\?id\=0B3X9GlR6EmbnWksyTEtCM0VfaFE gdrive

# dando permissão
chmod +x /webserver/bin/gdrive

# instalando no sistema
install /webserver/bin/gdrive /usr/local/bin/gdrive

# forçando uma ação para pedir a key de autorização
gdrive list