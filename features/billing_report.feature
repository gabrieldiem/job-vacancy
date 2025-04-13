@billing
Feature: Billing Report

  Scenario: b1 - billing report when no active offers
    Given there are no offers at all
    When I get the billing report
    Then the total active offers is 0
    And the total amount is 0.0

  Scenario: b2 - billing report contains all required fields for on-demand subscription
    Given a user "pedro@test.com" with "on-demand" subscription
    And 1 active offers
    When I get the billing report
    Then "pedro@test.com" is on user_email report field
    And the subscription is "on-demand"
    And the active_offers_count is 1
    And the amount to pay is 10.0

  Scenario: b3 - billing report contains all required fields for non-profit organization subscription
    Given a user "pedro@test.org" with "non-profit organization" subscription
    And 2 active offers
    When I get the billing report
    Then "pedro@test.org" is on user_email report field
    And the subscription is "organizational"
    And the active_offers_count is 2
    And the amount to pay is 0.0
