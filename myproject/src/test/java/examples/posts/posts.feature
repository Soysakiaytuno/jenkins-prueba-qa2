Feature: Pruebas de Posts usando Karate y Faker

  Background:
      * url 'https://gorest.co.in/public/v2'
      * configure headers = { 'Authorization': 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954', 'Accept': 'application/json', 'Content-Type': 'application/json' }
      * def dataGenerator = Java.type('Utils.DataGenerator')

  Scenario: Obtener Posts
    Given path 'posts'
    When method Get
    Then status 200
    And match response == '#[]'

  Scenario: Crear Post Nuevo usando FakeData
    # 1. Crear un usuario previo para obtener su user_id
    * def userPayload = dataGenerator.getUserRandom()
    Given path 'users'
    And request userPayload
    When method Post
    Then status 201
    * def userId = response.id

    # 2. Crear el Post con datos generados por Faker
    * def postTitle = dataGenerator.getRandomTitle()
    * def postBody = dataGenerator.getRandomBody()
    Given path 'posts'
    And request {"user_id": #(userId), "title": #(postTitle), "body": #(postBody)}
    When method Post
    Then status 201
    And match response ==
    """
        {
          "id": "#number",
          "user_id": #(userId),
          "title": "#string",
          "body": "#string"
        }
    """

  Scenario: Get Post especifico
    # 1. Crear usuario y post previo
    * def userPayload = dataGenerator.getUserRandom()
    Given path 'users'
    And request userPayload
    When method Post
    Then status 201
    * def userId = response.id

    * def postPayload = dataGenerator.getPostRandom(userId)
    Given path 'posts'
    And request postPayload
    When method Post
    Then status 201
    * def postId = response.id

    # 2. Consultar el post específico
    Given path 'posts', postId
    When method Get
    Then status 200
    And match response.id == postId
    And match response.title == postPayload.title
    And match response.body == postPayload.body

  Scenario: Modificar Un Post
    # 1. Crear usuario y post previo
    * def userPayload = dataGenerator.getUserRandom()
    Given path 'users'
    And request userPayload
    When method Post
    Then status 201
    * def userId = response.id

    * def postPayload = dataGenerator.getPostRandom(userId)
    Given path 'posts'
    And request postPayload
    When method Post
    Then status 201
    * def postId = response.id

    # 2. Modificar el post usando Faker
    * def updatedTitle = dataGenerator.getRandomTitle()
    * def updatedBody = dataGenerator.getRandomBody()
    Given path 'posts', postId
    And request {"title": #(updatedTitle), "body": #(updatedBody)}
    When method Put
    Then status 200
    And match response.title == updatedTitle
    And match response.body == updatedBody

  Scenario: Eliminar Un Post
    # 1. Crear usuario y post previo
    * def userPayload = dataGenerator.getUserRandom()
    Given path 'users'
    And request userPayload
    When method Post
    Then status 201
    * def userId = response.id

    * def postPayload = dataGenerator.getPostRandom(userId)
    Given path 'posts'
    And request postPayload
    When method Post
    Then status 201
    * def postId = response.id

    # 2. Eliminar el post
    Given path 'posts', postId
    When method Delete
    Then status 204

    # 3. Validar que ya no existe
    Given path 'posts', postId
    When method Get
    Then status 404