PRAGMA foreign_keys=ON;

DROP TABLE IF EXISTS PESSOA;

CREATE TABLE PESSOA(
id INT PRIMARY KEY NOT NULL,
nome TEXT NOT NULL,
data_nascimento DATE NOT NULL,
morada TEXT NOT NULL,
telefone TEXT NOT NULL UNIQUE,
email TEXT NOT NULL UNIQUE
);

DROP TABLE IF EXISTS CLIENTE;

CREATE TABLE CLIENTE(
id INT PRIMARY KEY NOT NULL,
id_carta_conducao INT NOT NULL UNIQUE,
validade_carta DATE NOT NULL,
data_emissao_carta DATE NOT NULL,
FOREIGN KEY(id) REFERENCES PESSOA(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS FUNCIONARIO;

CREATE TABLE FUNCIONARIO(
id INT PRIMARY KEY NOT NULL,
horas_semanais INT NOT NULL CHECK(horas_semanais >= 0),
salario_hora REAL NOT NULL CHECK(salario_hora >= 0),
FOREIGN KEY(id) REFERENCES PESSOA(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS MARCA;

CREATE TABLE MARCA(
nome TEXT PRIMARY KEY NOT NULL
);

DROP TABLE IF EXISTS MODELO;

CREATE TABLE MODELO(
nome TEXT PRIMARY KEY NOT NULL,
categoria TEXT NOT NULL,
marca TEXT NOT NULL,
FOREIGN KEY(marca) REFERENCES MARCA(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS CARRO;

CREATE TABLE CARRO(
id INT PRIMARY KEY NOT NULL,
matricula TEXT NOT NULL UNIQUE,
modelo TEXT NOT NULL,
FOREIGN KEY(modelo) REFERENCES MODELO(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS SEGURADORA;

CREATE TABLE SEGURADORA(
nome TEXT PRIMARY KEY NOT NULL,
morada TEXT NOT NULL,
telefone TEXT NOT NULL UNIQUE,
email TEXT NOT NULL UNIQUE
);

DROP TABLE IF EXISTS SEGURO;

CREATE TABLE SEGURO(
id INT PRIMARY KEY NOT NULL,
tipo TEXT NOT NULL,
descricao TEXT NOT NULL,
preco REAL NOT NULL CHECK(preco >=0),
);

DROP TABLE IF EXISTS SEGURADORA_SEGURO;

CREATE TABLE SEGURADORA_SEGURO(
seguradora TEXT NOT NULL,
seguro INT NOT NULL,
PRIMARY KEY(seguradora, seguro),
FOREIGN KEY(seguradora) REFERENCES SEGURADORA(nome) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(seguro) REFERENCES SEGURO(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS PLANO_ALUGUER;

CREATE TABLE PLANO_ALUGUER(
id INT PRIMARY KEY NOT NULL,
nome TEXT NOT NULL UNIQUE,
descricao TEXT NOT NULL,
preco_diaria REAL NOT NULL CHECK(preco_diaria >=0)
);

DROP TABLE IF EXISTS PLANO_ALUGUER_MODELO;

CREATE TABLE PLANO_ALUGUER_MODELO(
aid INT NOT NULL,
nome TEXT NOT NULL,
PRIMARY KEY(aid, nome),
FOREIGN KEY(aid) REFERENCES PLANO_ALUGUER(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(nome) REFERENCES MODELO(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS ALUGUER_SEGURO;	

CREATE TABLE ALUGUER_SEGURO(
id_aluguer INT NOT NULL,
id_seguro INT NOT NULL,
PRIMARY KEY(id_aluguer, id_seguro),
FOREIGN KEY(id_aluguer) REFERENCES ALUGUER(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(id_seguro) REFERENCES SEGURO(id) ON DELETE CASCADE ON UPDATE CASCADE
);




DROP TABLE IF EXISTS EXTRA;

CREATE TABLE EXTRA(
id INT PRIMARY KEY NOT NULL,
nome TEXT NOT NULL UNIQUE,
descricao TEXT NOT NULL,
valor REAL NOT NULL CHECK(valor >= 0)
);

DROP TABLE IF EXISTS ALUGUER;

CREATE TABLE ALUGUER(
id INT PRIMARY KEY NOT NULL,
cliente_id INT NOT NULL,
morada TEXT NOT NULL,
plano_id INT NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE NOT NULL,
hora_inicio TEXT NOT NULL,
hora_fim TEXT NOT NULL,
CHECK(data_inicio < data_fim),
FOREIGN KEY(cliente_id) REFERENCES CLIENTE(id),
FOREIGN KEY(morada) REFERENCES LOCAL_LEVANTAMENTO(morada) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(plano_id) REFERENCES PLANO_ALUGUER(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS QUANTIDADE;

CREATE TABLE QUANTIDADE(
aluguer_id INT NOT NULL,
extra_id INT NOT NULL,
qtd INT CHECK(qtd >= 0),
PRIMARY KEY(aluguer_id, extra_id),
FOREIGN KEY(aluguer_id) REFERENCES ALUGUER(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(extra_id) REFERENCES EXTRA(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS ENTREGA;

CREATE TABLE ENTREGA(
aluguer_id INT NOT NULL,
funcionario_id INT NOT NULL,
estado_veiculo TEXT NOT NULL,
PRIMARY KEY(aluguer_id, funcionario_id),
FOREIGN KEY(aluguer_id) REFERENCES ALUGUER(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(funcionario_id) REFERENCES FUNCIONARIO(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS DEVOLUCAO;

CREATE TABLE DEVOLUCAO(
aluguer_id INT NOT NULL,
funcionario_id INT NOT NULL,
estado_veiculo TEXT NOT NULL,
PRIMARY KEY(aluguer_id, funcionario_id),
FOREIGN KEY(aluguer_id) REFERENCES ALUGUER(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(funcionario_id) REFERENCES FUNCIONARIO(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS LOCAL_LEVANTAMENTO;

CREATE TABLE LOCAL_LEVANTAMENTO(
id INT PRIMARY KEY NOT NULL,
morada NOT NULL UNIQUE
);



