CREATE TABLE empresa_parceira(
	id_empresa INT PRIMARY KEY AUTO_INCREMENT, 
	nome VARCHAR(45) NOT NULL,
  cnpj CHAR(14) NOT NULL,
	endereco VARCHAR(45) NOT NULL
);

CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(45) NOT NULL,
	senha VARCHAR(45) NOT NULL,
	nivel_acesso VARCHAR(45) NOT NULL,
	fk_empresa_parceira INT NOT NULL,
	CONSTRAINT ctFkUsuarioEmpresa FOREIGN KEY(fk_empresa_parceira) REFERENCES empresa_parceira(id_empresa),
	CONSTRAINT ctNivelAcesso CHECK (nivel_acesso IN ('ADMIN','OPERADOR'))
);

CREATE TABLE ponto_monitoramento (
	id_ponto_monitoramento INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	fk_empresa INT NOT NULL,
	CONSTRAINT ctFKponto_empresa FOREIGN KEY(fk_empresa) REFERENCES empresa_parceira(id_empresa)
);

CREATE TABLE sensor(
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
	fk_ponto INT NOT NULL,
	status VARCHAR(45),
	CONSTRAINT ctFkSensorPonto FOREIGN KEY (fk_ponto) REFERENCES ponto_monitoramento(id_ponto_monitoramento),
	CONSTRAINT ctStatus CHECK (status IN ('ATIVO','DESATIVADO'))
);

CREATE TABLE dado_captado(
	id_dado_captado INT, 
	fk_sensor INT NOT NULL,
	data_hora DATETIME,
	quantidade_pessoas INT,
	CONSTRAINT chave_composta PRIMARY KEY (id_dado_captado, fk_sensor),
	CONSTRAINT ctFkDadoSensor FOREIGN KEY(fk_sensor) REFERENCES sensor(id_sensor)
);

INSERT INTO empresa_parceira (nome, cnpj, endereco) VALUES
('Empresa Alpha', '12345678000101', 'Rua A, 100'),
('Empresa Beta', '22345678000102', 'Rua B, 200'),
('Empresa Gamma', '32345678000103', 'Rua C, 300'),
('Empresa Delta', '42345678000104', 'Rua D, 400'),
('Empresa Epsilon', '52345678000105', 'Rua E, 500');

INSERT INTO usuario (email, senha, nivel_acesso, fk_empresa_parceira) VALUES
('admin@alpha.com', '123', 'ADMIN', 1),
('op@beta.com', '123', 'OPERADOR', 2),
('admin@gamma.com', '123', 'ADMIN', 3),
('op@delta.com', '123', 'OPERADOR', 4),
('admin@epsilon.com', '123', 'ADMIN', 5);

INSERT INTO ponto_monitoramento (nome, fk_empresa) VALUES
('Entrada Principal', 1),
('Saída Lateral', 2),
('Recepção', 3),
('Estacionamento', 4),
('Corredor', 5);

INSERT INTO sensor (fk_ponto, status) VALUES
(1, 'ATIVO'),
(2, 'ATIVO'),
(3, 'DESATIVADO'),
(4, 'ATIVO'),
(5, 'ATIVO');

INSERT INTO dado_captado (id_dado_captado, fk_sensor, data_hora, quantidade_pessoas) VALUES
(1, 1, '2026-04-01 08:00:00', 10),
(2, 2, '2026-04-01 08:05:00', 5),
(3, 3, '2026-04-01 08:10:00', 0),
(4, 4, '2026-04-01 08:15:00', 7),
(5, 5, '2026-04-01 08:20:00', 12);

SELECT * FROM sensor;
SELECT * FROM ponto_monitoramento;
SELECT * FROM usuario;
SELECT * FROM dado_captado;
SELECT * FROM empresa_parceira;
SELECT * FROM franquia;

select 
	s.status, 
    p.nome, 
    e.nome 
from sensor as s
join ponto_monitoramento as p on s.fk_ponto = id_ponto_monitoramento
join empresa_parceira as e on e.id_empresa = fk_empresa;

