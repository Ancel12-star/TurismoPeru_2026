CREATE OR ALTER FUNCTION lacc.fn_ClientesReservasActivas
()
RETURNS TABLE
AS
RETURN
(
    SELECT
        R.id_cliente AS IdCliente,
        lacc.fn_NombreCompletoPersona(R.id_cliente) AS Cliente,
        P.numero_documento AS NumeroDocumento,
        P.telefono AS Telefono,
        P.email AS Email,
        R.id_reserva AS IdReserva,
        R.codigo_reserva AS CodigoReserva,
        R.fecha_reserva AS FechaReserva,
        R.fecha_inicio AS FechaInicio,
        R.fecha_fin AS FechaFin,
        R.numero_personas AS NumeroPersonas,
        R.precio_total AS PrecioTotal,
        R.saldo_pendiente AS SaldoPendiente,
        ER.nombre AS EstadoReserva

    FROM lacc.reserva AS R

    INNER JOIN lacc.cliente AS C
        ON C.id_persona = R.id_cliente

    INNER JOIN lacc.persona AS P
        ON P.id_persona = C.id_persona

    INNER JOIN lacc.estado_reserva AS ER
        ON ER.id_estado_reserva = R.id_estado_reserva

    WHERE ER.nombre NOT IN
    (
        'Completada', 'Cancelada', 'Anulada', 'Reembolsada', 'Vencida', 'No Show', 'Finalizada'
    )
);
GO
--ejecutar fn_ClientesReservasActivas ()
SELECT
    *,
    GETDATE() AS FechaConsulta,
    lacc.fn_NombreCompletoPersona(104) AS Estudiante
FROM lacc.fn_ClientesReservasActivas()
ORDER BY IdCliente, FechaInicio;