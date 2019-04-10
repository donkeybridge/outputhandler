Feature: outputhandler should be aware of CR and NL

  Scenario: #puts and #puts! should send with newline but without CR
    Given a new instance is created
    Then output should contain a NL but no CR when sent to "puts"
    Then output should contain a NL but no CR when sent to "puts!"


  Scenario: #puts(true) and #puts!(true) should send with NL but also with CR 
    Given a new instance is created
    Then output should contain a NL with leading CR when sent to "puts" with param true
    Then output should contain a NL with leading CR when sent to "puts!" with param true
    

  Scenario: #print and #print! should send without newline
    Given a new instance is created
    Then output should contain neither NL nor CR when sent to "print"
    Then output should contain neither NL nor CR when sent to "print!"

  Scenario: #print(true) and #print!(true) should send without NL but with CR
    Given a new instance is created 
    Then output should contain a leading CR but no NL when sent to "print" with param true
    Then output should contain a leading CR but no NL when sent to "print!" with param true

  Scenario: #print(true) overwrite former #print(true)
    Given an OutputHandler is created with parameter "logfile" set to "/tmp/barfile"
    And "foo" is sent to the handler with print
    Then file "/tmp/barfile" should contain output "foo"
    And "bar" is sent to the handler with print and param true
    Then file "/tmp/barfile" should contain output "bar"

