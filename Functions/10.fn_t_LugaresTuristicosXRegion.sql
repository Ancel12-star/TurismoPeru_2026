CREATE OR ALTER FUNCTION lacc.fn_LugaresTuristicosRegion
(
    @IdRegion INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        Lt.id_lugarturistico AS Id_Lugar_Turistico,
        Lt.nombre AS Lugar_Turistico,
        CAST(LT.descripcion AS VARCHAR(MAX)) AS Descripcion,
        Lt.precio_entrada AS Precio_Entrada,
        Lt.horario_apertura AS Horario_Apertura,
        Lt.horario_cierre AS Horario_Cierre,
        Lt.calificacion AS Calificacion,
        Lt.estado AS Estado_Lugar,

        DLT.tipo_direccion AS Tipo_Direccion,
        DLT.es_principal AS Es_Principal,

        D.calle AS Calle,
        D.numero AS Numero,
        D.codigo_postal AS Codigo_Postal,
        D.latitud AS Latitud,
        D.longitud AS Longitud,
        C.nombreciudad AS Ciudad,
        S.nombresubregion AS Subregion,
        R.id_region AS Id_Region,
        R.nombreregion AS Region

    FROM lacc.lugar_turistico AS Lt

    INNER JOIN lacc.direccion_lugarturistico AS DLT
        ON DLT.id_lugarturistico = LT.id_lugarturistico

    INNER JOIN lacc.direccion AS D
        ON D.id_direccion = DLT.id_direccion

    INNER JOIN lacc.ciudad AS C
        ON C.id_ciudad = D.id_ciudad

    INNER JOIN lacc.subregion AS S
        ON S.id_subregion = C.id_subregion

    INNER JOIN lacc.region AS R
        ON R.id_region = S.id_region

    WHERE R.id_region = @IdRegion
);
GO
--ejecucion del fn_LugaresTuristicosRegion
SELECT
    *,
    GETDATE() AS FechaConsulta,
    lacc.fn_NombreCompletoPersona(104) AS Estudiante
FROM lacc.fn_LugaresTuristicosRegion(6);



