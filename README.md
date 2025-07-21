# Proyecto de Pruebas Automatizadas para API Serverest.dev - Endpoints /usuarios*
Este proyecto contiene un conjunto de tests automatizados usando el framework karate dsl
para la API https://serverest.dev/usuarios*

## Estructura del Proyecto
├── src
│ └── test
│ ├── java
│ │ └── runner
│ │ └── TestRunner.java # Clase con tests para ejecución de pruebas
│ └── resources
│ ├── bodyRequests
│ │ └── createUser.json # Body request utilitario
│ ├── features
│ │ └── {ENDPOINTS}.feature # Archivos .feature con los scenarios por cada endpoint
│ ├── utilitario.feature # Funcionalidades reutilizables
│ └── karate-config.js # Configuración de entorno
├── target
│ └── karate-reports
│   └── {ENDPOINTS} # Reportes de ejecución por cada endpoint

## Endpoints
1. GET /usuarios - Obtener lista de usuarios
2. GET /usuarios/{id} - Obtener un usuario específico
3. POST /usuarios - Crear un nuevo usuario
4. PUT /usuarios/{id} - Actualizar un usuario
5. DELETE /usuarios/{id} - Eliminar un usuario

## Como requisitos de configuración considerar lo siguiente:
- Java 8 o superior
- Maven 3.6+
- IDE sugerido: IntelliJ
- Plugins karate, cucumber, gherkin

## Archivo karate-config.js
Aquí está definida la urlBase: 'https://serverest.dev'

## En la clase TestRunner están creados tests de la siguiente manera.
- Tests por cada feature. Por ejemplo, para el endpoint GET usuarios:
 " @Karate.Test
  Karate test_get_users() {
  return Karate.run("classpath:features/get-users.feature").relativeTo(getClass());
  }   "

- Ejecutar todos los features
    Test: runAllFeatures