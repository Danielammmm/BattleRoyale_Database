SELECT U.idUsuario, U.nickname, P.nombre AS pais, C.nombre AS continente,
    COUNT(DP.idDetallePartida) AS TotalPartidas,
    COUNT(CASE WHEN DP.idAsesino IS NOT NULL AND DP.idMuerto IS NOT NULL AND DP.idGanador = U.idUsuario THEN 1 END) AS TotalVictorias,
    COUNT(CASE WHEN DP.idAsesino IS NOT NULL AND DP.idMuerto IS NOT NULL AND DP.idGanador != U.idUsuario THEN 1 END) AS TotalDerrotas,
    CONVERT(DECIMAL(18,2), COUNT(CASE WHEN DP.idAsesino IS NOT NULL AND DP.idMuerto IS NOT NULL AND DP.idGanador = U.idUsuario THEN 1 END)) / NULLIF(CONVERT(DECIMAL(18,2), COUNT(DP.idDetallePartida)),0) AS WinRatio
FROM Usuario_ U
INNER JOIN Pais_ P ON P.idPais = U.idPais
INNER JOIN Continente_ C ON C.idContinente = P.idContinente
INNER JOIN Partida_ PA ON PA.idGanador = U.idUsuario
INNER JOIN DetallePartida_ DP ON DP.idPartida = PA.idPartida AND DP.idMuerto = U.idUsuario
WHERE U.estado = 1
GROUP BY U.idUsuario, U.nickname, P.nombre, C.nombre
HAVING COUNT(DP.idDetallePartida) >= 10
ORDER BY WinRatio DESC
