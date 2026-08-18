CREATE OR ALTER FUNCTION lacc.fn_MT_ReporteClientesFrecuentes
()
RETURNS @Resultado TABLE
(
    IdCliente INT,
    Cliente VARCHAR(200),
    Email VARCHAR(100),
    CantidadReservas INT,
    TotalPagado DECIMAL(18,2),
    Clasificacion VARCHAR(30)
)
AS
BEGIN
    INSERT INTO @Resultado
    (
        IdCliente,
        Cliente,
        Email,
        CantidadReservas,
        TotalPagado,
        Clasificacion
    )
    SELECT
        R.id_cliente,
        lacc.fn_NombreCompletoPersona(R.id_cliente),
        P.email,
        COUNT(*) AS CantidadReservas,
        0 AS TotalPagado,
        '' AS Clasificacion
    FROM lacc.reserva AS R

    INNER JOIN lacc.cliente AS C
        ON C.id_persona = R.id_cliente

    INNER JOIN lacc.persona AS P
        ON P.id_persona = C.id_persona

    GROUP BY
        R.id_cliente,
        P.email;

    UPDATE RT
    SET RT.TotalPagado = ISNULL
    (
        (
            SELECT SUM(PG.monto)
            FROM lacc.reserva AS R2

            INNER JOIN lacc.pago AS PG
                ON PG.id_reserva = R2.id_reserva

            WHERE R2.id_cliente = RT.IdCliente
        ),
        0
    )
    FROM @Resultado AS RT;

    UPDATE @Resultado
    SET Clasificacion =
        CASE
            WHEN CantidadReservas > 3
                THEN 'Cliente VIP'
            WHEN CantidadReservas > 2
                THEN 'Cliente Frecuente'
            ELSE 'Cliente Nuevo'
        END;

    RETURN;
END;
GO

---
SELECT
    *,
    GETDATE() AS FechaConsulta,
     lacc.fn_NombreCompletoPersona(104) AS Estudiante
FROM lacc.fn_mt_ReporteClientesFrecuentes()
ORDER BY CantidadReservas DESC, TotalPagado DESC;


---
SELECT
    *,
    GETDATE() AS FechaConsulta,
    lacc.fn_NombreCompletoPersona(104) AS Estudiante
FROM lacc.fn_mt_ReporteClientesFrecuentes()
WHERE Clasificacion IN
(
    'Cliente Frecuente',
    'Cliente VIP'
)
ORDER BY CantidadReservas DESC, TotalPagado DESC;