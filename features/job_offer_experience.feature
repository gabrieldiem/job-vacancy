Feature: Add experience required to job offer

  Background:
  Given I am logged in as job offerer

  Scenario: US-3.1 Successful job offer creation with experience required
    When I create and activate a job offer with "2" years of required experience
    Then I should see "2 years" in required experience in the job offers list
    And I should see "2 years" in my offers

  Scenario: US-3.2 Successful job offer creation with 1 year of required experience
    When I create and activate a job offer with "1" years of required experience
    Then I should see "1 year" in required experience in the job offers list
    And I should see "1 year" in my offers

  Scenario: US-3.3 Job offer with 0 years of required experience shows no required experience
    When I create and activate a job offer with "0" years of required experience
    Then I should see "No experience required" in required experience in the job offers list
    And I should see "No experience required" in my offers


  Scenario: US-3.4 Experience required is mandatory
    When I create a job offer without filling the required experience
    Then I should see the error "can't be blank"

  Scenario: US-3.5 Experience required can be edited
    Given an existing job offer with "2" years of experience required
    When I edit the job offer and change the experience to "5" years
    Then I should see "5 years" in my offers

  @wip
  Scenario: US-3.6 Experience required cannot be negative
    When I create a job offer with "-1" years of required experience
    Then I should see the error "can't be negative"

  @wip
  Scenario: US-3.7 Experience required cannot be text
    When I create a job offer with "five years" years of required experience
    Then I should see the error message "Please enter the years as a number"
