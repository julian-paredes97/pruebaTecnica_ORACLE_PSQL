--exportar datos de Oracle:
CREATE OR REPLACE PROCEDURE exportar_datos_csv AS
    v_file UTL_FILE.FILE_TYPE;
BEGIN
    --csv de videojuegos:
    v_file := UTL_FILE.FOPEN('DIRECTORIO', 'videojuegos.csv', 'W');
    FOR rec IN (SELECT * FROM VideoJuegos) LOOP
        UTL_FILE.PUT_LINE(v_file, rec.IdVideoJuego || ',' || rec.NombreVideoJuego || ',' || rec.Compania || ',' || rec.AnoLanzamiento || ',' || rec.Precio || ',' || rec.PuntuacionPromedio || ',' || rec.FechaActualizacion || ',' || rec.IdUsuario);
    END LOOP;
    UTL_FILE.FCLOSE(v_file);

    --csv de calificaciones:
    v_file := UTL_FILE.FOPEN('DIRECTORIO', 'calificaciones.csv', 'W');
    FOR rec IN (SELECT * FROM Calificacion) LOOP
        UTL_FILE.PUT_LINE(v_file, rec.IdCalificacion || ',' || rec.VideojuegoID || ',' || rec.Nickname || ',' || rec.Puntuacion || ',' || rec.FechaActualizacion || ',' || rec.IdUsuario);
    END LOOP;
    UTL_FILE.FCLOSE(v_file);
END;
