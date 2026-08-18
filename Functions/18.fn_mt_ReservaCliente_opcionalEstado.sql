
CREATE or ALTER FUNCTION lacc.fn_mt_ReservasPorClienteOpcionalEstado
(
    @IdCliente INT,
    @IdEstadoReserva INT -- Puede ser NULL para hacer la búsqueda opcional
)
RETURNS @Resultado TABLE
(
    IdReserva INT,
    CodigoReserva VARCHAR(20),
    FechaReserva DATETIME,
    FechaInicio DATE,
    FechaFin DATE,
    IdEstadoReserva INT,
    EstadoReserva VARCHAR(30),
    PrecioTotal DECIMAL(10,2)
)
AS
BEGIN
    -- Si NO se especifica un estado (es NULL), traemos todas las reservas del cliente
    IF @IdEstadoReserva IS NULL
    BEGIN
        INSERT INTO @Resultado
        SELECT 
            R.id_reserva,
            R.codigo_reserva,
            R.fecha_reserva,
            R.fecha_inicio,
            R.fecha_fin,
            ER.id_estado_reserva,
            ER.nombre,
            R.precio_total
        FROM lacc.reserva AS R
        INNER JOIN lacc.estado_reserva AS ER 
            ON ER.id_estado_reserva = R.id_estado_reserva
        WHERE R.id_cliente = @IdCliente;
    END
    -- Si SÍ se especifica un estado, aplicamos el filtro adicional
    ELSE
    BEGIN
        INSERT INTO @Resultado
        SELECT 
            R.id_reserva,
            R.codigo_reserva,
            R.fecha_reserva,
            R.fecha_inicio,
            R.fecha_fin,
            ER.id_estado_reserva,
            ER.nombre,
            R.precio_total
        FROM lacc.reserva AS R
        INNER JOIN lacc.estado_reserva AS ER 
            ON ER.id_estado_reserva = R.id_estado_reserva
        WHERE R.id_cliente = @IdCliente
          AND R.id_estado_reserva = @IdEstadoReserva;
    END;

    RETURN;
END;
GO

-- PRUEBA A: Consultar TODAS las reservas del cliente (Estado en NULL)
DECLARE @IdClientePrueba1 INT = 1;

SELECT 
    GETDATE() AS Fecha_Consulta,
    lacc.fn_NombreCompletoPersona(104) AS NombreCompletoPersona,
    *
FROM lacc.fn_mt_ReservasPorClienteOpcionalEstado(@IdClientePrueba1, NULL);
GO

-- PRUEBA B: Consultar reservas del cliente filtradas por un ESTADO específico (ej. Estado = 2)
DECLARE @IdClientePrueba2 INT = 1;
DECLARE @IdEstadoPrueba2 INT = 2;

SELECT 
    GETDATE() AS Fecha_Consulta,
    lacc.fn_NombreCompletoPersona(104) AS NombreCompletoPersona,
    *
FROM lacc.fn_mt_ReservasPorClienteOpcionalEstado(@IdClientePrueba2, @IdEstadoPrueba2);
GO