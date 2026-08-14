Create or Alter FUNCTION lacc.fn_CalcularIGVPago
(
	@monto money
)
returns money
as
begin 
	return @monto*0.18;
end;
go
--ejecutar
select lacc.fn_CalcularIGVPago (459) as igv,
GETDATE() as Fecha_Consulta

select monto, lacc.fn_CalcularIGVPago(monto)as IGV,
GETDATE() AS Fecha_Consulta
from lacc.pago
where monto >=0;