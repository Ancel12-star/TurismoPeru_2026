create or alter function lacc.fn_NombreCompletoPersona
(
@IdPersona int 
)
RETURNS Varchar (200)
as
begin
DECLARE  @nombrecompleto varchar (200);
Select 
@nombrecompleto=
nombres+ ''
+ apaterno + '' 
+ amaterno 
from lacc.persona
where id_persona =@IdPersona;


return @nombrecompleto
end
go

--Ejecutar Funcion
select lacc.fn_NombreCompletoPersona (104)
as Persona, getdate() as FechaConsulta;