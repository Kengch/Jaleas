CREATE OR REPLACE VIEW vista_detalles AS
SELECT *
FROM detalle;

CREATE OR REPLACE VIEW vista_marcas AS
SELECT *
FROM marca;

CREATE OR REPLACE VIEW vista_lugar_creacion AS
SELECT *
FROM lugar_creacion;

CREATE OR REPLACE VIEW vista_tipo_movimiento AS
SELECT *
FROM tipo_movimiento;

CREATE OR REPLACE VIEW vista_tipo_persona AS
SELECT *
FROM tipo_persona;

CREATE OR REPLACE VIEW vista_persona AS
SELECT *
FROM persona;

CREATE OR REPLACE VIEW vista_movimientos AS
SELECT *
FROM movimiento;

CREATE OR REPLACE VIEW vista_productos AS
SELECT *
FROM producto;