*** Settings ***
Library  SeleniumLibrary
Library     CloudLogin.py
Library     DataDriver  ../TestData/OutputBin.xlsx
Suite Setup     Check total number of output bins
Test Template   Validation of Output Bin dropdown
Suite Teardown     Reset , Log Out and Close Browsers

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co
#${BROWSER}                      Chrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Output Bins listed

*** Test Cases ***
Validation of Output Bin combobox setting Output Bin as ${OUTPUT BIN NAME}
    Check total number of output bins
    Validation of Output Bin dropdown
    Reset , Log Out and Close Browsers


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

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   //*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call


#Check Print Queue Opens and check Text
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    element should contain  xpath://*[@id="printQueuePageHeaderDropDown_button"]/div   ${tab1name}

#Open Print default settings
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    wait until page contains element   ${default_settings_btn}
    click button    ${default_settings_btn}
    sleep_call
    #wait until page contains element    settingsUpdatingBusySpinner
    wait until page contains element    saveChangesButton
#Check page size count
    element attribute value should be   //*[@id="outputBin-listbox-item-printer"]   aria-setsize   14
    sleep_call_2

Validation of Output Bin dropdown
    #sleep_call
    #sleep_call
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    #sleep_call
    [Arguments]        ${OUTPUT BIN}     ${OUTPUT BIN CONTROL}       ${OUTPUT BIN NAME}
    set selenium timeout    20
    #wait until page contains element    holePunch
    #scroll element into view        holePunch
    sleep_call_1
    click element   ${OUTPUT BIN}
    sleep_call_1
    click element   ${OUTPUT BIN CONTROL}
    sleep_call_1
    click button    saveChangesButton
    sleep_call_2
    wait until page contains element   ${default_settings_btn}
    click button    ${default_settings_btn}
    sleep_call
    #wait until page contains element    settingsUpdatingBusySpinner
    wait until page contains element    saveChangesButton
    element attribute value should be   ${OUTPUT BIN CONTROL}   title   ${OUTPUT BIN NAME}
#    sleep_call
#    sleep_call
#    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
#    sleep_call
#    [Arguments]        ${OUTPUT BIN}     ${OUTPUT BIN CONTROL}       ${OUTPUT BIN NAME}
#
#    sleep_call
#    #wait until page contains element    holePunch
#    #scroll element into view        holePunch
#    sleep_call_2
#    click element   ${OUTPUT BIN}
#    sleep_call_2
#    click element   ${OUTPUT BIN CONTROL}
#    element attribute value should be   ${OUTPUT BIN CONTROL}   title   ${OUTPUT BIN NAME}
#    sleep_call_2
#    ${status}=       run keyword and return status  element attribute value should be   ${OUTPUT BIN CONTROL}   title   ${OUTPUT BIN NAME}
#
#    Run keyword if  ${status}==False    click button    cancelChangesButton
#    ...         ELSE    click button    saveChangesButton
#    #wait until page contains element    settingsUpdatingBusySpinner
#    sleep_call
#    click button    ${default_settings_btn}
#    sleep_call

Reset , Log Out and Close Browsers
    sleep_call_2
    set selenium timeout    20
    click element   outputBin
    click element   outputBin-listbox-item-printer
    sleep_call_2
    click button    saveChangesButton
    wait until page contains element    settingsUpdatingBusySpinner
    sleep_call
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

###################################################################################################################


