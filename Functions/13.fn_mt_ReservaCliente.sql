-- Reserva cliente
CREATE OR ALTER FUNCTION lacc.fn_MT_ReservasCliente(
    @IdCliente int
)
RETURNS @Resultado TABLE (
    IdReserva int,
    FechaReserva date,
    EstadoReserva varchar(100),
    TotalPagado money
)
AS
BEGIN
    INSERT INTO @Resultado (
        IdReserva,
        FechaReserva,
        EstadoReserva, 
        TotalPagado 
    )
    SELECT 
        R.id_reserva,
        R.fecha_reserva,
        ER.nombre, 
        ISNULL(SUM(P.monto), 0) 
    FROM lacc.reserva R 
    INNER JOIN lacc.estado_reserva ER 
        ON ER.id_estado_reserva = R.id_estado_reserva
    LEFT JOIN lacc.pago P 
        ON R.id_reserva = P.id_reserva
    WHERE R.id_cliente = @IdCliente
    GROUP BY 
        R.id_reserva,
        R.fecha_reserva,
        ER.nombre;

    RETURN;
END;
GO
--ejecucion de fn_MT_ReservasCliente
select
*, 
GETDATE() as Fecha_Consulta,
lacc.fn_NombreCompletoPersona(104) as Estudiante
from lacc.fn_MT_ReservasCliente(10);