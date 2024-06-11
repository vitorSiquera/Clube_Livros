# BookHub - Clube de Assinatura de Livros

## 1: Cenário

### Cenário: Clube de Assinatura de Livros

O "BookHub" é um clube de assinatura que oferece aos seus membros uma seleção personalizada de livros todo mês. Os membros pagam uma taxa mensal para receber livros baseados em suas preferências de gênero, autor, e histórico de leitura. Além disso, eles podem comprar livros adicionais com desconto.

Para gerenciar todas as operações do BookHub, é necessário um sistema de banco de dados que atenda às seguintes necessidades:

#### Membros:

- Cada membro possui um ID único, nome, email, endereço (composto por rua, número, cidade, estado e CEP), número de telefone e data de nascimento.
- Os membros podem ter múltiplos endereços de entrega e números de telefone.
- A data de adesão ao clube é derivada da data de registro.

#### Livros:

- Cada livro tem um ID único, título, autor (composto por primeiro nome e sobrenome), gênero, data de publicação e preço.
- Cada livro pode pertencer a múltiplos gêneros.

#### Assinaturas:

- Cada membro tem uma assinatura que define o plano (ID único, tipo de plano e valor mensal).
- Um membro pode mudar de plano e a data de início e término do plano atual é registrada.
- Cada plano é único para um membro em um dado momento.

#### Pedidos:

- Cada pedido possui um ID único, data do pedido, status do pedido (processado, enviado, entregue), e total do pedido.
- Um pedido pode incluir múltiplos livros e cada livro pode ser parte de múltiplos pedidos (relação muitos-para-muitos).
- A quantidade de cada livro no pedido é registrada.

#### Preferências:

- Cada membro pode selecionar seus gêneros preferidos.
- As preferências ajudam a personalizar a seleção de livros mensal.

### Resumindo as entidades e seus relacionamentos:

**Entidades:** Membros, Livros, Assinaturas, Pedidos, Preferências.

**Relacionamentos:**
- Um membro pode ter uma ou mais assinaturas (1).
- Um membro pode ter múltiplos endereços (1).
- Um membro pode fazer múltiplos pedidos (1).
- Um pedido pode conter múltiplos livros e cada livro pode estar em múltiplos pedidos (N).
- Cada membro pode selecionar múltiplos gêneros como preferência (N).


## 2: Modelagem Conceitual

![Logo do BookHub](/images/Diagrama%20em%20branco%20(1).png)

## 3: Moedelagem Lógica

![Logo do BookHub](/images/Entity%20Relationship%20Diagram%20(1).jpg)

## 4 - Modelagem Fisica

```sql
    -- Criação da tabela Membros
CREATE TABLE Membros (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Endereço_Rua VARCHAR(100) NOT NULL,
    Endereço_Numero VARCHAR(10) NOT NULL,
    Endereço_Cidade VARCHAR(50) NOT NULL,
    Endereço_Estado VARCHAR(20) NOT NULL,
    Endereço_CEP VARCHAR(10) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Data_Adesão DATE GENERATED ALWAYS AS (CURRENT_DATE) VIRTUAL
);

-- Criação da tabela Livros
CREATE TABLE Livros (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Título VARCHAR(200) NOT NULL,
    Autor_Primeiro_Nome VARCHAR(50) NOT NULL,
    Autor_Sobrenome VARCHAR(50) NOT NULL,
    Gênero VARCHAR(50) NOT NULL,
    Data_Publicação DATE NOT NULL,
    Preço DECIMAL(10,2) NOT NULL
);

-- Criação da tabela Assinaturas
CREATE TABLE Assinaturas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Plano VARCHAR(50) NOT NULL,
    Valor_Mensal DECIMAL(10,2) NOT NULL,
    Data_Início DATE NOT NULL,
    Data_Término DATE NOT NULL,
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

-- Criação da tabela Preferências
CREATE TABLE Preferências (
    Membro_ID INT,
    Gênero VARCHAR(50),
    PRIMARY KEY (Membro_ID, Gênero),
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
```

## 5 - Inserção de Dados

```sql
-- Inserindo dados na tabela Membros
INSERT INTO Membros (Nome, Email, Endereço_Rua, Endereço_Numero, Endereço_Cidade, Endereço_Estado, Endereço_CEP, Data_Nascimento, Data_Adesão)
VALUES 
('Alice Silva', 'alice.silva@example.com', 'Rua das Flores', '123', 'São Paulo', 'SP', '01000-000', '1990-01-15', '2023-06-01'),
('Bruno Santos', 'bruno.santos@example.com', 'Avenida Paulista', '456', 'São Paulo', 'SP', '01310-200', '1985-07-22', '2023-03-15'),
('Carla Mendes', 'carla.mendes@example.com', 'Rua das Laranjeiras', '789', 'Rio de Janeiro', 'RJ', '22240-100', '1992-11-03', '2023-04-10'),
('Diego Oliveira', 'diego.oliveira@example.com', 'Rua 25 de Março', '101', 'São Paulo', 'SP', '01021-100', '1988-05-17', '2023-02-20'),
('Elisa Souza', 'elisa.souza@example.com', 'Avenida Atlântica', '1111', 'Rio de Janeiro', 'RJ', '22021-001', '1993-09-30', '2023-05-12');

-- Inserindo dados na tabela Telefones
INSERT INTO Telefones (Membro_ID, Telefone)
VALUES 
(1, '11987654321'),
(2, '11912345678'),
(3, '21987654321'),
(4, '11922334455'),
(5, '21911223344');

-- Inserindo dados na tabela Livros
INSERT INTO Livros (Título, Autor_Primeiro_Nome, Autor_Sobrenome, Data_Publicação, Preço)
VALUES 
('Aventuras no Deserto', 'João', 'Souza', '2015-05-20', 45.90),
('Misterios Submarinos', 'Paula', 'Almeida', '2018-03-10', 60.00),
('O Código Perdido', 'Lucas', 'Martins', '2020-08-15', 39.90),
('Viagens Espaciais', 'Ana', 'Pereira', '2017-12-01', 70.50),
('Contos de Fantasia', 'Carlos', 'Silva', '2021-06-22', 55.00);

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
```

## 6 - CRUD
### 1 - Inserção e Leitura de Dados

Neste exemplo vamos Membros  em nossa tabela

```sql
INSERT INTO Membros (Nome, Email, Endereço_Rua, Endereço_Numero, Endereço_Cidade, Endereço_Estado, Endereço_CEP, Telefone, Data_Nascimento)
VALUES ('Carlos Dias', 'carlos.dias@example.com', 'Avenida Paulista', '2000', 'São Paulo', 'SP', '01310-000', '11987654322', '1985-03-25');
```

Lendo esses dados

```sql
SELECT * FROM Biomas;
```
Um print do que foi mostrado:

![Logo do BookHub](/images/add.png)

### 2 - Alteração e Delete de Dados

Agora vamos alterar o endereço do membro de id 1
```sql
-- Atualizando o endereço de um membro
UPDATE Membros
SET Endereço_Rua = 'Rua Nova', Endereço_Numero = '1234'
WHERE ID = 1;
```

![Logo do BookHub](/images/alterar.png)

## Deletando 

Agora iremos deletar o membro de ID 1

```sql
SELECT * FROM Membros WHERE ID = 1;

```

![Logo do BookHub](/images/delete.png)



