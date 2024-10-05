--se declara el tipo de coleccion basado en el objeto tipo_calificacion:
CREATE OR REPLACE TYPE Calificacion_Table AS TABLE OF tipo_calificacion;
/

--se crea procedimiento
CREATE OR REPLACE PROCEDURE InsercionMasivaCalificaciones(
    p_cantidad INT,          --cantidad de calificaciones que se generan
    p_videojuegoID INT,      --id opcional del juego
    p_errorCode OUT NUMBER,
    p_errorMsg OUT VARCHAR2
)
IS
    --se declara variable del tipo de tabla definida anteriormente
    v_calificaciones Calificacion_Table;

BEGIN
    --se inicializan los valores que se van a retornar
    p_errorCode := 0;  
    p_errorMsg := NULL;  

    --se llama a la función canalizada y se usa BULK COLLECT para traer los resultados
    SELECT * BULK COLLECT INTO v_calificaciones
    FROM TABLE(generar_calificaciones(p_cantidad, p_videojuegoID));

    --se insertan los valores en tabla de calificacion
    FORALL i IN 1..v_calificaciones.COUNT
        INSERT INTO Calificacion (VideojuegoID, Nickname, Puntuacion, FechaActualizacion, IdUsuario)
        VALUES (v_calificaciones(i).IdVideoJuego, 
                v_calificaciones(i).Nickname,
                v_calificaciones(i).Puntuacion, 
                SYSDATE, 
                1);

EXCEPTION
    WHEN OTHERS THEN
        --si tira error se capturan el código y mensaje de error
        p_errorCode := SQLCODE;
        p_errorMsg := SQLERRM;
END InsercionMasivaCalificaciones;
/
