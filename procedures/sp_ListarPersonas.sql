CREATE   PROCEDURE lacc.sp_ListarPersonas
AS
BEGIN
    Select id_persona, tipo_persona,nombres, apaterno,amaterno, estado
    From lacc.persona
END
GO
