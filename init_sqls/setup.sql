CREATE SCHEMA IF NOT EXISTS journey_mosaic;
USE journey_mosaic;

-- Primeiro, criar as tabelas principais que são referenciadas por outras tabelas
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,          -- Identificador único do usuário
    nome VARCHAR(255) NOT NULL,                         -- Nome do usuário
    senha VARCHAR(255) NOT NULL,                        -- Senha do usuário
    email VARCHAR(255) NOT NULL,                        -- E-mail do usuário
    cpf_rg VARCHAR(20)                                  -- CPF ou RG do usuário
);

CREATE TABLE viagem (
    id_viagem INT AUTO_INCREMENT PRIMARY KEY,           -- Identificador único da viagem
    id_usuario INT NOT NULL,                            -- Identificador do usuário associado à viagem
    nome VARCHAR(255) NOT NULL,                         -- Nome da viagem
    destino VARCHAR(255) NOT NULL,                      -- Destino da viagem
    data_ida DATE,                                      -- Data de início da viagem
    data_volta DATE,                                    -- Data de fim da viagem
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) -- Chave estrangeira para usuário
);

-- Em seguida, criar as tabelas que dependem da tabela viagem
CREATE TABLE atividade (
    id_atividade INT AUTO_INCREMENT PRIMARY KEY,        -- Identificador único da atividade
    id_viagem INT NOT NULL,                             -- Referência à viagem relacionada
    nome VARCHAR(255) NOT NULL,                         -- Nome da atividade
    `local` VARCHAR(255),                               -- Local da atividade
    hora TIME,                                          -- Hora da atividade
    `data` DATE,                                        -- Data da atividade
    duracao INT,                                        -- Duração em minutos
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem) -- Chave estrangeira para viagem
);

CREATE TABLE hospedagem (
    id_hospedagem INT AUTO_INCREMENT PRIMARY KEY,       -- Identificador único da hospedagem
    id_viagem INT NOT NULL,                             -- Referência à viagem relacionada
    nome VARCHAR(255),                                  -- Nome do local de hospedagem
    endereco VARCHAR(255),                              -- Endereço da hospedagem
    valor DOUBLE,                                       -- Valor da hospedagem
    data_checkin DATE,                                  -- Data de check-in
    data_checkout DATE,                                 -- Data de check-out
    hora_checkin TIME,                                  -- Hora de check-in
    hora_checkout TIME,                                 -- Hora de check-out
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem) -- Chave estrangeira para viagem
);

CREATE TABLE transporte (
    id_transporte INT AUTO_INCREMENT PRIMARY KEY,       -- Identificador único do transporte
    tipo_transporte VARCHAR(50) NOT NULL,               -- Tipo de transporte (trem, avião, ônibus)
    id_viagem INT NOT NULL,                             -- Referência à viagem relacionada
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem) -- Chave estrangeira para viagem
);

-- Finalmente, criar as tabelas de especialização que dependem da tabela transporte
CREATE TABLE trem (
    id_transporte INT PRIMARY KEY,                      -- Reutilização do ID do transporte
    empresa VARCHAR(255),                               -- Empresa de transporte ferroviário
    numero_trem VARCHAR(255),                           -- Número do trem
    vagao VARCHAR(255),                                 -- Vagão do trem
    estacao_partida VARCHAR(255),                       -- Estação de partida
    numero_assento VARCHAR(255),                        -- Número do assento
    hora TIME,                                          -- Hora de partida
    `data` DATE,                                        -- Data de partida
    FOREIGN KEY (id_transporte) REFERENCES transporte(id_transporte) -- Chave estrangeira para transporte
);

CREATE TABLE aviao (
    id_transporte INT PRIMARY KEY,                      -- Reutilização do ID do transporte
    numero_voo VARCHAR(255),                            -- Número do voo
    porta_embarque VARCHAR(255),                        -- Porta de embarque
    bagagem VARCHAR(255),                               -- Informações sobre bagagem
    empresa VARCHAR(255),                               -- Companhia aérea
    hora TIME,                                          -- Hora de partida
    `data` DATE,                                        -- Data de partida
    FOREIGN KEY (id_transporte) REFERENCES transporte(id_transporte) -- Chave estrangeira para transporte
);

CREATE TABLE onibus (
    id_transporte INT PRIMARY KEY,                      -- Reutilização do ID do transporte
    numerolinha VARCHAR(255),                           -- Número da linha do ônibus
    plataforma_embarque VARCHAR(255),                   -- Plataforma de embarque
    restricoes TEXT,                                    -- Restrições, se houver
    empresa VARCHAR(255),                               -- Empresa de ônibus
    assento VARCHAR(255),                               -- Assento
    hora TIME,                                          -- Hora de partida
    `data` DATE,                                        -- Data de partida
    FOREIGN KEY (id_transporte) REFERENCES transporte(id_transporte) -- Chave estrangeira para transporte
);
