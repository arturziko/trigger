CREATE DATABASE lojanova;
USE lojanova;
CREATE TABLE produtos(
id_produtos INT PRIMARY KEY auto_increment,
descricao VARCHAR(100),
preco FLOAT,
qt_estoque INT
);

CREATE TABLE pedidos(
id_pedidos INT PRIMARY KEY auto_increment,
qt_vendida INT,
data_venda DATETIME,
id_produtos INT,
FOREIGN KEY (id_produtos) REFERENCES produtos (id_produtos)
); 

INSERT INTO produtos (descricao, preco, qt_estoque)
VALUES
('celular', 2500.00, 10);

INSERT INTO produtos (descricao, preco, qt_estoque)
VALUES
('tablet', 1800.00, 5);

DELIMITER $$
CREATE TRIGGER tg_atualiza_estoque
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    UPDATE produtos 
    SET qt_estoque = qt_estoque - NEW.qt_vendida 
    WHERE id_produtos = NEW.id_produtos;
END $$
DELIMITER ;

DROP TRIGGER tg_atualiza_estoque;

SELECT * 
FROM produtos;

INSERT INTO pedidos (qt_vendida, data_venda, id_produtos)
VALUES
(2, '2026-04-24', 2);

SELECT * 
FROM pedidos;