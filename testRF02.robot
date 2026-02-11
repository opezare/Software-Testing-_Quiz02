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
    Wait Until Element Is Visible    xpath=//button[contains(.,'เข้าสู่ระบบ')] | //a[contains(.,'เข้าสู่ระบบ')]    20s
    Click Element                    xpath=//button[contains(.,'เข้าสู่ระบบ')] | //a[contains(.,'เข้าสู่ระบบ')]

Wait Until On LINE Login
    Wait Until Location Contains    ${LINE_HOST}    20s
    Location Should Contain         ${LINE_HOST}

Click QR Code Login
    # LINE อาจทำเป็น <button> หรือ <a> เลยครอบ 2 แบบ
    Wait Until Page Contains Element    xpath=//button[contains(.,'QR code login')] | //a[contains(.,'QR code login')]    20s
    Click Element                       xpath=//button[contains(.,'QR code login')] | //a[contains(.,'QR code login')]

Wait Until Back To App
    Wait Until Location Contains    ${APP_HOST}    120s
    Location Should Contain         ${APP_HOST}

*** Test Cases ***
F01_1_Go_To_LINE_And_Click_QR_Login
    [Documentation]    กดเข้าสู่ระบบ -> ไปหน้า LINE -> กดปุ่ม QR code login
    Click Login Button
    Wait Until On LINE Login
    Click QR Code Login

F01_2_Manual_Scan_QR_Then_Return_To_App
    [Documentation]    หลังจากกด QR code login ให้ผู้ใช้สแกน/ยืนยันเอง แล้ว Robot รอ redirect กลับเว็บและเช็คว่าเข้าได้
    Click Login Button
    Wait Until On LINE Login
    Click QR Code Login

    # ทำ QR/ยืนยันในมือถือเองภายใน 120 วินาที
    Wait Until Back To App

    # เช็คว่ากลับมา “หน้าในระบบ” (จากรูปที่คุณเคยส่งมีคำว่า 'ยินดีต้อนรับ')
    Wait Until Page Contains    ยินดีต้อนรับ    30s
    Page Should Contain         ยินดีต้อนรับ
