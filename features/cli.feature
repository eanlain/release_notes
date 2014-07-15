Feature: Cli
  In order to run ReleaseNotes from the command line
  Cli commands must run properly

  Background:
    Given a Rails app named "hello_world" exists
    And this gem "release_notes" is installed in the app
    And this gem is ready to use


  Scenario: Generate a new release note
    Given I am in "tmp/hello_world"
    And I run `release_notes new`
    Then a directory named "release_notes" should exist
    And a file matching %r<[0-9]*_0_1_0.md$> should exist


  Scenario: Save a release note to the database
    Given I am in "tmp/hello_world"
    And I run `release_notes new`
    Then a model named "ReleaseNote" should have "0" records

    And I run `release_notes update`
    Then a model named "ReleaseNote" should have "1" records


  Scenario: Generate release note to a specific destination
    Given I am in "tmp/hello_world"
    And I run `release_notes new -d="whatwhat"`
    Then a directory named "whatwhat" should exist
    And a directory named "release_notes" should not exist
    And a file matching %r<[0-9]*_0_1_0.md$> should exist


  Scenario: Overwrite a previous release note
    Given I am in "tmp/hello_world"
    And I run `release_notes new`
    And I run `release_notes new -v=0.1.0 -f`
    Then a file matching %r<[0-9]*_0_1_0.md$> should exist


  Scenario: Generate release notes in increments
    Given I am in "tmp/hello_world"
    And I run `release_notes new`
    And I run `release_notes new -i=m`
    Then a file matching %r<[0-9]*_0_2_0.md$> should exist

    And I run `release_notes new -i=M`
    Then a file matching %r<[0-9]*_1_0_0.md$> should exist

    And I run `release_notes new -i=major`
    Then a file matching %r<[0-9]*_2_0_0.md$> should exist

    And I run `release_notes new -i=minor`
    Then a file matching %r<[0-9]*_2_1_0.md$> should exist

    And I run `release_notes new`
    Then a file matching %r<[0-9]*_2_1_1.md$> should exist

    And I run `release_notes update`
    Then a model named "ReleaseNote" should have "6" records


  Scenario: Runs ReleaseNotes interatively
    Given I am in "tmp/hello_world"
    When I run `release_notes new -m` interactively
    And I type "a: This is a test!"
    And I type "done"
    And I type "Some summary statement..."
    Then a directory named "release_notes" should exist
    And a file matching "/release_notes/[0-9]*_0_1_0.md" should contain "Some summary statement..." 


  Scenario: Update release notes in a specific directory
    Given I am in "tmp/hello_world"
    And I run `release_notes new`
    And I run `release_notes new`
    And I run `release_notes new -d=oye`
    And I run `release_notes new -d=oye`
    And I run `release_notes new -d=oye`
    And I run `release_notes update -d=oye`
    Then a model named "ReleaseNote" should have "3" records


  Scenario: Use the given version
    Given I am in "tmp/hello_world"
    And I run `release_notes new -v=1.2.3`
    Then a file matching %r<[0-9]*_1_2_3.md$> should exist


  Scenario: Update release notes without creating a log
    Given I am in "tmp/hello_world"
    And I run `release_notes new`
    And I run `release_notes update -n`
    Then the file "release_notes/README.md" should not exist


  Scenario: Returns the version of ReleaseNotes
    Given I am in "tmp/hello_world"
    When I run `release_notes -v`
    Then the output from "release_notes -v" should contain "ReleaseNotes v"
