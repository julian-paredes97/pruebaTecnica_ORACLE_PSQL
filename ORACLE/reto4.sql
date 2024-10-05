--crear tipo de objeto:
CREATE OR REPLACE TYPE tipo_calificacion AS OBJECT (
    IdVideoJuego INT,
    nickname VARCHAR2(30),
    puntuacion NUMBER(3, 2),
    FechaActualizacion DATE,
    IdUsuario INT
);

/

--crear tipo de tabla:
CREATE OR REPLACE TYPE tipo_calificacion_pipelined AS TABLE OF tipo_calificacion;

/

--crear funcion pipeline:
CREATE OR REPLACE FUNCTION generar_calificaciones(
    cantidad IN INT DEFAULT 0, --entrada cantidad de calificaciones que se generan
    IdVideoJuego IN INT DEFAULT NULL --entrada opcional id juego
)
RETURN tipo_calificacion_pipelined PIPELINED --retorna una tabla canalizada
IS
    v_IdVideoJuego INT;
    v_nickname VARCHAR2(30);
    v_puntuacion NUMBER(3, 2);
    v_fechaActualizacion DATE;
    v_IdUsuario INT;
BEGIN
    --si la cantidad es 0 o menor, no hace nada:
    IF cantidad <= 0 THEN
        RETURN;
    END IF;

    --sino, se generan calificaciones random:
    FOR i IN 1..cantidad LOOP
        --generar nickname aleatorio con letras y numeros:
        v_nickname := dbms_random.string('x', 30);

        --generar puntuación aleatoria de 0-5 con dos decimales:
        v_puntuacion := ROUND(dbms_random.value(0, 5), 2);

        v_fechaActualizacion := SYSDATE;

        v_IdUsuario := 1; --se asume que lo hace admin

        --si no se pasa un id de videojuego se selecciona uno aleatorio:
        IF IdVideoJuego IS NULL THEN
            SELECT IdVideoJuego INTO v_IdVideoJuego 
            FROM (SELECT IdVideoJuego FROM Videojuegos ORDER BY DBMS_RANDOM.VALUE) 
            WHERE ROWNUM = 1;
        ELSE
            v_IdVideoJuego := IdVideoJuego;
        END IF;

        --se canaliza la fila (nickname, IdVideoJuego, puntuacion) como resultado:
        PIPE ROW (tipo_calificacion(v_IdVideoJuego, v_nickname, v_puntuacion, v_fechaActualizacion, v_IdUsuario));
    END LOOP;
    
    RETURN;
END;

/
