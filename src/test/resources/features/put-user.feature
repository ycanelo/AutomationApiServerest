@updateUser
Feature: Validar endpoint put usuario por id

  Background:
    * url urlBase

  @updateUser01 @HappyPathUpdateUser
  Scenario Outline: Edicion exitosa de usuario
    #prepare data
    * def userData = {id:"<id>",name: "<name>",email: "<email>",password: "<password>",administrador: "<administrador>"}
    * call read('classpath:utilitario.feature@DELETE-USER-BY-EMAIL') userData
    * call read('classpath:utilitario.feature@CREATE-USER-1') userData
    #request PUT
    Given path '/usuarios/' , userId
    * def json = read('classpath:bodyRequests/createUser.json')
    * set json.nome = '<name>'
    * set json.password = '<password>'
    * set json.email = '<email>'
    * set json.administrador = '<administrador>'
    And request json
    When method PUT
    Then status 200
    And match response.message =='Registro alterado com sucesso'
    #verify update
    Given path  '/usuarios/' , userId
    When method GET
    Then status 200
    And match response.nome == '<name>'
    And match response.password == '<password>'
    And match response.email == '<email>'
    And match response.administrador == '<administrador>'
    And print 'Usuario actualizado con éxito.'
    Examples:
      | name           | email             | password       | administrador | id               |
      | test0009Update | test0009@test.com | test0009Update | false         | DNgfVb9fFTtq5Mc5 |

  @updateUser02 @HappyPathUpdateUser
  Scenario Outline: Edición de usuario con email no existente
    #verify and prepare user data
    * def userId = '<id>'
    * def userEmail = {email: "<email>"}
    * call read('classpath:utilitario.feature@DELETE-USER-BY-EMAIL') userEmail
    #request PUT
    Given path '/usuarios/' , userId
    * def json = read('classpath:bodyRequests/createUser.json')
    * set json.nome = '<name>'
    * set json.email = '<email>'
    * set json.password = '<password>'
    * set json.administrador = '<administrador>'
    And request json
    When method PUT
    Then status 201
    And match response.message =='Cadastro realizado com sucesso'
    And match response._id == '#string'
    #verify post update
    Given path '/usuarios/' + response._id
    When method GET
    Then status 200
    And match response.email == '<email>'
    And print 'No existe correo. Se creó usuario con ID: ', response._id
    Examples:
      | id               | name     | email             | password | administrador |
      | 12345abcde012345 | test0222 | test0222@test.com | test0222 | true          |