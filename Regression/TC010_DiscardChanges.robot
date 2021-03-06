*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Force Tags      Print Settings

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${loginyear}                    © 2021, Lexmark. All rights reserved.
${cpmyear}                      © 2021 Lexmark.
${tab1name}                     Print Queue
${tab2name}                     Delegates
${tab3name}                     Print Job History
${tab4name}                     Download Print Management Client
${next}                         Next
${login}                        Log In
${id}
${job_status_actual}            Ready
${default_title_actual}         Set Default Print Settings
${delete_dlg_title_actual}      Delete Print Jobs


*** Test Cases ***
Discard Change dialog validation
    Open Browser To Login Page
    Increment Copy validation by 1 to 2
    Validation of Confirmation dialog by Discarding
    Validation of Confirmation Dialog by Saving Changes
    Log Out Close Browsers


*** Keywords ***

Open Browser To Login Page
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
#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services


#Check Print Queue Opens and check Text
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue

    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     printQueueUploadButton
    click button    ${default_settings_btn}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    ${default_title}            set variable    printSettingsBreadcrumb

    #element attribute value should be   ${default_title}    aria-label   ${default_title_actual}

Increment Copy validation by 1 to 2
    set selenium timeout    20
    click element   //*[@id="copies_increment"]
    sleep_call_1
    textfield should contain    //*[@id="copies_input"]  2
    click element   //*[@id="collateCheckboxDiv"]/div/cui-description/span

Validation of Confirmation dialog by Discarding
    set selenium timeout    20
    Click Element   id:link-navPrintQueue

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     id:confirmation-modal_modalHeader
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element   id:confirmation-modal_modalHeader
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     id:confirmation-modal_okButton
    click button        confirmation-modal_okButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      printQueueDefaultPrintSettingsButton
    click button    printQueueDefaultPrintSettingsButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      copies_input
    textfield should contain    //*[@id="copies_input"]  1

Validation of Confirmation Dialog by Saving Changes
    set selenium timeout    20
    click element   //*[@id="copies_increment"]
    sleep_call_1
    textfield should contain    //*[@id="copies_input"]  2
    Click Element   id:link-navPrintQueue
    wait until element is visible       id:confirmation-modal_modalHeader
    wait until page contains element    id:confirmation-modal_modalHeader
    click button        confirmation-modal_cancelButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      copies_input
    textfield should contain    //*[@id="copies_input"]  2



Log Out Close Browsers
    set selenium timeout    20
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers


###################################################################################################################


