Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
      * url 'https://gorest.co.in/public/v2'
      * header Accept = 'application/json'
      * header Content-Type = 'application/json'
      * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'
      * def dataGenerator = Java.type('Utils.DataGenerator')
      * def payload =
        """
            {
                "gender":"male", 
                "status":"active"
            }
        """    
      * payload.name = dataGenerator.getUserRandom().name
      * payload.email = dataGenerator.getUserRandom().email 
      * def req_headers = {Authorization: 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'}
  Scenario: Obtener Usuarios
    Given path 'users'
    When method Get
    Then status 200
  Scenario: Crear Usuario Nuevo usando FakeData
    * def emailFake = dataGenerator.getEmailRandom()
    * def nameFake = dataGenerator.getRandonName()
    Given path 'users'
    And request {"name":#(nameFake), "gender":"male", "email":#(emailFake), "status":"active"}
    When method Post
    Then status 201
    And match response ==
    """
        {
        "id": "#number",
        "name": "#string",
        "email": "#string",
        "gender": "#string",
        "status": "#string"
        }

    """
  Scenario: Get Usuario especifico
    Given path 'users'
    And request payload
    When method Post
    Then status 201
    * def userid = response.id
    * print userid
    Given path 'users/' , userid
    And headers req_headers
    When method Get
    Then status 200
    And match response.email == payload.email
  Scenario: Modificar Un Usuario
    Given path 'users'
    And request payload
    When method Post
    Then status 201
    * def userid = response.id
    * print userid
    * def nameFake = "Fabricio Salazar"
    Given path 'users/' , userid
    And headers req_headers
    And request {"name":#(nameFake), "status":"inactive"}
    When method Put
    Then status 200
    And match response.name == nameFake
  Scenario: Eliminar Un Usuario
    Given path 'users'
    And request payload
    When method Post
    Then status 201
    * def userid = response.id
    * print userid
    Given path 'users/', userid
    And headers req_headers
    When method Delete
    Then status 204
    # Validar que el usuario fue eliminado
    Given path 'users/', userid
    And headers req_headers
    When method Get
    Then status 404