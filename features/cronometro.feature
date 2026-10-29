Feature: Pruebas del Cronómetro en Reloj

  Background:
    Given Estoy en la pestaña de cronómetro

  @cronometro @detener5s
  Scenario: Detener el cronómetro a los 5 segundos
    When Inicio el cronómetro
    And Espero "5" segundos
    And Detengo el cronómetro
    Then El cronómetro debería marcar "5" segundos

  @cronometro @pausarYReanudar
  Scenario: Pausar el cronómetro a los 5 segundos y continuar hasta los 10 segundos
    When Inicio el cronómetro
    And Espero "5" segundos
    And Pauso el cronómetro
    Then El cronómetro debería marcar "5" segundos
    When Reanudo el cronómetro
    And Espero "5" segundos
    And Detengo el cronómetro
    Then El cronómetro debería marcar "10" segundos

  @cronometro @vueltaYReset
  Scenario: Registrar una vuelta en el cronómetro y reiniciar a cero
    When Inicio el cronómetro
    And Espero "2" segundos
    And Registro una vuelta
    And Detengo el cronómetro
    Then La vuelta número "01" debería estar visible
    When Reinicio el cronómetro
    Then El cronómetro debería marcar "00:00.00"
    And La vuelta número "01" no debería existir

