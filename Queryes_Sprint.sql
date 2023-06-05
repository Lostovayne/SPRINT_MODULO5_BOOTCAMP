-- Active: 1684982784502@@127.0.0.1@3306@telo_vendo_store

-- Crear usuario con todos los privilegios
CREATE USER 'telo_vendo_store'@'127.0.0.1' IDENTIFIED BY 'telo_vendo_store';

-- Agregar privilegios al usuario
GRANT ALL PRIVILEGES ON Telo_Vendo_Store.* TO 'telo_vendo_store'@'127.0.0.1';

-- La relación entre las entidades sería la siguiente:
-- - Un proveedor puede tener muchos productos.
-- - Un producto puede tener muchos proveedores.
-- - Un producto puede tener muchos stocks.
-- - Un cliente puede tener muchos stocks.
-- - Un proveedor puede tener muchas facturas.
-- - Un cliente puede tener muchas facturas.


CREATE TABLE Proveedor(
  id_proveedor INT NOT NULL AUTO_INCREMENT,
  nombre_representante VARCHAR(50) NOT NULL,
  nombre_corporativo VARCHAR(50) NOT NULL,
  telefono1 VARCHAR(50) NOT NULL,
  telefono2 VARCHAR(50) NOT NULL,
  nombre_contacto VARCHAR(50) NOT NULL,
  categoria_producto VARCHAR(50) NOT NULL,
  correo_electronico VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_proveedor)
);


CREATE TABLE Producto(
  id_producto INT NOT NULL AUTO_INCREMENT,
  nombre_producto VARCHAR(50) NOT NULL,
  precio INT NOT NULL,
  categoria VARCHAR(50) NOT NULL,
  color VARCHAR(50) NOT NULL,
  id_proveedor INT NOT NULL,
  PRIMARY KEY (id_producto),
  FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);


CREATE TABLE Cliente(
  id_cliente INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_cliente)
);


CREATE TABLE Stock(
  id_stock INT NOT NULL AUTO_INCREMENT,
  cantidad INT NOT NULL,
  id_producto INT NOT NULL,
  PRIMARY KEY (id_stock),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);


CREATE TABLE Producto_has_Cliente(
  id_producto INT NOT NULL,
  id_cliente INT NOT NULL,
  PRIMARY KEY (id_producto, id_cliente),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);


-- Proveedores
INSERT INTO Proveedor (id_proveedor, nombre_representante, nombre_corporativo, telefono1, telefono2, nombre_contacto, categoria_producto, correo_electronico) 
VALUES 
(1, 'Juan Perez', 'Corporativo SA', '555-1234', '555-5678', 'Maria Garcia', 'Electrónica', 'juanperez@corporativo.com'),
(2, 'Ana Rodriguez', 'Productos Naturales SRL', '555-4321', '555-8765', 'Pedro Gomez', 'Alimentos', 'anarodriguez@productosnaturales.com'),
(3, 'Luisa Martinez', 'Martinez y Asociados', '555-1111', '555-2222', 'Carlos Sanchez', 'Servicios', 'luisamartinez@martinezyasociados.com'),
(4, 'Pedro Fernandez', 'Fernandez y Cia', '555-3333', '555-4444', 'Laura Torres', 'Electrónica', 'pedrofernandez@fernandezycia.com'),
(5, 'Maria Rodriguez', 'Rodriguez SA', '555-5555', '555-6666', 'Juan Perez', 'Alimentos', 'mariarodriguez@rodriguezsa.com'),
(6, 'Carlos Gomez', 'Gomez y Asociados', '555-7777', '555-8888', 'Ana Rodriguez', 'Servicios', 'carlosgomez@gomezyasociados.com'),
(7, 'Laura Torres', 'Torres SA', '555-9999', '555-0000', 'Pedro Fernandez', 'Electrónica', 'lauratorres@torressa.com'),
(8, 'Juan Perez', 'Perez y Cia', '555-1212', '555-3434', 'Maria Garcia', 'Alimentos', 'juanperez@perezycia.com'),
(9, 'Pedro Gomez', 'Gomez SA', '555-5656', '555-7878', 'Ana Rodriguez', 'Electrónica', 'pedrogomez@gomezsa.com'),
(10, 'Ana Rodriguez', 'Rodriguez y Asociados', '555-9898', '555-1212', 'Carlos Sanchez', 'Servicios', 'anarodriguez@rodriguezyasociados.com');



-- Producto

INSERT INTO Producto (nombre_producto, precio, categoria, color, id_proveedor) VALUES 
('Smartphone', 500, 'Electrónica', 'Negro', 1),
('Tablet', 300, 'Electrónica', 'Blanco', 1),
('Celular', 100, 'Electrónica', 'Dorado', 2),
('Aceite de Oliva', 20, 'Alimentos', 'Verde', 2),
('Laptop', 800, 'Electrónica', 'Gris', 1),
('Café', 5, 'Alimentos', 'Marrón', 2),
('Televisor', 1000, 'Electrónica', 'Negro', 1),
('Mermelada', 8, 'Alimentos', 'Rojo', 2),
('Altavoz', 50, 'Electrónica', 'Azul', 1),
('Mantequilla', 6, 'Alimentos', 'Amarillo', 2);


-- Cliente

INSERT INTO Cliente (nombre, apellido, direccion) VALUES 
('Juan', 'Pérez', 'Calle 1, Ciudad 1'),
('María', 'García', 'Calle 2, Ciudad 2'),
('Pedro', 'Martínez', 'Calle 3, Ciudad 3'),
('Ana', 'López', 'Calle 4, Ciudad 4'),
('Luis', 'Hernández', 'Calle 5, Ciudad 5'),
('Sofía', 'González', 'Calle 6, Ciudad 6'),
('Carlos', 'Díaz', 'Calle 7, Ciudad 7'),
('Laura', 'Ruiz', 'Calle 8, Ciudad 8'),
('Jorge', 'Sánchez', 'Calle 9, Ciudad 9'),
('Lucía', 'Torres', 'Calle 10, Ciudad 10');


-- Stock

INSERT INTO Stock (cantidad, id_producto) VALUES 
(100, 1),
(50, 2),
(200, 3),
(150, 4),
(75, 5),
(300, 6),
(25, 7),
(100, 8),
(50, 9),
(200, 10);


-- Luego debemos realizar consultas SQL que indiquen:



-- -Cuál es la categoría de productos que más se repite.
SELECT categoria, COUNT(*) FROM Producto GROUP BY categoria LIMIT 1;

-- Cuáles son los productos con mayor stock
SELECT id_producto, cantidad FROM Stock ORDER BY cantidad DESC LIMIT 3 ;

-- Qué color de producto es más común en nuestra tienda.
SELECT color, COUNT(*) FROM Producto GROUP BY color LIMIT 1;

-- Cual o cuales son los proveedores con menor stock de productos.
SELECT id_proveedor, COUNT(*) FROM producto GROUP BY  id_proveedor LIMIT 2 ;

-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
UPDATE Producto SET categoria = 'Electrónica y computación' WHERE categoria = 'Electrónica';
-- Prueba de que funciona
SELECT * FROM Producto;



