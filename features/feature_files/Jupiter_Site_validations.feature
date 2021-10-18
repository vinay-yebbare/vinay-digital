@VY_test



Feature: Jupiter online portal verification

  Background: I am on Jupiter Home Page
    Given I am on home page


  @VY_test01
  Scenario: Verify User is able to submit feedback from contacts page successfully

    And I navigate to the "contact" page
    Then I fill all the mandatory fields
    And I click the "Submit" Button
    Then I validate the successful submission message

  @VY_test02
  Scenario: Verify User is able to add multiple items to cart

    And I navigate to the "shop" page
    And I add "2" item "Funny Cow" to the cart
    And I add "1" item "Funny Bunny" to the cart
    And I click the "cart" Button
    Then I verify added items are in the cart

  @VY_test03
  Scenario: Verify user to able to validate the sub-total on the cart for added products

    And I navigate to the shop page
    And I add "2" item "Stuffed Frog" to the cart
    And I add "5" item "Funny Bunny" to the cart
    And I add "3" item "valentine Bear" to the cart
    And I click the "cart" Button
    Then I verify sub-total for each product