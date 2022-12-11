Feature: Broadway Search

  Scenario Outline: Verify show still appears in search result if user makes a typo in a query
    Given open "https://www.broadway.com/"
    And type "<query>" in "id=nav-typeahead-js"
    When send key "ENTER" to "id=nav-typeahead-js"
    Then assert text "1" presented in "xpath=//span[contains(text(),'1')]"

    Examples:
      | query                      |
      | the phantom of the opera   |
      | he phantom of the opera    |
      | phantom of opera           |
      | pantom of the opera        |
      | the phantom of the opare   |
      | phantom                    |