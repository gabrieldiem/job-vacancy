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

  Scenario: Cannot create new offer without salary
    When I create a new offer with title "Golang Dev", location "Korea", description "New grads" and salary ""
    Then I should see an offer error message asking to fill in the salary or input zero for unspecified salary

  Scenario: See newly created offer with salary in the offers list
    When I create a new offer with title "Golang Dev", location "Korea", description "New grads" and salary "10000"
    Then I should see a offer created confirmation message
    Then I activate the job offer
    And I should see a title "Golang Dev" in the offers list with location "Korea", description "New grads" and salary "10000"

  Scenario: Cannot create new offer with negative salary
    When I create a new offer with title "Golang Dev", location "Korea", description "New grads" and salary "-100"
    Then I should see an offer error message telling me the salary cannot be negative or to input zero for unspecified salary
