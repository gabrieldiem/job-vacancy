Feature: Job Offer Salary
  As a job offerer

  Background:
    Given I am logged in as job offerer

  @wip
  Scenario: Create new offer with salary
    When I create a new offer with title "Golang Dev", location "Korea", description "New grads" and salary "10000"
    Then I should see a offer created confirmation message
    And I should see a title "Golang Backend Dev" in my offers list
    And the location should be "South Korea"
    And the description should be "For new grads"
    And the salary should be "10000"

