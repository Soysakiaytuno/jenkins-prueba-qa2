Feature: Pruebas del Temporizador en Reloj

  Background:
    Given Estoy en la pestaña de temporizadores

  @temporizador @suena
  Scenario: Crear un temporizador de 5 segundos y esperar a que suene
    When Creo un temporizador de "5" segundos
    And Espero "6.5" segundos
    Then El temporizador debería estar sonando
    When Detengo y elimino el temporizador
    Then El temporizador no debería existir

  @temporizador @detenerAntes
  Scenario: Crear un temporizador de 5 segundos pero detenerlo antes y no suena
    When Creo un temporizador de "5" segundos
    And Espero "2" segundos
    And Pauso el temporizador antes de que suene
    And Espero "4" segundos
    Then El temporizador no debería estar sonando
    And El temporizador debería permanecer pausado
    When Elimino el temporizador

