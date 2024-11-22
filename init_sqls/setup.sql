-- Criação do esquema
CREATE SCHEMA IF NOT EXISTS journey_mosaic;
USE journey_mosaic;

-- Tabela `usuario`
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,          -- Identificador único do usuário
    nome VARCHAR(255) NOT NULL,                         -- Nome do usuário
    senha VARCHAR(255) NOT NULL,                        -- Senha do usuário (deve ser armazenada de forma hash)
    email VARCHAR(255) NOT NULL UNIQUE,                 -- E-mail único do usuário
    cpf VARCHAR(14) UNIQUE,                             -- CPF do usuário
    rg VARCHAR(20),                                     -- RG do usuário
    CHECK (LENGTH(cpf) = 11),                           -- Validação para CPF (11 dígitos)
    CHECK (LENGTH(rg) BETWEEN 7 AND 20)                 -- Validação para RG (7 a 20 caracteres)
) ENGINE=InnoDB;

-- Tabela `viagem`
CREATE TABLE IF NOT EXISTS viagem (
    id_viagem INT AUTO_INCREMENT PRIMARY KEY,           -- Identificador único da viagem
    id_usuario INT NOT NULL,                            -- Identificador do usuário associado à viagem
    nome VARCHAR(255) NOT NULL,                         -- Nome da viagem
    destino VARCHAR(255) NOT NULL,                      -- Destino da viagem
    data_ida DATE,                                      -- Data de início da viagem
    data_volta DATE,                                    -- Data de fim da viagem
    descricao TEXT,                                     -- Descrição detalhada da viagem
    CHECK (data_volta >= data_ida),                     -- Validação para garantir que a data de volta não seja anterior à data de ida
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela `atividade`
CREATE TABLE IF NOT EXISTS atividade (
    id_atividade INT AUTO_INCREMENT PRIMARY KEY,        -- Identificador único da atividade
    id_viagem INT NOT NULL,                             -- Referência à viagem relacionada
    nome VARCHAR(255) NOT NULL,                         -- Nome da atividade
    local_atividade VARCHAR(255),                       -- Local da atividade
    hora_inicio TIME,                                   -- Hora de início da atividade
    data_atividade DATE,                                -- Data da atividade
    duracao_minutos INT,                                -- Duração da atividade em minutos
    ordem INT,                                          -- Ordem da atividade na sequência da viagem
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela `hospedagem`
CREATE TABLE IF NOT EXISTS hospedagem (
    id_hospedagem INT AUTO_INCREMENT PRIMARY KEY,       -- Identificador único da hospedagem
    id_viagem INT NOT NULL,                             -- Referência à viagem relacionada
    nome VARCHAR(255),                                  -- Nome do local de hospedagem
    endereco VARCHAR(255),                              -- Endereço da hospedagem
    valor DECIMAL(10,2),                                 -- Valor da hospedagem
    data_checkin DATE,                                  -- Data de check-in
    data_checkout DATE,                                 -- Data de check-out
    hora_checkin TIME,                                  -- Hora de check-in
    hora_checkout TIME,                                 -- Hora de check-out
    contato_telefone VARCHAR(20),                       -- Telefone de contato da hospedagem
    contato_email VARCHAR(255),                         -- E-mail de contato da hospedagem
    tipo_hospedagem VARCHAR(100),                       -- Tipo de hospedagem (hotel, hostel, Airbnb, etc.)
    CHECK (data_checkout >= data_checkin),              -- Validação para garantir que a data de checkout não seja anterior à data de checkin
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela `transporte`
CREATE TABLE IF NOT EXISTS transporte (
    id_transporte INT AUTO_INCREMENT PRIMARY KEY,       -- Identificador único do transporte
    tipo_transporte ENUM('trem', 'aviao', 'onibus') NOT NULL, -- Tipo de transporte com valores restritos
    id_viagem INT NOT NULL,                             -- Referência à viagem relacionada
    status ENUM('confirmado', 'cancelado', 'pendente') DEFAULT 'confirmado', -- Status do transporte
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela `trem`
CREATE TABLE IF NOT EXISTS trem (
    id_transporte INT PRIMARY KEY,                      -- Reutilização do ID do transporte
    empresa VARCHAR(255),                               -- Empresa de transporte ferroviário
    numero_trem VARCHAR(50),                            -- Número do trem
    vagao VARCHAR(50),                                  -- Vagão do trem
    estacao_partida VARCHAR(255),                       -- Estação de partida
    numero_assento VARCHAR(20),                         -- Número do assento
    hora_partida TIME,                                  -- Hora de partida
    data_partida DATE,                                  -- Data de partida
    FOREIGN KEY (id_transporte) REFERENCES transporte(id_transporte)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela `aviao`
CREATE TABLE IF NOT EXISTS aviao (
    id_transporte INT PRIMARY KEY,                      -- Reutilização do ID do transporte
    numero_voo VARCHAR(50),                             -- Número do voo
    porta_embarque VARCHAR(10),                         -- Porta de embarque
    bagagem_info TEXT,                                  -- Informações sobre bagagem
    empresa VARCHAR(255),                               -- Companhia aérea
    hora_partida TIME,                                  -- Hora de partida
    data_partida DATE,                                  -- Data de partida
    FOREIGN KEY (id_transporte) REFERENCES transporte(id_transporte)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela `onibus`
CREATE TABLE IF NOT EXISTS onibus (
    id_transporte INT PRIMARY KEY,                      -- Reutilização do ID do transporte
    numero_linha VARCHAR(50),                           -- Número da linha do ônibus
    plataforma_embarque VARCHAR(50),                    -- Plataforma de embarque
    restricoes TEXT,                                    -- Restrições, se houver
    empresa VARCHAR(255),                               -- Empresa de ônibus
    assento VARCHAR(20),                                -- Assento
    hora_partida TIME,                                  -- Hora de partida
    data_partida DATE,                                  -- Data de partida
    FOREIGN KEY (id_transporte) REFERENCES transporte(id_transporte)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;
