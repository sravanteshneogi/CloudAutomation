*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
Library     ../Library/XMLParser.py
Library     DataDriver  ../TestData/OutputBin.xlsx
Library     ../PageObjects/Locators.py
Suite Setup     Check total number of output bins
Test Template   Validation of Output Bin dropdown
Suite Teardown     Reset , Log Out and Close Browsers

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Output Bins listed

*** Test Cases ***
Validation of Output Bin combobox setting Output Bin as ${OUTPUT BIN NAME}
    Validation of Output Bin dropdown


*** Keywords ***

Check total number of output bins
    Open Browser    ${URL}    ${BROWSER}
    set selenium timeout    20
#Maximise Browser
    Maximize Browser Window
    Title Should Be     Lexmark Log In

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services


#Check Print Queue Opens and check Text
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    element should contain  xpath://*[@id="printQueuePageHeaderDropDown_button"]/div   ${tab1name}

#Open Print default settings
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     printQueueUploadButton
    click button    ${default_settings_btn}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
#Check page size count
    element attribute value should be   //*[@id="outputBin-listbox-item-printer"]   aria-setsize   14

Validation of Output Bin dropdown
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    [Arguments]        ${OUTPUT BIN}     ${OUTPUT BIN CONTROL}       ${OUTPUT BIN NAME}
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${OUTPUT BIN}
    click element   ${OUTPUT BIN}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${OUTPUT BIN CONTROL}
    click element   ${OUTPUT BIN CONTROL}

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      saveChangesButton
    click button    saveChangesButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     printQueueUploadButton
    click button    ${default_settings_btn}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    element attribute value should be   ${OUTPUT BIN CONTROL}   title   ${OUTPUT BIN NAME}


Reset , Log Out and Close Browsers
    set selenium timeout    20
    click element   outputBin
    click element   outputBin-listbox-item-printer
    click button    saveChangesButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     printQueueUploadButton
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers


###################################################################################################################


