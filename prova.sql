-- Criação da tabela Membros
CREATE TABLE Membros (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Endereco_Rua VARCHAR(100) NOT NULL,
    Endereco_Numero VARCHAR(10) NOT NULL,
    Endereco_Cidade VARCHAR(50) NOT NULL,
    Endereco_Estado VARCHAR(20) NOT NULL,
    Endereco_CEP VARCHAR(10) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Data_Adesao DATE GENERATED ALWAYS AS (CURRENT_DATE) VIRTUAL
);

-- Criação da tabela Livros
CREATE TABLE Livros (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(200) NOT NULL,
    Autor_Primeiro_Nome VARCHAR(50) NOT NULL,
    Autor_Sobrenome VARCHAR(50) NOT NULL,
    Genero VARCHAR(50) NOT NULL,
    Data_Publicacao DATE NOT NULL,
    Preco DECIMAL(10,2) NOT NULL
);

-- Criação da tabela Assinaturas
CREATE TABLE Assinaturas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Plano VARCHAR(50) NOT NULL,
    Valor_Mensal DECIMAL(10,2) NOT NULL,
    Data_Inicio DATE NOT NULL,
    Data_Termino DATE NOT NULL,
    Membro_ID INT,
    FOREIGN KEY (Membro_ID) REFERENCES Membros(ID)
);

-- Criação da tabela Pedidos
CREATE TABLE Pedidos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Data_Pedido DATE NOT NULL,
    Status_Pedido VARCHAR(20) NOT NULL,
    Total_Pedido DECIMAL(10,2) NOT NULL,
    Membro_ID INT,
    FOREIGN KEY (Membro_ID) REFERENCES Membros(ID)
);

-- Criação da tabela Preferencias
CREATE TABLE Preferencias (
    Membro_ID INT,
    Genero VARCHAR(50),
    PRIMARY KEY (Membro_ID, Genero),
    FOREIGN KEY (Membro_ID) REFERENCES Membros(ID)
);

-- Criação da tabela Pedido_Livros (associativa)
CREATE TABLE Pedido_Livros (
    Pedido_ID INT,
    Livro_ID INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (Pedido_ID, Livro_ID),
    FOREIGN KEY (Pedido_ID) REFERENCES Pedidos(ID),
    FOREIGN KEY (Livro_ID) REFERENCES Livros(ID)
);


-- Inserindo dados na tabela Membros
INSERT INTO Membros (Nome, Email, Endereco_Rua, Endereco_Numero, Endereco_Cidade, Endereco_Estado, Endereco_CEP, Telefone, Data_Nascimento, Data_Adesao)
VALUES 
('Alice Silva', 'alice.silva@example.com', 'Rua das Flores', '123', 'Sao Paulo', 'SP', '01000-000', '4565-9652', '1990-01-15', '2023-06-01'),
('Bruno Santos', 'bruno.santos@example.com', 'Avenida Paulista', '456', 'Sao Paulo', 'SP', '01310-200', '5263-4124', '1985-07-22', '2023-03-15'),
('Carla Mendes', 'carla.mendes@example.com', 'Rua das Laranjeiras', '789', 'Rio de Janeiro', 'RJ', '22240-100', '4587-4521', '1992-11-03', '2023-04-10'),
('Diego Oliveira', 'diego.oliveira@example.com', 'Rua 25 de Marco', '101', 'Sao Paulo', 'SP', '01021-100', '8451-8552', '1988-05-17', '2023-02-20'),
('Elisa Souza', 'elisa.souza@example.com', 'Avenida Atlantica', '1111', 'Rio de Janeiro', 'RJ', '22021-001', '4578-5481', '1993-09-30', '2023-05-12');

-- Inserindo dados na tabela Telefones
INSERT INTO Telefones (Membro_ID, Telefone)
VALUES 
(1, '11987654321'),
(2, '11912345678'),
(3, '21987654321'),
(4, '11922334455'),
(5, '21911223344');

-- Inserindo dados na tabela Livros

INSERT INTO Livros (Titulo, Autor_Primeiro_Nome, Autor_Sobrenome, Data_Publicacao, Preco, Genero)
VALUES 
('Aventuras no Deserto', 'Joao', 'Souza', '2015-05-20', 45.90, 'Aventura'),
('Misterios Submarinos', 'Paula', 'Almeida', '2018-03-10', 60.00, 'Misterio'),
('O Codigo Perdido', 'Lucas', 'Martins', '2020-08-15', 39.90, 'Suspense'),
('Viagens Espaciais', 'Ana', 'Pereira', '2017-12-01', 70.50, 'Ficcao Cientifica'),
('Contos de Fantasia', 'Carlos', 'Silva', '2021-06-22', 55.00, 'Fantasia');


