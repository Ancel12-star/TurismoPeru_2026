CREATE OR ALTER FUNCTION lacc.fn_Cantidad_Reservas_x_Cliente
(
    @IdCliente int
)
RETURNS int
AS
BEGIN
    DECLARE @CantidadReservas int;

    SELECT
        @CantidadReservas = COUNT(*)
    FROM lacc.reserva
    WHERE id_cliente = @IdCliente;

    RETURN @CantidadReservas;
END;
GO
--Ejecucion de fn_Cantidad_Reservas_x_Cliente
SELECT
    108 as IdCliente,
    lacc.fn_Cantidad_Reservas_x_Cliente(2) as Cantidad_De_Reservas,
    GETDATE() as FechaConsulta;