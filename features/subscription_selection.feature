Feature: Subscription selection in registration
  As a JobOfferer
  I want to select my subscription type
  So I can register to publish offers

  Background:
    Given I am in the register page

  Scenario: US-2.1 Show all subscription types
    Given I press the button to see the subscription types
    Then I should be able to see all of the subscription types available

  Scenario: US-2.2 Successful registration with subscription On Demand
    Given I fill the registration form and I select the subscription type "On demand" and email is "pepe@gmail.com"
    When I press the Register button
    Then I should see the subscription type under my email
@wip
  Scenario: US-2.3 Cannot register without subscription
    Given I fill the registration form and don’t select a subscription
    When I press the Register button
    Then I should see the error message "can’t be blank"

  Scenario: US-2.4 Successful registration of NonCommercialOrganization subscription type
    Given I fill the registration form and I select the subscription type "Non-commercial organization" and email is "example@place.org"
    When I press the Register button
    Then I should see the subscription type under my email

  Scenario: US-2.5 Cannot register with non-org email and NonCommercialOrganization subscription type
    Given I fill the registration form and I select the subscription type "Non-commercial organization" and email is "pepe@gmail.com"
    When I press the Register button
    Then I should see the error message "must have .org mail for non commercial organization subscription"

  Scenario: US-2.6 Cannot activate 8th job offer with non-profit organization
    Given I have a "Non-commercial organization" subscription with email "example@place.org"
    And add 7 active job offers
    When I press the button to activate the 8th active job offer
    Then I should see the error message "limit exceeded for non commercial organization subscription. Max is 7 active offers"
