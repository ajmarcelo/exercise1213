*** Settings ***
Documentation   A resource file with reusable keywords and variables
...
...             Creating system specific keywords from default keywords
...             from SeleniumLibrary
Library         SeleniumLibrary

*** Variables ***
${SERVER}                   www.saucedemo.com
${BROWSER}                  chrome
${DELAY}                    0

${VALID USER}               standard_user
${LOCKED OUT USER}          locked_out_user
${PROBLEM USER}             problem_user

${VALID PASSWORD}           secret_sauce
${INVALID PASSWORD}         secretsecret

${LOGIN URL}                https://${SERVER}/
${HOME URL}                 https://${SERVER}/inventory.html

${A TO Z}                   az
${Z TO A}                   za
${LOW TO HIGH}              lohi
${HIGH TO LOW}              hilo

${active az}                NAME (A TO Z) 
${active za}                NAME (Z TO A)
${active lohi}              PRICE (LOW TO HIGH)
${active hilo}              PRICE (HIGH TO LOW)

${BROKEN INVENTORY IMAGE}   /static/media/sl-404.168b1cce.jpg

*** Keywords ***
# Login Related
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed      ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Page Should Contain Element     login-button

Product Page Should Be Open
    Element Text Should Be      class:title     PRODUCTS

Input Username
    [Arguments]     ${username}
    Input Text      user-name    ${username}

Input Pass
    [Arguments]     ${password}
    Input Password      password    ${password}
    
Submit Credentials
    Click Button    login-button

Valid Login
    Open Browser To Login Page
    Input Username  ${VALID USER}
    Input Pass  ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open

# Error messages
Locked Out Message
    Element Text Should Be     css:div#root h3     Epic sadface: Sorry, this user has been locked out.

Error Message
    Element Text Should Be     css:div#root h3     Epic sadface: Username and password do not match any user in this service

# Filter
Select Filter
    [Arguments]     ${filter}
    Select From List By Value   css:*[data-test="product_sort_container"]   ${filter}