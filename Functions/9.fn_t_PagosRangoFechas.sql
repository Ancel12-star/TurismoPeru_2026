CREATE OR ALTER FUNCTION lacc.fn_PagosRangoFechas
(
    @FechaInicio DATE,
    @FechaFin DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        P.id_pago,
        P.id_reserva,
        P.id_medio_pago,
        P.monto,
        P.fecha_pago,
        P.numero_operacion,
        P.comprobante,
        P.estado
    FROM lacc.pago AS P
    WHERE P.fecha_pago >= @FechaInicio
      AND P.fecha_pago < DATEADD(DAY, 1, @FechaFin)
);
GO

SELECT
    *,
    GETDATE() AS FechaConsulta,
    lacc.fn_NombreCompletoPersona(104) AS Estudiante
FROM lacc.fn_PagosRangoFechas
(
    '2026-01-01',
    '2026-12-31'
);