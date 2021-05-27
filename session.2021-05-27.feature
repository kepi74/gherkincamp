Feature: Přihlášení klienta s SMS autorizací

    Jako klient chci pro přihlašování použít kromě požadovaného jména a hesla
    SMS klíč jako druhý faktor ověření, protože nevlastním chytrý telefon,
    nebo nechci používat bankovní aplikaci.

    Background:
        Given Existing User is on Sign-in page

    Scenario: Client can sign-in with valid credentials and SMS code
        Given User submits valid credentials
        And User selects SMS certification method
        When User submits valid SMS code
        Then Access to application is granted for given User

    Scenario: Client can request resend of SMS code
        Given User submits valid credentials
        And User selects SMS certification method
        When SMS validity time is expired
        And User request a resending of sms
        Then User obtains the new SMS code

    #    Scenario: Client is notified about invalid credentials
    #        Given Existing User
    #        When User submits invalid credentials
    #        Then User is informed that credentials are invalid

    Scenario: Client is notified about invalid SMS code
        Given User submits valid credentials
        And User selects SMS certification method
        When User submits invalid SMS code
        Then User is informed that credentials are invalid

    Scenario: User has logged in
        Given User selected SMS method
        And filled in the data
        When the code is ok
        And there is <numberOfContexts> for the User
        Then <screen> is displayed

        Examples:
            | numberOfContexts | screen           |
            | 1                | Dasboard         |
            | 2-n              | Client selection |

    Scenario: User submits login name and password correctly
        Given user has filled in the data
        When user submits the form
        And the data is ok
        Then Second factor page is displayed with selection of methods
        And only those factors are available which are applicable for the user

    Scenario: User submits login name and password not correctly
        Given user has filled in the data
        When user submits the form
        And the data is not ok
        Then The same page remains displayed
        And error message is displayed

    Scenario: User has logged in and more client contexts are available
        Given User selected SMS method
        And filled in the data
        When user submits the SMS code
        And the code is ok
        And there are more client contexts for the user
        Then The client selection is displayed

    Scenario: User has logged in and one client context is available
        Given User selected SMS method
        And filled in the data
        When User submits the SMS code
        And the code is ok
        And there is one client contexts for the user
        Then Dashboard is displayed

    Scenario: User has logged in and no client context is available
        Given User selected SMS method
        And filled in the data
        When User submits the SMS code
        And the code is ok
        And there is no client contexts for the user
        Then Error message is displayed

    Scenario: User submitted SMS factor not properly
        Given User selected SMS method
        And filled in the data
        When User submits the SMS code
        And the code is not ok
        Then The same screen remains displayed
        And error message is displayed

    @manual
    Scenario: User failed to enter SMS code within the time period
        Given User selected SMS method
        And filled in the data
        When user submits the SMS code
        And the time period for entering code is over
        Then The same screen remains displayed
        And error message is displayed
        And uživatel má možnost nechat si zaslat nový kód

    Scenario: User asks for another code
        Given User selected SMS method
        And User has no valid SMS code
        When User asks for another code
        Then The same screen remains displayed
        And Countdown is reset to initial value

    Scenario: User selects the client
        Given User logged in correctly
        And User has more than one client context
        When User asks selects the client
        Then The dashboard is displayed