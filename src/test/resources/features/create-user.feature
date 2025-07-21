@createUser
Feature: Validar endpoint post create usuario

  Background:
    * url urlBase

  @postCreateUser01 @HappyPathPostCreate
  Scenario Outline: Creación exitosa de usuario
    #prepare data
    * def userData = {email: "<email>"}
    * call read('classpath:utilitario.feature@DELETE-USER-BY-EMAIL') userData
    #request CREATE
    Given path '/usuarios'
    * def json = read('classpath:bodyRequests/createUser.json')
    * set json.nome = '<name>'
    * set json.email = '<email>'
    * set json.password = '<password>'
    * set json.administrador = '<administrador>'
    And request json
    When method POST
    Then status 201
    And match response.message =='Cadastro realizado com sucesso'
    And match response._id == '#string'
    And print 'Usuario creado con éxito. ID: ', response._id
    Examples:
      | name     | email             | password | administrador |
      | test0001 | test0001@test.com | test0001 | true          |

  @postCreateUser02 @UnhappyPathPostCreate
  Scenario Outline: Creación fallida por enviar campos en blanco
    Given path '/usuarios'
    * def json = read('classpath:bodyRequests/createUser.json')
    * set json.nome = '<name>'
    * set json.email = '<email>'
    * set json.password = '<password>'
    * set json.administrador = '<administrador>'
    And request json
    When method POST
    And print response
    Then status 400
    Examples:
      | name     | email             | password | administrador | empty_value |
      | test0001 |                   | test0001 | true          | email       |
      |          | test0001@test.com | test0001 | true          | nome        |
      | test0001 | test0001@test.com |          | true          | password    |

  @postCreateUser03 @UnhappyPathPostCreate
  Scenario Outline: Creación fallida por enviar datos inválidos
    Given path '/usuarios'
    * def json = read('classpath:bodyRequests/createUser.json')
    * set json.nome = '<name>'
    * set json.email = '<email>'
    * set json.password = '<password>'
    * set json.administrador = '<administrador>'
    And request json
    When method POST
    And print response
    Then status 400
    And match response.<invalid_value> contains '<message>'
    Examples:
      | name     | email             | password | administrador | invalid_value | message                        |
      | test0002 | test0002          | test0002 | true          | email         | email deve ser um email válido |
      | test0002 | test0002@test.com | test0002 | TEST          | administrador | administrador deve ser         |

  @postCreateUser04 @UnhappyPathPostCreate
  Scenario Outline: Creacion de usuario fallida por email ya registrado
    #prepare data
    * def userData = {name: "<name>",email: "<email>",password: "<password>",administrador: "<administrador>"}
    * call read('classpath:utilitario.feature@CREATE-USER-2') userData
    #request CREATE
    Given path '/usuarios'
    * def json = read('classpath:bodyRequests/createUser.json')
    * set json.nome = '<name>'
    * set json.email = '<email>'
    * set json.password = '<password>'
    * set json.administrador = '<administrador>'
    And request json
    When method POST
    Then status 400
    And match response.message =='Este email já está sendo usado'
    And print 'No se creó el usuario. El email: <email> ya está registrado.'
    Examples:
      | name     | email           | password | administrador |
      | test0007 | test0007@qa.com | test0007 | true          |