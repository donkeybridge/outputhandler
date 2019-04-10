Feature: Initialization

  Scenario: Create a new OutputHandler from scratch without any options
    Given a new OutputHandler is created without options
    Then it should return an object of class OutputHandler
    Then it should have an instance variable "@outputQueue"
    And  "@outputQueue" should be a "Queue"
    And  it should have an instance variable "@console"
    And  "@console" should be a Boolean
    And  it should have an instance variable "@file"
    And  "@file" should be a Boolean
    And  it should have an instance variable "@logfile"
    And  "@logfile" should be nil
    And it should be not paused?
    And it should not respond to #foo
    And #out! should send output with newline to console
    And #out should send output with newline to console
    And #out! should send output to console without newline when added parameter false
    And #out should send output to console without newline when added parameter false



  Scenario Outline: Checking whether it is responding to methods
    Given a new OutputHandler is created
    Then  it should respond to "<method>"
    Examples:
      | method     |
      | paused?    |
      | pause      |
      | unpause    | 
      | out        | 
      | out!       | 
      | flush      | 
      | puts       |
      | puts!      |
      | print      |
      | print!     |
