CREATE OR ALTER FUNCTION lacc.fn_mt_ReservasPagoClienteEstado
(
    @IdCliente INT,
    @IdEstadoReserva INT
)
RETURNS @Resultado TABLE
(
    IdReserva INT,
    CodigoReserva VARCHAR(20),
    IdCliente INT,
    Cliente VARCHAR(200),
    FechaReserva DATETIME,
    FechaInicio DATE,
    FechaFin DATE,
    NumeroPersonas INT,
    PrecioTotal DECIMAL(10,2),
    Adelanto DECIMAL(10,2),
    SaldoPendiente DECIMAL(10,2),
    IdEstadoReserva INT,
    EstadoReserva VARCHAR(30),
    TotalPagado DECIMAL(18,2)
)
AS
BEGIN
    IF @IdEstadoReserva IS NULL
    BEGIN
        INSERT INTO @Resultado
        SELECT
            R.id_reserva,
            R.codigo_reserva,
            R.id_cliente,
            lacc.fn_NombreCompletoPersona(R.id_cliente),
            R.fecha_reserva,
            R.fecha_inicio,
            R.fecha_fin,
            R.numero_personas,
            R.precio_total,
            R.adelanto,
            R.saldo_pendiente,
            ER.id_estado_reserva,
            ER.nombre,
            CAST(
                lacc.fn_PagoTotalXReserva(R.id_reserva)
                AS DECIMAL(18,2)
            )
        FROM lacc.reserva AS R

        INNER JOIN lacc.estado_reserva AS ER
            ON ER.id_estado_reserva = R.id_estado_reserva

        WHERE R.id_cliente = @IdCliente;
    END
    ELSE
    BEGIN
        -- Si se proporciona un estado, aplica el filtro.
        INSERT INTO @Resultado
        SELECT
            R.id_reserva,
            R.codigo_reserva,
            R.id_cliente,
            lacc.fn_NombreCompletoPersona(R.id_cliente),
            R.fecha_reserva,
            R.fecha_inicio,
            R.fecha_fin,
            R.numero_personas,
            R.precio_total,
            R.adelanto,
            R.saldo_pendiente,
            ER.id_estado_reserva,
            ER.nombre,
            CAST(
                lacc.fn_PagoTotalXReserva(R.id_reserva)
                AS DECIMAL(18,2)
            )
        FROM lacc.reserva AS R

        INNER JOIN lacc.estado_reserva AS ER
            ON ER.id_estado_reserva = R.id_estado_reserva

        WHERE R.id_cliente = @IdCliente
          AND R.id_estado_reserva = @IdEstadoReserva;
    END;

    RETURN;
END;
GO

--Ejecucion fn_mt_ReservasPagoClienteEstado
SELECT
    *,
    GETDATE() AS FechaConsulta,
    lacc.fn_NombreCompletoPersona(104) AS Estudiante
FROM lacc.fn_mt_ReservasPagoClienteEstado(2, 12)
ORDER BY FechaReserva;