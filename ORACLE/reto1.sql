CREATE TABLE Usuarios(
    IdUsuario INT PRIMARY KEY,
    NombreUsuario VARCHAR2(50) NOT NULL
);

CREATE TABLE Videojuegos(
    IdVideojuego INT PRIMARY KEY,
    NombreVideoJuego VARCHAR2(100) NOT NULL,
    Compania VARCHAR2(100) NOT NULL,
    AnoLanzamiento NUMBER(4) NOT NULL, --Anio con 4 digitos
    Precio NUMBER(10, 2), --Precio con 2 decimales
    PuntuacionPromedio NUMBER(3, 2) DEFAULT 0 CHECK (PuntuacionPromedio BETWEEN 0 AND 5), --Puntuacion entre 0-5
    FechaActualizacion DATE,
    IdUsuario INT NOT NULL,
    CONSTRAINT FK_IdUsuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

CREATE TABLE Calificacion(
    IdCalificacion INT PRIMARY KEY,
    VideojuegoID INT NOT NULL,
    Nickname VARCHAR2(50) NOT NULL,
    Puntuacion NUMBER(3, 2) CHECK (Puntuacion BETWEEN 0 AND 5), --Puntuacion entre 0-5, con 2 decimas
    FechaActualizacion DATE,
    IdUsuario INT NOT NULL,
    CONSTRAINT FK_Videojuego FOREIGN KEY (VideojuegoID) REFERENCES Videojuegos (IdVideojuego),
    CONSTRAINT FK_IdUsuario2 FOREIGN KEY (IdUsuario) REFERENCES Usuarios (IdUsuario)
);

CREATE TABLE Auditoria(
    IdAuditoria INT PRIMARY KEY,
    NombreTabla VARCHAR2(100) NOT NULL, --Nombre de la tabla que se cambio
    NombreCampo VARCHAR2(100), --Nombre del campo que se cambio
    Accion VARCHAR2(10) CHECK (Accion IN ('INSERT', 'UPDATE', 'DELETE')), --accion realizada
    ValorAnterior VARCHAR2(1000), --puede ser nulo si se hace un INSERT
    ValorNuevo VARCHAR2(1000), --puede ser nulo si se hace un DELETE
    IdUsuario INT NOT NULL,
    CONSTRAINT FK_IdUsuario3 FOREIGN KEY (IdUsuario) REFERENCES Usuarios (IdUsuario)

);

CREATE INDEX idx_nombre_videojuego ON Videojuegos(NombreVideoJuego);

CREATE INDEX idx_nickname_calificacion ON Calificacion(Nickname);