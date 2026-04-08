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
	franqueiro INT,
	CONSTRAINT ctFkFranqueiro FOREIGN KEY(franqueiro) REFERENCES usuario(id_usuario),
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
('Carrefour', '45543915000181', 'Av. das Nações Unidas, 15187'),
('Extra', '06402330000129', 'Av. Brigadeiro Luís Antônio, 3172'),
('Supermercados BH', '04641376000136', 'Rod. MG-010, KM 18'),
('Assaí Atacadista', '06057223000171', 'Av. Aricanduva, 5555'),
('Muffato', '01648512000108', 'Rod. Celso Garcia Cid, 1100');

INSERT INTO usuario (email, senha, nivel_acesso, fk_empresa_parceira, franqueiro) VALUES 
('admin@carrefour.com', 'carr123', 'ADMIN', 1, NULL),
('op@carrefour.com', 'op123', 'OPERADOR', 1, 1),
('gerente@extra.com', 'ext456', 'ADMIN', 2, NULL),
('monitor@bh.com', 'bh789', 'OPERADOR', 3, NULL),
('adm@assai.com', 'assai00', 'ADMIN', 4, NULL);

INSERT INTO ponto_monitoramento (nome, fk_empresa) VALUES 
('Entrada Principal', 1),
('Setor Hortifruti', 1),
('Caixas Rápidos', 2),
('Corredor Central', 3),
('Área de Carga', 4);

INSERT INTO sensor (fk_ponto, status) VALUES 
(1, 'ATIVO'),
(2, 'ATIVO'),
(3, 'ATIVO'),
(4, 'DESATIVADO'),
(5, 'ATIVO');

INSERT INTO dado_captado (id_dado_captado, fk_sensor, data_hora, quantidade_pessoas) VALUES 
(1, 1, '2023-10-27 08:00:00', 12),
(2, 1, '2023-10-27 08:05:00', 25),
(1, 2, '2023-10-27 08:10:00', 8),
(1, 3, '2023-10-27 09:00:00', 15),
(1, 5, '2023-10-27 09:30:00', 40);

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

