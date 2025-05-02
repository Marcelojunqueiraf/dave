#!/bin/bash

create_new() {
  if [ -z "$1" ]; then
    echo "Error: nao informou o nome do projeto"
    echo "uso correto: dave new nomeDoProjeto"
    exit 1
  fi

  if [ -d "$1" ]; then
    echo "Error: já existe um diretorio com nome '$1'"
    exit 1
  fi

  echo "Creating new project..."

  git clone https://github.com/Marcelojunqueiraf/templateFastApi.git

  mv templateFastApi $1

  cd $1

  rm -rf .git

  git init

  python -m venv venv
  pip install -r requirements.txt
  source venv/bin/activate

  echo "Project '$1' created successfully."

  # colocando o nome do projeto no README
  sed -i '' "s/NOME_DO_PROJETO/$1/g" README.md
}

run() {
  echo "Running project..."
  source venv/bin/activate
  uvicorn app.main:app
}


generateResource() {
  echo "Generating resource..."
  if [ -z "$1" ]; then
    echo "Error: nao informou o nome do recurso"
    echo "uso correto: dave generateResource nomeDoRecurso"
    exit 1
  fi
  # copia template do service
  cp ./templates/serviceTemplate.py ./app/services/$1.py

  echo "service $1 gerado com sucesso"

  # copia template do router
  cp ./templates/routerTemplate.py ./app/routers/$1.py
  # altera o import do router para pegar o service certo
  sed -i '' "s/NOME_RECURSO/$1/g" ./app/routers/$1.py

  echo "router $1 gerado com sucesso"

  # alterar main para importar o router
  sed -i '' '2i\
from app.routers import '"$1"'
' ./app/main.py

  # alterar main para incluir o router
  sed -i '' '/# Include routers/a\
app.include_router('"$1"'.router, prefix="/'"$1"'", tags=["'"$1"'"])
' ./app/main.py
  
  echo "main.py alterado com sucesso"
  
  echo "Resource '$1' gerado com sucesso."
}

if [ -z "$1" ]; then
  echo "Error: nao informou o comando"
  echo "uso correto: dave comando"
  exit 1
fi

if [ "$1" = "new" ]
then
   create_new $2
elif [ "$1" = "run" ]
then
   run
elif [ "$1" = "generateResource" ]
then
   generateResource $2
elif [ "$1" = "help" ]
then
   echo "Comandos disponíveis:"
   echo " dave new nomeDoProjeto"
   echo " dave run"
   echo " dave generateResource nomeDoRecurso"
   echo " dave help"
else
   echo "Error: comando invalido"
   echo "uso correto: dave comando"
fi

