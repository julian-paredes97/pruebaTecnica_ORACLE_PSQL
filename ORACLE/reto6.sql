--trigger para monitorear cambios en tabla auditoria:
CREATE OR REPLACE TRIGGER trig_auditoria_videojuegos
AFTER INSERT OR UPDATE OR DELETE ON VideoJuegos
FOR EACH ROW
BEGIN
    --caso 1 INSERT:
    IF INSERTING THEN
        INSERT INTO Auditoria (NombreTabla, NombreCampo, Accion, ValorAnterior, ValorNuevo, IdUsuario)
        VALUES('VideoJuegos', '', 'INSERT', NULL, NULL, 1);
    
    --caso 2 UPDATE:
    ELSIF UPDATING THEN
        --se verifica si el campo 'NombreVideoJuego' fue modificado:
        IF :OLD.NombreVideoJuego != :NEW.NombreVideoJuego THEN
            INSERT INTO Auditoria (NombreTabla, NombreCampo, Accion, ValorAnterior, ValorNuevo, IdUsuario)
            VALUES ('VideoJuegos', 'NombreVideoJuego', 'UPDATE', :OLD.NombreVideoJuego, :NEW.NombreVideoJuego, 1);
        END IF;

        --se verifica si el campo 'Compania' fue modificado:
        IF :OLD.Compania != :NEW.Compania THEN
            INSERT INTO Auditoria (NombreTabla, NombreCampo, Accion, ValorAnterior, ValorNuevo, IdUsuario)
            VALUES ('VideoJuegos', 'Compania', 'UPDATE', :OLD.Compania, :NEW.Compania, 1);
        END IF;

        --se verifica si el campo 'AnoLanzamiento' fue modificado:
        IF :OLD.AnoLanzamiento != :NEW.AnoLanzamiento THEN
            INSERT INTO Auditoria (NombreTabla, NombreCampo, Accion, ValorAnterior, ValorNuevo, IdUsuario)
            VALUES ('VideoJuegos', 'AnoLanzamiento', 'UPDATE', :OLD.AnoLanzamiento, :NEW.AnoLanzamiento, 1);
        END IF;

        --se verifica si el campo 'Precio' fue modificado:
        IF :OLD.Precio != :NEW.Precio THEN
            INSERT INTO Auditoria (NombreTabla, NombreCampo, Accion, ValorAnterior, ValorNuevo, IdUsuario)
            VALUES ('VideoJuegos', 'Precio', 'UPDATE', :OLD.Precio, :NEW.Precio, 1);
        END IF;

        --se verifica si el campo 'PuntuacionPromedio' fue modificado:
        IF :OLD.PuntuacionPromedio != :NEW.PuntuacionPromedio THEN
            INSERT INTO Auditoria (NombreTabla, NombreCampo, Accion, ValorAnterior, ValorNuevo, IdUsuario)
            VALUES ('VideoJuegos', 'PuntuacionPromedio', 'UPDATE', :OLD.PuntuacionPromedio, :NEW.PuntuacionPromedio, 1);
        END IF;

    --caso 3 DELETE:
    ELSIF DELETING THEN
        INSERT INTO Auditoria (NombreTabla, NombreCampo, Accion, ValorAnterior, ValorNuevo, IdUsuario)
        VALUES ('VideoJuegos', '', 'DELETE', NULL, NULL, 1);
    END IF;
END;
