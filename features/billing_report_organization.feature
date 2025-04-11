@billing @wip
Feature: Non-Profit Organization Billing Report

Background:
    Given a user "pepe@children.org" with "non-profit organization" subscription

Scenario: o1 - non-profit organization subscription with no offers
    Given 0 active offers
    When I get the billing report
    Then the amount to pay for the user "pepe@children.org" is 0.0
    And the total active offers are 0

  @wip
Scenario: o2 - non-profit organization subscription with 1 offer
    Given 1 active offers
    When I get the billing report
    Then the amount to pay for the user "pepe@children.org" is 0.0
    And the total active offers are 1

  @wip
Scenario: o3 - non-profit organization subscription with 7 offers
    Given 7 active offers
    When I get the billing report
    Then the amount to pay for the user "pepe@children.org" is 0.0
    And the total active offers are 7

  @wip
Scenario: o4 - non-profit organization subscription with 8 offers (1 inactive)
    Given 7 active offers
    And 1 inactive offers
    When I get the billing report
    Then the amount to pay for the user "pepe@children.org" is 0.0
    And the total active offers are 7
