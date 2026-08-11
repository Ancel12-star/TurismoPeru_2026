from database.conexion import conectar

def listarpersonas():
    conexion = conectar()
    try:
        cursor = conexion.cursor()
        cursor.execute("EXEC lacc.sp_ListarPersonas")
        personas = cursor.fetchall()

        return personas
    finally:
        cursor.close()
        conexion.close()

def listarclientes():
    conexion = conectar()
    try:
        cursor = conexion.cursor()
        cursor.execute("EXEC lacc.sp_ListarClientes")
        clientes = cursor.fetchall()

        return clientes
    finally:
        cursor.close()
        conexion.close()