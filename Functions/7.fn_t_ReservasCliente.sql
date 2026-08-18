--Reserva de un cliente
CREATE OR ALTER FUNCTION lacc.fn_ReservaCliente
(
	@IdCliente int
)
RETURNS TABLE
RETURN
(
	SELECT
		id_reserva,
		fecha_reserva,
		ER.nombre as [Estado Reserva]
	FROM lacc.reserva R inner join
	lacc.estado_reserva ER on
	ER.id_estado_reserva = R.id_estado_reserva
	WHERE R.id_Cliente=@IdCliente
);
GO
--Ejecutar
SELECT * , getdate() as Fecha_Consulta, lacc.fn_NombreCompletoPersona(104)as Estudiane 
FROM lacc.fn_ReservaCliente(2);