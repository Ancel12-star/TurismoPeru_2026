CREATE PROCEDURE lacc.sp_FiltrarAlojamientosPorEstrellas
    @estrellas TINYINT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            a.id_alojamiento,
            a.Nombre AS [Alojamiento],
            ta.Nombre_Tipo AS [Tipo],
            a.Categoria_Estrellas AS [Estrellas],
            a.Telefono,
            a.Email
        FROM lacc.alojamiento a
        INNER JOIN lacc.tipo_alojamiento ta ON a.id_tipoalojamiento = ta.id_tipoalojamiento
        WHERE a.Categoria_Estrellas = @estrellas
        ORDER BY a.Nombre ASC;
    END TRY
    BEGIN CATCH
        PRINT 'Error al filtrar alojamientos: ' + ERROR_MESSAGE();
    END CATCH
END;
GO