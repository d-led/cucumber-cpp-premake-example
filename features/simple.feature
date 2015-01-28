# language: en

Feature: Echo
  In order to implement a ping service
  I want to have echo

  Scenario Outline: normal input
    Given an echo service
    When I send <request>
    Then I get <reply>

  Examples:
    | request | reply  |
    |         |        |
    | .       | .      |
    | hello   | hello  |
