# dave CLI
Dave é um script bash bem simples que te permite criar um projeto fastApi a partir de um template, gerar esqueletos de CRUD e executar seu projeto

# Como usar
Recomendo salvá-lo em uma pasta estável de seu sistema e criar um alias para ele

## Criar projeto
Vai criar um projeto no diretório atual
```bash
dave new <nome_do_projeto>
```

Antes de usar os próximos comandos, entre no diretório do projeto criado

## Criar CRUD
```bash
dave generateResource <nome_do_recurso>
```
## Executar projeto
```bash
dave run
```