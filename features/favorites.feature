Feature: Mark job offers as favourites

  Background:
    Given a job offer exists created by a job offerer
    And I am logged in as a registered user
    And I have active job offers

  Scenario: US-6.1 Mark a job offer as favorite
    When I visit the job offers page
    And I click the button to mark as favourite for the job offer "Software Engineer"
    Then I see the message "Job offer marked as favourite"
@wip
  Scenario: US-6.2 Unmark a job offer as favorite
    Given I marked the job offer "Software Engineer" as favorite
    When I visit the job offers page
    And I click the button to mark as favourite
    Then I see the message "Job offer unmarked as favorite"
@wip
  Scenario: US-6.3 Cannot mark my own job offer as favorite
    Given I am logged in as a job offerer
    When I visit the job offers page
    And I click the button to mark as favourite on my own job offer
    Then I should not see the message "Job offer marked as favorite"
@wip
  Scenario: US-6.4 Cannot see the button to mark as favourite if not logged in
    Given I am not logged in
    When I visit the job offers page
    Then I do not see the button to mark as favourite for the offers
@wip
  Scenario: US-6.5 Unmarked as favourite all job offers
    Given I have marked one job offer as favorite
    When I visit the job offers page
    And I click the "Unfavorite All" button
    Then I see the message "All favorites removed"
@wip
  Scenario: US-6.6 View the favorites count on my job offers
    Given I am logged in a job offerer
    And 3 users have marked my job offer as favorite
    When I visit my job offers page
    Then I see "3 favorites" for that job offer
