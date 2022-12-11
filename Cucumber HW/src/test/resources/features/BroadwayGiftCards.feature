Feature: Gift cards purchase

  Scenario: User selects $100 gift and asserts the amount
    Given open "https://www.broadway.com/"
    And click to "linkText=Gift Cards"
    And click to "linkText=Buy Now"
    When click to "xpath=//button[@data-qa='continue-to-delivery']"
    Then assert text "$100.00" presented in "xpath=//div[@data-qa='subtotal-amount']//strong"

  Scenario: User selects $250 gift and asserts the amount
    Given open "https://www.broadway.com/"
    And click to "linkText=Gift Cards"
    And click to "linkText=Buy Now"
    And click to "xpath=//input[@id='250']/following::span"
    When click to "xpath=//button[@data-qa='continue-to-delivery']"
    Then assert text "$250.00" presented in "xpath=//div[@data-qa='subtotal-amount']//strong"

  Scenario: User selects $500 gift and asserts the amount
    Given open "https://www.broadway.com/"
    And click to "linkText=Gift Cards"
    And click to "linkText=Buy Now"
    And click to "xpath=//input[@id='500']/following::span"
    When click to "xpath=//button[@data-qa='continue-to-delivery']"
    Then assert text "$500.00" presented in "xpath=//div[@data-qa='subtotal-amount']//strong"

  Scenario Outline: User selects "other" amount option (within accepted range) and asserts the amount
    Given open "https://www.broadway.com/"
    And click to "linkText=Gift Cards"
    And click to "linkText=Buy Now"
    When click to "xpath=//input[@id='other']/following::span"
    And type "<amount>" in "id=otherAmount"
    And send key "ENTER" to "id=otherAmount"
    Then assert text "<amount>" presented in "xpath=//div[@data-qa='subtotal-amount']//strong"

    Examples:
      | amount  |
      | 25.00   |
      | 30.00   |
      | 1500.00 |

  Scenario Outline: User selects "other" amount option (out of accepted range) and sees error message "Balance must be between $25 - $1,500."
    Given open "https://www.broadway.com/"
    And click to "linkText=Gift Cards"
    And click to "linkText=Buy Now"
    When click to "xpath=//input[@id='other']/following::span"
    And type "<amount>" in "id=otherAmount"
    And send key "ENTER" to "id=otherAmount"
    Then assert text "Balance must be between $25 - $1,500." presented in "xpath=//*[@id='error-otherAmount-field']"

    Examples:
      | amount |
      | 24     |
      | 1501   |

  Scenario: User selects "other" amount option (out of accepted range) and sees error message "Required." when attempting to proceed with empty filed.
    Given open "https://www.broadway.com/"
    And click to "linkText=Gift Cards"
    And click to "linkText=Buy Now"
    When click to "xpath=//input[@id='other']/following::span"
    And click to "xpath=//button[@data-qa='continue-to-delivery']"
    Then assert text "Required." presented in "xpath=//*[@id='error-otherAmount-field']"

  Scenario Outline: User selects "other" amount option, types non-digit character and sees error message "Balance must be a number."
    Given open "https://www.broadway.com/"
    And click to "linkText=Gift Cards"
    And click to "linkText=Buy Now"
    When click to "xpath=//input[@id='other']/following::span"
    And type "<amount>" in "id=otherAmount"
    And click to "xpath=//button[@data-qa='continue-to-delivery']"
    Then assert text "Balance must be a number." presented in "xpath=//*[@id='error-otherAmount-field']"

    Examples:
      | amount |
      | A      |
      | &      |