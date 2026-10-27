Feature: Pruebas de Comments usando Karate y Faker

  Background:
      * url 'https://gorest.co.in/public/v2'
      * configure headers = { 'Authorization': 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954', 'Accept': 'application/json', 'Content-Type': 'application/json' }
      * def dataGenerator = Java.type('Utils.DataGenerator')

  Scenario: Obtener Comentarios
    Given path 'comments'
    When method Get
    Then status 200
    And match response == '#[]'

  Scenario: Crear Comentario Nuevo usando FakeData
    # 1. Crear un usuario previo
    * def userPayload = dataGenerator.getUserRandom()
    Given path 'users'
    And request userPayload
    When method Post
    Then status 201
    * def userId = response.id

    # 2. Crear un post previo para el comentario
    * def postPayload = dataGenerator.getPostRandom(userId)
    Given path 'posts'
    And request postPayload
    When method Post
    Then status 201
    * def postId = response.id

    # 3. Crear el Comentario con datos generados por Faker
    * def commentName = dataGenerator.getRandomCommentName()
    * def commentEmail = dataGenerator.getRandomCommentEmail()
    * def commentBody = dataGenerator.getRandomCommentBody()
    Given path 'comments'
    And request {"post_id": #(postId), "name": #(commentName), "email": #(commentEmail), "body": #(commentBody)}
    When method Post
    Then status 201
    And match response ==
    """
        {
          "id": "#number",
          "post_id": #(postId),
          "name": "#string",
          "email": "#string",
          "body": "#string"
        }
    """

  Scenario: Get Comentario especifico
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

    # 2. Crear comentario previo
    * def commentPayload = dataGenerator.getCommentRandom(postId)
    Given path 'comments'
    And request commentPayload
    When method Post
    Then status 201
    * def commentId = response.id

    # 3. Consultar el comentario específico
    Given path 'comments', commentId
    When method Get
    Then status 200
    And match response.id == commentId
    And match response.name == commentPayload.name
    And match response.email == commentPayload.email
    And match response.body == commentPayload.body

  Scenario: Modificar Un Comentario
    # 1. Crear usuario, post y comentario previo
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

    * def commentPayload = dataGenerator.getCommentRandom(postId)
    Given path 'comments'
    And request commentPayload
    When method Post
    Then status 201
    * def commentId = response.id

    # 2. Modificar el comentario usando Faker
    * def updatedName = dataGenerator.getRandomCommentName()
    * def updatedBody = dataGenerator.getRandomCommentBody()
    Given path 'comments', commentId
    And request {"name": #(updatedName), "body": #(updatedBody)}
    When method Put
    Then status 200
    And match response.name == updatedName
    And match response.body == updatedBody

  Scenario: Eliminar Un Comentario
    # 1. Crear usuario, post y comentario previo
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

    * def commentPayload = dataGenerator.getCommentRandom(postId)
    Given path 'comments'
    And request commentPayload
    When method Post
    Then status 201
    * def commentId = response.id

    # 2. Eliminar el comentario
    Given path 'comments', commentId
    When method Delete
    Then status 204

    # 3. Validar que ya no existe
    Given path 'comments', commentId
    When method Get
    Then status 404