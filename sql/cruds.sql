--CRUD DETALLE--
--insertar
CREATE OR REPLACE PROCEDURE insertar_detalle(
    nombre_detalle IN VARCHAR2
) AS
BEGIN
    INSERT INTO detalle(nombre_detalle, fecha_creacion, fecha_modificacion) 
    VALUES(nombre_detalle, SYSDATE, SYSDATE);
    COMMIT;
END;

--obtner detalles no funciona
CREATE OR REPLACE PROCEDURE obtener_detalles(
    cursor_ OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN cursor_ FOR SELECT * FROM detalle;
END;

VAR cursor_ REFCURSOR;
BEGIN
    obtener_detalles(:cursor_);
END;
PRINT cursor_;

CREATE OR REPLACE PROCEDURE actualizar_detalle(
    id_ IN DETALLE.ID%TYPE,
    nombre_detalle IN DETALLE.NOMBRE_DETALLE%TYPE
) AS
BEGIN
    UPDATE detalle SET nombre_detalle = nombre_detalle, fecha_modificacion = SYSDATE WHERE id = id_;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE eliminar_detalle(
    id_ IN DETALLE.ID%TYPE
) AS
BEGIN
    DELETE FROM detalle WHERE id = id_;
    COMMIT;
END;

--CRUD MARCA
CREATE OR REPLACE PROCEDURE insertar_marca(
    p_nombre IN marca.nombre%TYPE
)
IS
BEGIN
    INSERT INTO marca (id, nombre, fecha_creacion, fecha_modificacion) 
    VALUES (marca_id_seq.NEXTVAL, p_nombre, SYSDATE, SYSDATE);
    COMMIT;
END insertar_marca;

CREATE OR REPLACE PROCEDURE actualizar_marca(
    p_id IN marca.id%TYPE,
    p_nombre IN marca.nombre%TYPE
)
IS
BEGIN
    UPDATE marca SET nombre = p_nombre, fecha_modificacion = SYSDATE
    WHERE id = p_id;
    COMMIT;
END actualizar_marca;

CREATE OR REPLACE PROCEDURE eliminar_marca(
    p_id IN marca.id%TYPE
)
IS
BEGIN
    DELETE FROM marca WHERE id = p_id;
    COMMIT;
END eliminar_marca;

CREATE OR REPLACE PROCEDURE obtener_marca_por_id(
    p_id IN marca.id%TYPE,
    cursor_ OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN cursor_ FOR SELECT * FROM marca WHERE id = p_id;
END obtener_marca_por_id;

CREATE OR REPLACE PROCEDURE obtener_marcas(
    cursor_ OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN cursor_ FOR SELECT * FROM marca;
END obtener_marcas;

--CRUD lugar_creacion
CREATE OR REPLACE PROCEDURE crear_lugar_creacion(
    p_direccion IN lugar_creacion.direccion%TYPE,
    p_canton IN lugar_creacion.canton%TYPE
)
IS
BEGIN
    INSERT INTO lugar_creacion (direccion, canton, fecha_creacion, fecha_modificacion)
    VALUES (p_direccion, p_canton, SYSDATE, SYSDATE);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE obtener_lugar_creacion(
    p_id IN lugar_creacion.id%TYPE,
    cursor_ OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN cursor_ FOR SELECT * FROM lugar_creacion WHERE id = p_id;
END;

CREATE OR REPLACE PROCEDURE actualizar_lugar_creacion(
    p_id IN lugar_creacion.id%TYPE,
    p_direccion IN lugar_creacion.direccion%TYPE,
    p_canton IN lugar_creacion.canton%TYPE
)
IS
BEGIN
    UPDATE lugar_creacion
    SET direccion = p_direccion, canton = p_canton, fecha_modificacion = SYSDATE
    WHERE id = p_id;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE eliminar_lugar_creacion(
    p_id IN lugar_creacion.id%TYPE
)
IS
BEGIN
    DELETE FROM lugar_creacion WHERE id = p_id;
    COMMIT;
END;

--crud tipo movimiento

CREATE OR REPLACE PROCEDURE insertar_tipo_movimiento(
    p_descripcion IN tipo_movimiento.descripcion%TYPE
)
IS
BEGIN
    INSERT INTO tipo_movimiento(descripcion, fecha_creacion, fecha_modificacion)
    VALUES(p_descripcion, SYSDATE, SYSDATE);
    COMMIT;
END ;

CREATE OR REPLACE PROCEDURE actualizar_tipo_movimiento(
    p_id IN tipo_movimiento.id%TYPE,
    p_descripcion IN tipo_movimiento.descripcion%TYPE,
    p_resultado OUT VARCHAR2
)
IS
BEGIN
    UPDATE tipo_movimiento
    SET descripcion = p_descripcion, fecha_modificacion = SYSDATE
    WHERE id = p_id;
    IF SQL%ROWCOUNT = 1 THEN
        p_resultado := 'Registro actualizado correctamente.';
    ELSE
        p_resultado := 'El registro no existe.';
    END IF;
    COMMIT;
END ;

CREATE OR REPLACE PROCEDURE eliminar_tipo_movimiento(
    p_id IN tipo_movimiento.id%TYPE,
    p_resultado OUT VARCHAR2
)
IS
BEGIN
    DELETE FROM tipo_movimiento WHERE id = p_id;
    IF SQL%ROWCOUNT = 1 THEN
        p_resultado := 'Registro eliminado correctamente.';
    ELSE
        p_resultado := 'El registro no existe.';
    END IF;
    COMMIT;
END ;

CREATE OR REPLACE PROCEDURE obtener_tipo_movimiento(
    p_id IN tipo_movimiento.id%TYPE,
    p_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM tipo_movimiento WHERE id = p_id;
END ;

CREATE OR REPLACE PROCEDURE obtener_tipo_movimientos(
    p_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM tipo_movimiento;
END;

--crud tipo persona
CREATE OR REPLACE PROCEDURE insertar_tipo_persona(
    p_descripcion IN tipo_persona.descripcion%TYPE,
    p_mensaje OUT VARCHAR2
)
IS
BEGIN
    INSERT INTO tipo_persona(descripcion, fecha_creacion, fecha_modificacion)
    VALUES (p_descripcion, SYSDATE, SYSDATE);
    
END;

CREATE OR REPLACE PROCEDURE actualizar_tipo_persona(
    p_id IN tipo_persona.id%TYPE,
    p_descripcion IN tipo_persona.descripcion%TYPE,
    p_mensaje OUT VARCHAR2
)
IS
BEGIN
    UPDATE tipo_persona
    SET descripcion = p_descripcion
    WHERE id = p_id;
END;

CREATE OR REPLACE PROCEDURE eliminar_tipo_persona(
    p_id IN tipo_persona.id%TYPE,
    p_mensaje OUT VARCHAR2
)
IS
BEGIN
    DELETE FROM tipo_persona WHERE id = p_id;
    
END ;

CREATE OR REPLACE PROCEDURE obtener_tipo_persona(
    p_id IN tipo_persona.id%TYPE,
    p_recordset OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_recordset FOR SELECT * FROM tipo_persona WHERE id = p_id;
END ;

CREATE OR REPLACE PROCEDURE obtener_tipos_personas(
    p_recordset OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_recordset FOR SELECT * FROM tipo_persona;
END ;

--crud persona
CREATE OR REPLACE PROCEDURE insertar_persona (
    p_nombre     IN persona.nombre%TYPE,
    p_apellidos  IN persona.apellidos%TYPE,
    p_correo     IN persona.correo%TYPE,
    p_cedula     IN persona.cedula%TYPE,
    p_tipo_persona_id IN persona.id_tipo_persona%TYPE
)
AS
BEGIN
    INSERT INTO persona (nombre, apellidos, correo, cedula, id_tipo_persona, fecha_creacion, fecha_modificacion)
    VALUES (p_nombre, p_apellidos, p_correo, p_cedula, p_tipo_persona_id, SYSDATE, SYSDATE);
END;

CREATE OR REPLACE PROCEDURE actualizar_persona (
    p_id_persona    IN persona.id%TYPE,
    p_nombre        IN persona.nombre%TYPE,
    p_apellidos     IN persona.apellidos%TYPE,
    p_correo        IN persona.correo%TYPE,
    p_cedula        IN persona.cedula%TYPE,
    p_tipo_persona_id IN persona.id_tipo_persona%TYPE
)
AS
BEGIN
    UPDATE persona SET 
        nombre = p_nombre,
        apellidos = p_apellidos,
        correo = p_correo,
        cedula = p_cedula,
        id_tipo_persona = p_tipo_persona_id
    WHERE id = p_id_persona;
END;

CREATE OR REPLACE PROCEDURE eliminar_persona (
    p_id_persona    IN persona.id%TYPE
)
AS
BEGIN
    DELETE FROM persona WHERE id = p_id_persona;
END;

CREATE OR REPLACE PROCEDURE obtener_personas(cursor_ OUT SYS_REFCURSOR)
IS
BEGIN
  OPEN cursor_ FOR SELECT * FROM persona;
END ;



--crud movimiento

CREATE OR REPLACE PROCEDURE insertar_movimiento(
    id_producto IN movimiento.id_producto%TYPE,
    id_tipo_movimiento IN movimiento.id_tipo_movimiento%TYPE,
    id_persona IN movimiento.id_persona%TYPE,
    mensaje OUT VARCHAR2
)
IS
BEGIN
    INSERT INTO movimiento (id_producto, id_tipo_movimiento, id_persona, fecha_creacion, fecha_modificacion)
    VALUES (id_producto, id_tipo_movimiento, id_persona, SYSDATE, SYSDATE);
    
    mensaje := 'Registro insertado exitosamente';
END;

CREATE OR REPLACE PROCEDURE actualizar_movimiento(
    id IN movimiento.id%TYPE,
    id_producto IN movimiento.id_producto%TYPE,
    id_tipo_movimiento IN movimiento.id_tipo_movimiento%TYPE,
    id_persona IN movimiento.id_persona%TYPE,
    mensaje OUT VARCHAR2
)
IS
BEGIN
    UPDATE movimiento
    SET id_producto = id_producto,
        id_tipo_movimiento = id_tipo_movimiento,
        id_persona = id_persona
    WHERE id = id;
END;

CREATE OR REPLACE PROCEDURE eliminar_movimiento(
    id IN movimiento.id%TYPE,
    mensaje OUT VARCHAR2
)
IS
BEGIN
    DELETE FROM movimiento
    WHERE id = id;
END;


CREATE OR REPLACE PROCEDURE obtener_movimientos(cursor_ OUT SYS_REFCURSOR)
IS
BEGIN
  OPEN cursor_ FOR SELECT * FROM movimiento;
END ;

 

--crud producto
CREATE OR REPLACE PROCEDURE insertar_producto(
    p_nombre IN producto.nombre%TYPE,
    id_detalle IN producto.id_detalle%TYPE,
    id_marca IN producto.id_marca%TYPE,
    id_lugar_creacion IN producto.id_lugar_creacion%TYPE,
    nombre IN producto.nombre%TYPE,
    precio IN producto.precio%TYPE,
    peso IN producto.peso%TYPE,
    fecha_vencimiento IN producto.fecha_vencimiento%TYPE,
) AS
BEGIN
    INSERT INTO producto(nombre, id_detalle, id_marca, id_lugar_creacion, nombre,peso, precio, fecha_creacion, fecha_modificacion)
    VALUES (p_nombre, id_detalle, id_marca, id_lugar_creacion, nombre, peso,precio, SYSDATE, SYSDATE);
    
    p_resultado := 'Producto insertado correctamente';

END ;

CREATE OR REPLACE PROCEDURE actualizar_producto(
    p_id IN producto.id%TYPE,
    nombre IN producto.nombre%TYPE,
    id_detalle IN producto.id_detalle%TYPE,
    id_marca IN producto.id_marca%TYPE,
    id_lugar_creacion IN producto.id_lugar_creacion%TYPE,
    nombre IN producto.nombre%TYPE,
    precio IN producto.precio%TYPE,
    peso IN producto.peso%TYPE
) AS
BEGIN
    UPDATE producto SET 
        nombre = p_nombre, 
        id_detalle = id_detalle, 
        id_marca = id_marca, 
        id_lugar_creacion = id_lugar_creacion,
        nombre = nombre, 
        precio = precio, 
        peso = peso, 
    WHERE id = p_id;

END ;

CREATE OR REPLACE PROCEDURE eliminar_producto(
    p_id IN producto.id%TYPE
) AS
BEGIN
    DELETE FROM producto WHERE id = p_id;
END ;

CREATE OR REPLACE PROCEDURE obtener_productos(cursor_ OUT SYS_REFCURSOR)
IS
BEGIN
  OPEN cursor_ FOR SELECT * FROM producto;
END ;
