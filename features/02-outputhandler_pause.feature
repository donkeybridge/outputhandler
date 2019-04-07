Feature: Pausing and unpausing the Outputhandler

  Scenario: Creating and pausing the outputhandler should send output via #out! but not via #out
    Given a new instance is created
    And it is paused 
    Then #out! should send output
    But #out should not send output

  Scenario: Creating and pausing the outputHandler should not send output via #out, but after unpausing it should

    Given a new instance is created
    And it is paused
    Then #out should not send output
    And #out should send immediate output when unpausing

  Scenario: Creating and pausing the outputHandler for 2 second should not print anything, but after 2 seconds it should

    Given a new instance is created
    And   it is paused for 2 seconds
    Then  #out should not send immediate output
    But   should arrive after 2 seconds

  Scenario: Creating and pausing the outputhandler, output should not be sent immediately, but upon #flush
    Given a new instance is created
    And   it is paused
    And   output is send to #out
    And   output is send to #out
    Then  it should send immediate upon #flush
    Given output is send to #out
    Then  it should not send immediate upon silent #flush
    And   #out should not send immediate output when unpausing


