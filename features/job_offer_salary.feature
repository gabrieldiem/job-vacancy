Feature: Job Offer Salary
  As a job offerer

  Background:
    Given I am logged in as job offerer

  Scenario: Create new offer with salary
    When I create a new offer with title "Golang Dev", location "Korea", description "New grads" and salary "10000"
    Then I should see a offer created confirmation message
    And I should see a title "Golang Dev" in my offers list
    And the location should be "Korea"
    And the description should be "New grads"
    And the salary should be "10000"

  @wip @indev
  Scenario: Cannot create new offer without salary
    When I create a new offer with title "Golang Dev", location "Korea", description "New grads" and salary ""
    Then I should see an offer error message asking to fill in the salary
