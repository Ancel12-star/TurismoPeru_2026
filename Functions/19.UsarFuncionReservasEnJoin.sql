
SELECT
    C.id_persona AS IdCliente,
    lacc.fn_NombreCompletoPersona(P.id_persona) AS Cliente,
    P.numero_documento,
    P.email,

    F.IdReserva,
    F.CodigoReserva,
    F.FechaInicio,
    F.FechaFin,
    F.EstadoReserva,
    F.TotalPagado,

    GETDATE() AS FechaConsulta,
    lacc.fn_NombreCompletoPersona(104) AS Estudiante

FROM lacc.cliente AS C
INNER JOIN lacc.persona AS P
    ON C.id_persona = P.id_persona

CROSS APPLY lacc.fn_mt_ReservasPagoClienteEstado
(
    C.id_persona,
    NULL
) AS F

ORDER BY C.id_persona, F.FechaReserva;