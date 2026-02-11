*** Settings ***
Library    SeleniumLibrary
Suite Setup       Open My Browser
Suite Teardown    Close Browser

*** Variables ***
${URL}        https://chiangmuan.igovapp.com/
${BROWSER}    chrome
${LINE_HOST}  access.line.me
${APP_HOST}   chiangmuan.igovapp.com

*** Keywords ***
Open My Browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Click Login Button
    # เผื่อบางหน้าปุ่มเป็น <button> หรือ <a>
    Wait Until Element Is Visible    xpath=//button[contains(.,'เข้าสู่ระบบ')] | //a[contains(.,'เข้าสู่ระบบ')]    20s
    Click Element    xpath=//button[contains(.,'เข้าสู่ระบบ')] | //a[contains(.,'เข้าสู่ระบบ')]

Ensure On LINE Login Page
    ${loc}=    Get Location
    Run Keyword If    '${LINE_HOST}' not in '${loc}'    Click Login Button
    Wait Until Location Contains    ${LINE_HOST}    20s
    Location Should Contain         ${LINE_HOST}

Wait Until Back To App
    # ให้เวลาทำ QR/OTP เอง แล้วรอ redirect กลับเว็บ
    Wait Until Location Contains    ${APP_HOST}    120s
    Location Should Contain         ${APP_HOST}

*** Test Cases ***
F01_1_Click_Login_Should_Redirect_To_LINE
    [Documentation]    คลิกเข้าสู่ระบบแล้วต้อง redirect ไปหน้า LINE Login
    Click Login Button
    Wait Until Location Contains    ${LINE_HOST}    20s
    Location Should Contain         ${LINE_HOST}

F01_2_Manual_Login_QR_OTP_Then_Return_To_App
    [Documentation]    ทำ LINE Login/QR/OTP ด้วยมือ แล้วกลับเว็บ และเห็นคำว่า “ยินดีต้อนรับ”
    Ensure On LINE Login Page
    Wait Until Back To App
    Wait Until Page Contains        ยินดีต้อนรับ    30s
    Page Should Contain             ยินดีต้อนรับ
