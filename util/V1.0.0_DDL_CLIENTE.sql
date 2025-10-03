CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(100),
    cpf_cnpj VARCHAR(14),
    data_nascimento DATE,
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(150),
    cidade VARCHAR(50),
    estado CHAR(2),
    status_cliente ENUM('Ativo', 'Inativo')
);