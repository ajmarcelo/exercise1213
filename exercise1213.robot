*** Settings ***
Documentation   A test suite with a single test for valid login
...             
...             This test follows the example using keywords from
...             the SeleniumLibrary
Resource        exercise1213-resources.robot

*** Test Cases ***
1. Successful user log in
    Valid Login
    [Teardown]      Close Browser

2. Unsuccessful user log in by a locked out user
    Open Browser To Login Page
    Input Username      ${LOCKED OUT USER} 
    Input Pass          ${VALID PASSWORD}
    Submit Credentials
    Locked Out Message
    [Teardown]          Close Browser

3. Typed wrong password
    Open Browser To Login Page
    Input Username      ${VALID USER} 
    Input Pass          ${INVALID PASSWORD}
    Submit Credentials
    Error Message
    [Teardown]          Close Browser

4. Logged in as problem user and sees a broken inventory page
    Open Browser To Login Page
    Input Username              ${PROBLEM USER}
    Input Pass                  ${VALID PASSWORD}
    Submit Credentials
    Page Should Contain Image   ${BROKEN INVENTORY IMAGE}
    [Teardown]                  Close Browser

5. Sort product name (A to Z)
    Valid Login
    Select Filter           ${A TO Z}
    Element Should Contain  css:*[class="active_option"]   ${active az}
    [Teardown]              Close Browser

6. Sort product name (Z to A)
    Valid Login
    Select Filter           ${Z TO A}
    Element Should Contain  css:*[class="active_option"]   ${active za}
    [Teardown]              Close Browser    

7. Sort product price (low to high)
    Valid Login
    Select Filter               ${LOW TO HIGH}
    Element Should Contain      css:*[class="active_option"]   ${active lohi}
    [Teardown]                  Close Browser

8. Sort product price (high to low)
    Valid Login
    Select Filter           ${HIGH TO LOW}
    Element Should Contain  css:*[class="active_option"]   ${active hilo}
    [Teardown]              Close Browser
