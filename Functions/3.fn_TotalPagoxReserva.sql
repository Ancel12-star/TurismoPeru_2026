CREATE OR ALTER FUNCTION lacc.fn_PagoTotalxReserva
(
    @IdReserva int
)
RETURNS MONEY
AS
BEGIN
    Declare @Total money
    Select
        @Total = sum(monto)
    from lacc.pago
    where id_reserva = @IdReserva;

    RETURN isnull (@Total,0);
END;

--ejecutar 
select lacc.fn_PagoTotalxReserva (2) AS MontoPagado,
Getdate() as Fecha_Consulta;