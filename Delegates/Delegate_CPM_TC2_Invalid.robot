*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
Library     ../Library/XMLParser.py
Resource     ../Resources/CPM_Delegate_Resources.robot
Library     DataDriver  ../TestData/Delegate_Invalid.xlsx
Suite Setup     Open Browser To Login Page
Test Template   Invalid Delegates
Suite Teardown     Log out


*** Test Cases ***
Delegate addition with ${TYPE} : ${EMAIL USER}


*** Keywords ***
Invalid Delegates
    [Arguments]     ${EMAIL USER}
    Check Adding Invalid Delegates      ${EMAIL USER}

###################################################################