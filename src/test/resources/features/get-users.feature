@getUsersAll
Feature: Validar endpoint get usuarios

  Background:
    * url urlBase

  @getUsers01 @HappyPathGetUsersAll
  Scenario: Consulta exitosa de lista de usuarios
    Given path '/usuarios'
    When method GET
    Then status 200
    * match response contains  { quantidade: '#number' , usuarios: '#[]' }
    * def users = response
    * match users.usuarios[*].nome == '#[] #string'
    * match users.usuarios[*].email == '#[] #string'
    * match users.usuarios[*].password == '#[] #string'
    * match users.usuarios[*].administrador == '#[] #string'
    * match users.usuarios[*]._id == '#[] #string'
    * print 'Hay una lista de:', response.quantidade , 'usuarios'
    * def printDetailUsers =
       """
       function(usersList){
       users =''
       for(i=0;i<usersList.length;i++) {
          message = 'USUARIO' + (i+1) + ' - ID: '+ usersList[i]._id + ', NOMBRE: '+ usersList[i].nome+  ', EMAIL: '+ usersList[i].email+ ', PASSWORD: '+ usersList[i].password+ ', ADMIN: '+  usersList[i].administrador + '\n'
          users = users + message
       }
       return users
       }
       """
    * def detailUser = call printDetailUsers users.usuarios
    * print detailUser

  @getUsers02 @UnhappyPathGetUsersAll
  Scenario: Validar consulta con query param que no corresponde
    Given path '/usuarios'
    And param key = 'user'
    When method GET
    Then status 400
    * print response
    * match response contains  { key: 'key não é permitido' }

  @getUsers03 @UnhappyPathGetUsersAll
  Scenario: Validar consulta con path inválido
    Given path '/users'
    When method GET
    Then status 405
    * print response
    * match response.message contains 'Não é possível realizar GET em /users. Acesse https://serverest.dev para ver as rotas disponíveis e como utilizá-las.'