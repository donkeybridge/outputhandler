Feature: A new OutputHandler can react to options hash

  Scenario: Only Hash as Parameter is accepted
    Given a OutputHandler will be created
    Then with a String as parameter is should raise a TypeError
    Then with a Hash as parameter it should not raise

  Scenario: Parameter "console: false" disables default console output
    Given an OutputHandler is created with parameter "console" set to "false"
    Then  #out should not send output

  Scenario: Parameter "logile: filename" enables output to filename
    Given an OutputHandler is created with parameter "logfile" set to "/tmp/foofile"
    And output is send to #out 
    Then file "/tmp/foofile" should contain output
