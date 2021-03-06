*** Settings ***
Library  SeleniumLibrary
#Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Library     ../Library/ChromeWebDriver.py
Resource     ../Resources/Master.robot
Library     OperatingSystem


*** Variables ***
#${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
#${URL}                          https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
#${NORMALBROWSER}                Edge
${username_blank}
${username_invalid}             sravantesh@lexmark.com
${password_blank}
${password_invalid}             Password@12345
${EMAIL USER}                   user_pallabi@test.onelxk.co
${FILENAME}                     Attachment.txt
${username_nonadmin}            cpmautomation@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.
${costcenter}                   stl
${noquotaassignment}            No custom quota definitions for assigning.
${totaldisable}                 0
${total}
${color}
${mobile_job}                   mobile.doc
${quota_name}                   Quota_Total50_Color50
${dept}                         rnd
${FILENAME2}                    Test Mail.html
${MACSAASNAME}                         Cloud Print Management
${MACSAASLINK}                         macPackageType-listbox-item-default
${MACSAAS_PACKAGE NAME}                 LPMCCloudEU_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.182.pkg
${MACHYBRIDNAME}                         Hybrid Print Management
${MACHYBRIDLINK}                         macPackageType-listbox-item-serverless
${MACHYBRID_PACKAGE NAME}                LPMCServerlessEU_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.183.pkg
${WINSAASNAME}                      Cloud Print Management
${WINSAASLINK}                      windowsPackageType-listbox-item-default
${WINSAAS_PACKAGE NAME}                 LPMC_CloudEU_2.3.960.0_UPD_2.15_Win_PCLXL_1.0.289.exe
${WINHYBRIDNAME}                      Hybrid Print Management
${WINHYBRIDLINK}                      windowsPackageType-listbox-item-serverless
${WINHYBRID_PACKAGE NAME}               LPMC_ServerlessEU_2.3.960.0_UPD_2.15_Win_PCLXL_1.0.289.exe
${notification}                         True
${DELETE CLIENT FOLDER}                 True
${unused_client_value_delete_span}      10
${hybrid_unprinted_jobs_value}          20
${latebind}                             True
${hybrid_printed_jobs_value}            120
${saas}                                 True
${FILEPATH}                             C:\\Users\\neogis\\D Drive\\FREEDOM\\Python\\STL_Automation\\Attachments\\Attachment.txt
${WEBFILENAME}                          Attachment.txt
${SUITENAME}                             Environment is:
${ENV}
${NONADMIN}                             cpmautomation@test.onelxk.co
#${DOWNLOADBROWSER}                      Edge

*** Settings ***
Force Tags      Environment-${URL}

*** Test Cases ***
Verification of correct cloud login
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
Verification of dashboard title
    Dashboard Should Open
Check CPM page opens
    Validate CPM page opens
Logout from portal for admin
    Exit
Delegate addition and deletion using ${EMAIL USER}
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
    Validate CPM page opens
    Check Adding Valid and Duplicate Delegates      ${EMAIL USER}
Web Upload and print verification for Text file
    Web upload with     ${IP}   ${PIN}  ${FILEPATH}    ${WEBFILENAME}
Mobile Job Submission and print verification
    Mobile submission   ${IP}   ${PIN}
Email submission and print verification with different file using ${FILENAME}
    Email submission with  ${IP}   ${PIN}   ${FILENAME}
Verify quota creation Total 50 and Color 50 for current month
    Open Organisational Policy Page
    Open Quota Definition Page
    Create Quota different for month
Verify Cost Center Assignment
    Open Organisational Policy Page
    Select Cost Center or Personal First
    Open Quota Assignment Page
    Set Quota Assignment for Cost Center
    Delete Quota without user
Verify quota creation Total 50 and Color 50 for all month
    Open Quota Definition Page
    Create Monthly Quota
Verify Department Quota Assignment
    Open Organisational Policy Page
    Select Department or Personal
    Open Quota Assignment Page
    Set Quota Assignment for Department
    Delete Quota without user
Reset Quota to Cost Center
    Open Organisational Policy Page
    Select Cost Center or Personal
Verify User Quota Status by personal assignment
    Open Organisational Policy Page
    Select Personal
    Open Quota Definition Page
    Create Custom Quota
    Set Quota Assignment for Personal
Verify user status for normal reduction
    Check Status Table for normal       ${USER}     ${PASSWORD}     ${URL}
Verify user status for warning reduction
    Check Status Table for warning      ${USER}     ${PASSWORD}     ${URL}
Verify user status for exceeded reduction
    Check Status Table for exceeded     ${USER}     ${PASSWORD}     ${URL}
    Delete Quota    ${USER}     ${PASSWORD}     ${URL}    ${NONADMIN}
    Reset to Cost center
Log out from portal
    Logoutadmin
Verfication download of MAC Default SAAS package
    Download MAC Default Packages for SAAS    ${MACSAASNAME}     ${MACSAASLINK}     ${MACSAAS_PACKAGE NAME}    ${URL}
Verfication download of MAC Default Hybrid package
    Download MAC Default Packages for Hybrid    ${MACHYBRIDNAME}     ${MACHYBRIDLINK}     ${MACHYBRID_PACKAGE NAME}    ${URL}
Verification download of Windows Default Packages for SAAS
    Download Default Packages for Windows for SAAS    ${WINSAASNAME}     ${WINSAASLINK}      ${WINSAAS_PACKAGE NAME}   ${URL}
Verification download of Windows Default Packages for Hybrid
    Download Default Packages for Windows for Hybrid    ${WINHYBRIDNAME}     ${WINHYBRIDLINK}      ${WINHYBRID_PACKAGE NAME}   ${URL}
Verification of custom package for Windows
    Create Custom Package for Windows   ${notification}     ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
#####################################################################