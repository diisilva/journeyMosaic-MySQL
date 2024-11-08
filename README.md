
# Journey Mosaic - MySQL Project

Este projeto configura um banco de dados MySQL para um sistema de planejamento de viagens chamado Journey Mosaic. O projeto inclui a configuração do banco de dados, um script SQL para criar tabelas e relacionamentos necessários, e um ambiente Docker para facilitar a execução do banco de dados MySQL.

## Estrutura do Projeto

A estrutura de pastas e arquivos no projeto é organizada da seguinte forma:

```
journeyMosaic-MySQL/
├── init_sqls/
│   └── setup.sql            # Script SQL que cria o schema e as tabelas no banco de dados MySQL
├── docker-compose.yml       # Arquivo Docker Compose para configurar o ambiente MySQL
├── LICENSE                  # Licença do projeto
└── README.md                # Documento de explicação do projeto
```

- **init_sqls/setup.sql**: Este arquivo contém as instruções SQL para criação do schema, tabelas e relações do banco de dados.
- **docker-compose.yml**: Define o serviço MySQL, configura a porta, e monta o volume com os scripts de inicialização.

## Requisitos

- Docker e Docker Compose instalados.
- Um editor como o DBeaver para conectar-se ao banco de dados MySQL (opcional).

## Configuração do Banco de Dados

O projeto usa um arquivo SQL (`setup.sql`) que é carregado automaticamente quando o container MySQL é iniciado. Esse script cria o schema `journey_mosaic` e as tabelas necessárias para o sistema.

## Executando o Projeto

1. Certifique-se de que nenhuma outra instância do MySQL está usando a porta 3306 ou 3308 no seu sistema.
2. No terminal, navegue até o diretório do projeto `journeyMosaic-MySQL`.
3. Execute o seguinte comando para iniciar o ambiente:

   ```bash
   docker-compose -f docker-compose.yml up --build -d
   ```

   Este comando fará o build e iniciará o container MySQL no Docker.

## Conectando ao Banco de Dados com DBeaver

Para conectar-se ao banco de dados MySQL no Docker usando o DBeaver:

1. Configure uma nova conexão MySQL no DBeaver.
2. Utilize as seguintes informações de conexão:
   - **Host**: `localhost`
   - **Porta**: `3308` (ou a porta configurada no `docker-compose.yml`)
   - **Database**: `journey_mosaic`
   - **Usuário**: `user`
   - **Senha**: `userpassword`
3. Adicione `allowPublicKeyRetrieval=true` na URL de conexão para evitar erros de chave pública:
   ```
   jdbc:mysql://localhost:3308/journey_mosaic?allowPublicKeyRetrieval=true&useSSL=false
   ```
4. Clique em "Test Connection" para garantir que está tudo funcionando.

## OBS: Pode ser preciso executar apos a conexao cada sql de create table manualmente no Dbeaver

Para parar e remover o container, execute:

```bash
docker-compose down
```
## Encerrando o Container

Para parar e remover o container, execute:

```bash
docker-compose down
```

## License

Distribuído sob a Licença MIT. Veja `LICENSE` para mais informações.