-- Inserindo dados na tabela Livro_Gêneros (Tabela Associativa)
INSERT INTO Livro_Gêneros (Livro_ID, Gênero)
VALUES 
(1, 'Aventura'),
(2, 'Mistério'),
(3, 'Ficção Científica'),
(4, 'Ficção Científica'),
(5, 'Fantasia');

-- Inserindo dados na tabela Assinaturas
INSERT INTO Assinaturas (Tipo_Plano, Valor_Mensal, Data_Início, Data_Término, Membro_ID)
VALUES 
('Básico', 29.90, '2023-01-01', '2023-12-31', 1),
('Premium', 49.90, '2023-02-01', '2023-11-30', 2),
('Básico', 29.90, '2023-03-01', '2023-09-30', 3),
('Gold', 69.90, '2023-01-15', '2023-12-15', 4),
('Básico', 29.90, '2023-05-01', '2024-04-30', 5);

-- Inserindo dados na tabela Pedidos
INSERT INTO Pedidos (Data_Pedido, Status_Pedido, Total_Pedido, Membro_ID)
VALUES 
('2023-06-15', 'Enviado', 120.50, 1),
('2023-04-20', 'Processando', 75.00, 2),
('2023-05-05', 'Entregue', 200.00, 3),
('2023-06-01', 'Cancelado', 30.00, 4),
('2023-07-10', 'Enviado', 150.75, 5);

-- Inserindo dados na tabela Pedido_Livros (Tabela Associativa)
INSERT INTO Pedido_Livros (Pedido_ID, Livro_ID, Quantidade)
VALUES 
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 1),
(5, 5, 2);

-- Inserindo dados na tabela Preferências
INSERT INTO Preferências (Membro_ID, Gênero)
VALUES 
(1, 'Ficção Científica'),
(2, 'Aventura'),
(3, 'Mistério'),
(4, 'Ficção Científica'),
(5, 'Fantasia');

-- Consultando todos os membros
SELECT * FROM Membros;

-- Atualizando o endereço de um membro
UPDATE Membros
SET Endereço_Rua = 'Rua Nova', Endereço_Numero = '1234'
WHERE ID = 1;

-- Deletando um membro
DELETE FROM Membros
WHERE ID = 1;

--Consultas
--1
SELECT Membros.Nome, Assinaturas.Tipo_Plano, Assinaturas.Valor_Mensal
FROM Membros
JOIN Assinaturas ON Membros.ID = Assinaturas.Membro_ID
WHERE Assinaturas.Data_Termino >= CURDATE();

--2
SELECT Membros.Nome, Pedidos.Data_Pedido, Pedidos.Total_Pedido
FROM Membros
JOIN Pedidos ON Membros.ID = Pedidos.Membro_ID
ORDER BY Membros.Nome;

--3
SELECT Membros.Nome, Preferências.Gênero
FROM Membros
JOIN Preferencias ON Membros.ID = Preferências.Membro_ID
ORDER BY Membros.Nome;

--4
SELECT Livros.Titulo, SUM(Pedido_Livros.Quantidade) AS Total_Comprado
FROM Livros
JOIN Pedido_Livros ON Livros.ID = Pedido_Livros.Livro_ID
GROUP BY Livros.Titulo
ORDER BY Total_Comprado DESC;

--5

SELECT Membros.Nome, SUM(Pedidos.Total_Pedido) AS Receita_Total
FROM Membros
JOIN Pedidos ON Membros.ID = Pedidos.Membro_ID
GROUP BY Membros.Nome
ORDER BY Receita_Total DESC;

--6
SELECT m.Nome, p.*
FROM Membros m
INNER JOIN Pedidos p ON m.ID = p.Membro_ID
WHERE p.Status_Pedido = 'Enviado';

--7

SELECT DISTINCT l.Título, l.Autor_Primeiro_Nome, l.Autor_Sobrenome
FROM Livros l
INNER JOIN Pedido_Livros pl ON l.ID = pl.Livro_ID;

--8

SELECT lg.Gênero, COUNT(pl.Livro_ID) AS Quantidade_Pedidos
FROM Livro_Generos lg
INNER JOIN Pedido_Livros pl ON lg.Livro_ID = pl.Livro_ID
GROUP BY lg.Genero;

--9

SELECT DISTINCT m.Nome
FROM Membros m
INNER JOIN Pedidos p ON m.ID = p.Membro_ID
INNER JOIN Pedido_Livros pl ON p.ID = pl.Pedido_ID
INNER JOIN Livros l ON pl.Livro_ID = l.ID
WHERE l.Genero = 'Ficção Científica';

--10
SELECT SUM(a.Valor_Mensal) AS Receita_Total
FROM Assinaturas a;
