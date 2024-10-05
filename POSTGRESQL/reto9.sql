--cargar datos en pgsql:
COPY Videojuegos (id_videojuego, nombre, compañia, año_lanzamiento, precio, puntuacion)
FROM '/ruta/videojuegos.csv'
DELIMITER ','
CSV HEADER;

COPY Calificaciones (id_calificacion, nickname, id_videojuego, puntuacion)
FROM '/ruta/calificaciones.csv'
DELIMITER ','
CSV HEADER;
