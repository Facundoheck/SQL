CREATE PROCEDURE PA_ALTA_CURSOS(
    @prof_id         INT,
    @titulo          VARCHAR(70),
    @nivel           VARCHAR(20),
    @descripcion     VARCHAR(400)
)
AS
	DECLARE @mensaje VARCHAR(MAX)


-- inicio validaciones para el alta NO LAS HAGO PARA NO PERDER TIEMPO
-- PONGO LA DE FK DE EJEMPLO
IF NOT EXISTS (SELECT 1 FROM PROFESORES AS p WHERE p.prof_id = @prof_id)
BEGIN
	PRINT 'No existe el ID del profesor. Verifique los datos.'
	RETURN -1
END

IF LEN(@titulo) > 70
BEGIN
	PRINT 'El t�tulo no puede superar los 70 caracteres. Verifique los datos.'
	RETURN -1	
END

--COMIENZO CON EL ALTA

BEGIN TRY
INSERT INTO CURSOS
(
	prof_id,
	titulo,
	nivel,
	descripcion
)
VALUES
(
	@prof_id,
	@titulo,
	@nivel,
	@descripcion
)
	
END TRY
BEGIN CATCH
	SELECT @mensaje = 'Ocurri� un error al intentar registar el curso: ' + ERROR_MESSAGE() 
	PRINT @mensaje
	RETURN -1
END CATCH

RETURN 0
GO