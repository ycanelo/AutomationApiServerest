@deleteUser
Feature: Validar endpoint delete usuario por id

  Background:
    * url urlBase

  @deleteUser01 @HappyPathDeleteUser
  Scenario Outline: Eliminacion exitosa de usuario
    #prepare data
    * def userData = {id:"<id>",name: "<name>",email: "<email>",password: "<password>",administrador: "<administrador>"}
    * call read('classpath:utilitario.feature@CREATE-USER-1') userData
      #request DELETE
    Given path '/usuarios/' + userId
    When method DELETE
    And print response
    Then status 200
    And match response.message =='Registro excluído com sucesso'
    #verify post delete
    Given path '/usuarios/' + userId
    When method GET
    Then status 400
    And match response.message == 'Usuário não encontrado'
    And print 'Usuario eliminado con éxito.'
    Examples:
      | id               | name          | email                  | password | administrador |
      | 8rQNLVdIVtObRgGL | André Almeida | almeida.ae@outlook.com | 123456   | true          |

  @deleteUser02 @UnhappyPathDeleteUser
  Scenario Outline: Validar eliminacion de usuario con Id no registrado
    Given path '/usuarios/<id>'
    When method DELETE
    And print response
    Then status 200
    And match response.message =='Nenhum registro excluído'
    Examples:
      | id               |
      | 12345abcde012345 |

  @deleteUser03 @UnhappyPathDeleteUser
  Scenario Outline: Validar eliminación de usuario con Id inválido por cantidad de caracteres
    Given path '/usuarios/<id>'
    When method DELETE
    And print response
    Then status 200
    And match response.message == 'Nenhum registro excluído'
    Examples:
      | n_caracteres | id                |
      | 15           | 1MaMoiRknCzB4sf   |
      | 17           | 1MaMoiRknCzB4sf00 |