CREATE OR ALTER FUNCTION lacc.fn_mt_ClasificarReservasCliente
(
    @IdCliente INT
)
RETURNS @Resultado TABLE
(
    IdCliente INT,
    Cliente VARCHAR(200),
    CantidadReservas INT,
    Clasificacion VARCHAR(30)
)
AS
BEGIN
    DECLARE @CantidadReservas INT;
    DECLARE @Clasificacion VARCHAR(30);

    -- Primera sentencia: contar las reservas.
    SELECT
        @CantidadReservas = COUNT(*)
    FROM lacc.reserva
    WHERE id_cliente = @IdCliente;

    -- Segunda parte: determinar la clasificación.
    IF @CantidadReservas > 15
    BEGIN
        SET @Clasificacion = 'Cliente VIP';
    END
    ELSE IF @CantidadReservas > 5
    BEGIN
        SET @Clasificacion = 'Cliente Frecuente';
    END
    ELSE
    BEGIN
        SET @Clasificacion = 'Cliente Nuevo';
    END;

    -- Tercera sentencia: insertar el resultado.
    INSERT INTO @Resultado
    (
        IdCliente,
        Cliente,
        CantidadReservas,
        Clasificacion
    )
    VALUES
    (
        @IdCliente,
        lacc.fn_NombreCompletoPersona(@IdCliente),
        @CantidadReservas,
        @Clasificacion
    );

    RETURN;
END;
GO

--ejecutar fn_mt_ClasificarReservasClient
SELECT
    *,
    GETDATE() AS FechaConsulta,
    lacc.fn_NombreCompletoPersona(104) AS Estudiante
FROM lacc.fn_mt_ClasificarReservasCliente(2);