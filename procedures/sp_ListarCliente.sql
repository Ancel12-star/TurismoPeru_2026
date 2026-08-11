
CREATE   PROCEDURE lacc.sp_ListarClientes
AS
BEGIN
    Select p.id_persona, p.tipo_persona,nombres, apaterno,amaterno, estado
    From lacc.persona p
    inner join lacc.cliente c
    on p.id_persona = c.id_persona
END
GO