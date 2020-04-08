Feature: Main flow

  Background:
    Given user exists
    Given I am on login page
    When I fill in "user[email]" field with "test@example.com"
    And I fill in "user[password]" field with "password"
    And I click on "Log in"

  @javascript
  Scenario: User logs into the system
    Then I should see text "Hello, worlddddd!"

  @javascript
  Scenario: Admin user logs into the system and edits an existing course
    Given user is admin
    And the course exists with the name "Ruby"
    When I go to courses
    And I click on "Edit"
    When I fill in "course[name]" field with "Test Course"
    And I click on "Save"
    Then there should be a course with name "Test Course he-he-he"
