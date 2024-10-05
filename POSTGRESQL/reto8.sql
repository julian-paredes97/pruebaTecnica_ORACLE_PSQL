
CREATE TABLE Usuarios(
    IdUsuario SERIAL PRIMARY KEY,
    NombreUsuario VARCHAR(50)
);

CREATE TABLE Videojuegos(
    IdVideojuego SERIAL PRIMARY KEY,
    NombreVideoJuego VARCHAR(100) NOT NULL,
    Compania VARCHAR(100),
    AnoLanzamiento INT,
    Precio NUMERIC(5, 2),
    Puntuacion NUMERIC(3, 2) DEFAULT 0,
    FechaActualizacion DATE,
    IdUsuario INT,
    CONSTRAINT FK_IdUsuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

CREATE TABLE Calificacion(
    IdCalificacion SERIAL PRIMARY KEY,
    Nickname VARCHAR(30),
    IdVideojuego INT,
    puntuacion NUMERIC(3, 2),
    FechaActualizacion DATE,
    IdUsuario INT,
    CONSTRAINT FK_Videojuego FOREIGN KEY (IdVideoJuego) REFERENCES Videojuegos (IdVideojuego),
    CONSTRAINT FK_IdUsuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

CREATE INDEX idx_nombre_videojuego ON Videojuegos(NombreVideoJuego);

CREATE INDEX idx_nickname_calificacion ON Calificacion(Nickname);