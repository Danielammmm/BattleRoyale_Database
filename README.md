# BattleRoyale_Database
# **Battle Royale Database**

## **Descripción**
Este proyecto implementa un sistema de base de datos relacional para gestionar y analizar partidas de un juego tipo Battle Royale. La base de datos permite registrar usuarios, partidas, cosméticos, plataformas, y realizar un seguimiento detallado de eventos como asesinatos, uso de cosméticos, y conexión/desconexión de jugadores.

## **Estructura del modelo de datos**
La base de datos está diseñada siguiendo un modelo relacional con las siguientes entidades principales:

- **Continente:** Información sobre los continentes.
- **País:** Asociación de países con continentes.
- **Usuario:** Registro de jugadores con datos personales y geográficos.
- **Cosmético:** Elementos estéticos del juego categorizados por tipo y precio.
- **Partida:** Detalles de cada partida, incluyendo ganadores y tipo de partida.
- **Conexión:** Registros de inicio y fin de sesión de usuarios.
- **DetallePartida:** Información sobre eventos específicos como asesinatos.
- **UsuarioCosmetico:** Relación entre usuarios y los cosméticos adquiridos.

## **Diagrama de Entidad-Relación**
El diseño de la base de datos sigue el modelo de entidad-relación, con claves primarias y relaciones bien definidas para garantizar integridad referencial.

### **Entidades principales y atributos**
- **Usuario:**
  - `idUsuario` (PK), `nickname`, `email`, `fechaNacimiento`, entre otros.
- **Partida:**
  - `idPartida` (PK), `fechaInicio`, `fechaFin`, `estado`.
- **Cosmético:**
  - `idCosmetico` (PK), `nombre`, `precio`.

## **Scripts SQL**
El proyecto incluye los siguientes scripts:
1. **Creación de la base de datos (`BattleRoyaleDatabase.sql`):**
   - Estructura de tablas.
   - Relaciones entre entidades.
2. **Consultas específicas (`SQLQuery2.sql`, `SQLQuery3.sql`, `SQLQuery4.sql`):**
   - Consultas para estadísticas de partida, cosméticos más usados, y actividad de usuarios.

## **Cómo usar este proyecto**
1. **Configura tu entorno:**
   - Un servidor SQL compatible (MySQL, SQL Server, etc.).
2. **Carga la base de datos:**
   - Ejecuta el script `BattleRoyaleDatabase.sql` para crear las tablas.
3. **Realiza consultas:**
   - Utiliza los scripts de consulta proporcionados para analizar los datos.

## **Ejemplo de consultas**
- **Usuarios más activos:**
   ```sql
   SELECT nickname, COUNT(idConexion) AS logins
   FROM Conexion
   JOIN Usuario ON Conexion.idUsuario = Usuario.idUsuario
   GROUP BY nickname
   ORDER BY logins DESC;
