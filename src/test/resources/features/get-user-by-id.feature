@getUserById
Feature: Validar endpoint get usuarios por id

  Background:
    * url urlBase

  @getUserById01 @HappyPathGetById
  Scenario Outline: Consulta exitosa de usuario por ID
    #prepare data
    * def userData = {id: "<id>",name: "<name>",email: "<email>",password: "<password>",administrador: "<administrador>"}
    * call read('classpath:utilitario.feature@CREATE-USER-1') userData
    #request GET
    Given path '/usuarios/' + userId
    When method GET
    Then status 200
	* def user = response
    * print user
    * match user.nome == '#string'
    * match user.email == '#string'
    * match user.password == '#string'
    * match user.administrador == '#string'
    * match user._id == '#string'
    And print 'Se encontró usuario con ID: ' + userId
    Examples:
      | id               | name     | email           | password | administrador |
      | amumaqSjyKqlcUJh | Test0008 | Test0008@qa.com | Test0008 | false         |


  @getUserById02 @UnhappyPathGetById
  Scenario Outline: Validar consulta de usuario con Id no registrado
    Given path '/usuarios/<id>'
    When method GET
    Then status 400
    And print response
    * match response.message == 'Usuário não encontrado'
    * print 'No se encontró usuario con id: <id>'
    Examples:
      | id               |
      | 1MaMoiRknCzB4sf5 |

  @getUserById03 @UnhappyPathGetById
  Scenario Outline: Validar consulta de Id inválido por cantidad de caracteres
    Given path '/usuarios/<id>'
    When method GET
    Then status 400
    And print response
    And match response.id == 'id deve ter exatamente 16 caracteres alfanuméricos'
    Examples:
      | n_caracteres | id                |
      | 15           | 1MaMoiRknCzB4sf   |
      | 17           | 1MaMoiRknCzB4sf00 |