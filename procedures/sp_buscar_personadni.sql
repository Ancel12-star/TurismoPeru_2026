CREATE OR ALTER PROCEDURE lacc.sp_buscar_personadni
    @dni VARCHAR(8)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM lacc.persona WHERE numero_documento = @dni)
    BEGIN
        SELECT 
            id_persona, 
            nombres, 
            apaterno, 
            amaterno, 
            numero_documento AS dni, 
            telefono 
        FROM lacc.persona 
        WHERE numero_documento = @dni;
    END
    ELSE
    BEGIN
        PRINT 'No se encontró ninguna persona con el DNI ingresado.';
    END
END
GO