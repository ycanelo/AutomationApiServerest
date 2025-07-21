Feature: Utilitario Users

  Background:
    * url urlBase

  @CREATE-USER-1
  Scenario: Crear usuario si no existe ID registrado
    * def userId = id
    Given path '/usuarios'
    * def json = read('classpath:bodyRequests/createUser.json')
    * set json.nome = name
    * set json.email = email
    * set json.password = password
    * set json.administrador = administrador
    And request json
    When method POST
    * def messResponse = response.message
    * if (messResponse == "Este email já está sendo usado") karate.abort()
    Then status 201
    * def userId = response._id

  @CREATE-USER-2
  Scenario: Crear usuario si no existe email registrado
    * def usermail = email
    Given path '/usuarios?email='+ usermail
    When method GET
    * if (response.quantidade == 1) karate.abort()
    Given path '/usuarios'
    * def json = read('classpath:bodyRequests/createUser.json')
    * set json.nome = name
    * set json.email = email
    * set json.password = password
    * set json.administrador = administrador
    And request json
    When method POST
    Then status 201
    * def userId = response._id

  @DELETE-USER-BY-EMAIL
  Scenario: Eliminar usuario buscando con el email
    * def usermail = email
    Given path '/usuarios?email='+ usermail
    When method GET
    Then status 200
    * if (response.quantidade==0) karate.abort()
    #get id by email
    * def userId = response.usuarios[0]._id
    #request delete
    Given path '/usuarios/' + userId
    When method DELETE
    Then status 200
    And match response.message =='Registro excluído com sucesso'