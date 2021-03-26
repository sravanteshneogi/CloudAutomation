*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
    Click Button    ${btn_login}
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm}
    Click Element   ${lnk_cpm}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call

Check Adding Valid and Duplicate Delegates
   [Arguments]        ${EMAIL USER}
    Wait until Element Is Visible   ${lbl_delegate}
    page should contain     No data available
    Wait until Element Is Visible   ${lbl_delegate}
    Click Element   ${lbl_delegate}
    Wait until Element Is Visible   ${txt_delegate}
    sleep_call_2

    element should be enabled   ${btn_delegate_add}
    element should be visible   ${btn_delegate_add}
    element should be disabled  ${btn_delegate_remove}

    click element   ${btn_delegate_add}
    sleep_call_2
    element should be disabled  ${dlg_btn_delegate_add}
    element should be enabled   ${dlg_btn_delegate_cancel}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    sleep_call_2
    element should be visible   ${lst_delegate}
    element should contain      ${lst_delegate}       ${EMAIL USER}
    Press Keys    ${lst_delegate}    ENTER
    sleep_call_2
    element should be enabled   ${dlg_btn_delegate_add}
    click button    ${dlg_btn_delegate_add}
    sleep_call_2

    element text should be      ${lst_table_entry}      ${EMAIL USER}

    click element   ${btn_delegate_add}
    sleep_call_2
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    sleep_call_2
    element should be visible   ${lst_delegate}
    element should contain      ${lst_delegate}       ${EMAIL USER}
    Press Keys    ${lst_delegate}    ENTER
    sleep_call_2
    element should be disabled   ${dlg_btn_delegate_add}
    page should contain      Delegate already exists
    click button    ${dlg_btn_delegate_cancel}

    element should be disabled      ${btn_delegate_remove}
    ${dummy_click}      set variable        delegatesBreadcrumb
    sleep_call_2
    click element     ${chk_delegate_delete}
    sleep_call_2
    click element   ${dummy_click}
    element should be enabled      ${btn_delegate_remove}
    click button    ${btn_delegate_remove}
    sleep_call_2

    element text should be      ${lbl_delete_delegate}     Remove Delegates

    element should be enabled   ${btn_delegate_delete_cancel}
    element should be enabled   ${btn_delegate_delete_ok}
    element should be focused   ${btn_delegate_delete_cancel}

    click button    ${btn_delegate_delete_ok}
    sleep_call_2

    element should not be visible   ${lst_table_entry}
    sleep_call

Check Adding Invalid Delegates
   [Arguments]        ${EMAIL USER}
    Wait until Element Is Visible   ${lbl_delegate}
    page should contain     No data available
    Wait until Element Is Visible   ${lbl_delegate}
    Click Element   ${lbl_delegate}
    Wait until Element Is Visible   ${txt_delegate}
    sleep_call_2

    click element   ${btn_delegate_add}
    sleep_call_2
    element should be disabled  ${dlg_btn_delegate_add}
    element should be enabled   ${dlg_btn_delegate_cancel}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    sleep_call_2
    element should not be visible   ${lst_delegate}
    sleep_call_2
    element should be disabled   ${dlg_btn_delegate_add}
    click button    ${dlg_btn_delegate_cancel}
    sleep_call_2






Log out
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers
###################################################################################################################


