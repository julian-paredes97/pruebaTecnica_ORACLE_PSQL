--secuencia tabla Usuarios:
CREATE SEQUENCE sec_usuarios
START WITH 1
INCREMENT BY 1;

--trigger tabla Usuarios:
CREATE OR REPLACE TRIGGER trig_usuarios_id
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
  IF :NEW.IdUsuario IS NULL THEN
    SELECT sec_usuarios.NEXTVAL
    INTO :NEW.IdUsuario
    FROM dual;
  END IF;
END;

/

--secuencia tabla Videojuegos:
CREATE SEQUENCE sec_videojuegos
START WITH 1
INCREMENT BY 1;

--trigger tabla Videojuegos:
CREATE OR REPLACE TRIGGER trig_videojuegos_id
BEFORE INSERT ON Videojuegos
FOR EACH ROW
BEGIN
  IF :NEW.IdVideojuego IS NULL THEN
    SELECT sec_videojuegos.NEXTVAL
    INTO :NEW.IdVideojuego
    FROM dual;
  END IF;
END;

/

--secuencia tabla Calificacion:
CREATE SEQUENCE sec_calificacion
START WITH 1
INCREMENT BY 1;

--trigger tabla Calificacion:
CREATE OR REPLACE TRIGGER trig_calificacion_id
BEFORE INSERT ON Calificacion
FOR EACH ROW
BEGIN
  IF :NEW.IdCalificacion IS NULL THEN
    SELECT sec_calificacion.NEXTVAL
    INTO :NEW.IdCalificacion
    FROM dual;
  END IF;
END;

/

--secuencia tabla Auditoria:
CREATE SEQUENCE sec_auditoria
START WITH 1
INCREMENT BY 1;

--trigger tabla Auditoria:
CREATE OR REPLACE TRIGGER trig_auditoria_id
BEFORE INSERT ON Auditoria
FOR EACH ROW
BEGIN
  IF :NEW.IdAuditoria IS NULL THEN
    SELECT sec_auditoria.NEXTVAL
    INTO :NEW.IdAuditoria
    FROM dual;
  END IF;
END;

/
