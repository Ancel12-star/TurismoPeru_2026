CREATE OR ALTER FUNCTION lacc.fn_Clasificacion_Cliente
(
    @IdCliente int
)
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @CantidadReservas INT;
    DECLARE @Clasificacion VARCHAR(30);

    SET @CantidadReservas =
        lacc.fn_Cantidad_Reservas_x_Cliente(@IdCliente);

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

    RETURN @Clasificacion;
END;
GO
--Ejecucion fn_Clasificacion_Cliente
SELECT
    104 as IdCliente,
    lacc.fn_Cantidad_Reservas_x_Cliente(2) as Cantidad_De_Reservas,
    lacc.fn_Clasificacion_Cliente(2) as Clasificacion,
    GETDATE() as Fecha_de_Consulta;
