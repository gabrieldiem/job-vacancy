Feature: Birthdate Registration
    As a JobOfferer
    I want to provide my birthdate
    So I can register to publish offers

    Background:
        Given the current date is "2025/04/21"
        And the format is YYYY/MM/DD

    Scenario: US-1.1 Successful registration with valid birthdate (26 yo)
        Given I register with a birthdate of "1999/04/21"
        Then I should be able to complete the registration successfully

    Scenario: US-1.2 Successful registration with barely valid birthdate (18 yo)
        Given I register with a birthdate of "2007/04/21"
        Then I should be able to complete the registration successfully

    Scenario: US-1.3 Cannot register with a future birthdate
        Given I register with a birthdate of "2030/04/21"
        Then I should see the error message "date must be in the past"

    Scenario: US-1.4 Cannot register with a birthdate under 18 years old
        Given I register with a birthdate of "2010/04/21"
        Then I should see the error message "must be over 18 to register"

    Scenario: US-1.5 Cannot register with a birthdate over 150 years old
        Given I register with a birthdate of "1412/04/21"
        Then I should see the error message "birth date invalid"

    Scenario: US-1.6 Cannot register with an incorrectly formatted birthdate
        Given I register with a birthdate of "january first, 2001"
        Then I should see the error message "invalid date format"

    @wip
    Scenario: US-1.7 Cannot register without a birthdate
        Given I register with a birthdate of ""
        Then I should see the error message "can't be blank"