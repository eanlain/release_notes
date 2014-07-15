Feature: Generators
  In order to run ReleaseNotes properly
  Generators must run properly

  Background:
    Given a Rails app named "hello_world" exists
    And this gem "release_notes" is installed in the app


  Scenario: Generate ReleaseNotes initializer
    Given I am in "tmp/hello_world"
    When I run `rails generate release_notes:install`
    Then the file "config/initializers/release_notes.rb" should exist
   
   
  Scenario: Generate ReleaseNote migration
    Given I am in "tmp/hello_world"
    When I run `rails generate release_notes ReleaseNote`
    Then a file matching %r<[0-9]*_release_notes_create_release_notes.rb$> should exist
    And the file "config/routes.rb" should contain "mount ReleaseNotes::Engine, at: '/release_notes', :as => 'release_notes'"
