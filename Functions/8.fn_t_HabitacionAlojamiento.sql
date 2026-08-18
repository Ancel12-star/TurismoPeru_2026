CREATE OR ALTER FUNCTION lacc.fn_HabitacionesAlojamiento
(
@IdAlojamiento int
)
returns table 
return
(
Select 
		H.id_alojamiento,
		H.numero_habitacion,
		TH.nombrehabitacion,
		H.precio_noche,
		H.estado,
		H.descripcion

from lacc.habitacion H inner join
lacc.tipo_habitacion TH on
H.id_tipo_habitacion = TH.id_tipo_habitacion
where id_alojamiento = 1 --@Id Alojamiento
);
go

SELECT *,
    GETDATE() as Fecha_Consulta,
    lacc.fn_NombreCompletoPersona (104) as Estudiante
FROM lacc.fn_HabitacionesAlojamiento (2);