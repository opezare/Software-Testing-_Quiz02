*** Settings ***
Library    SeleniumLibrary

Suite Setup       Open Browser To App
Suite Teardown    Close All Browsers


*** Variables ***
${URL}            https://chiangmuan.igovapp.com/
${BROWSER}        chrome
${LINE_HOST}      access.line.me
${APP_HOST}       chiangmuan.igovapp.com
${WELCOME_TEXT}   ยินดีต้อนรับ

# เวลาให้ผู้ทดสอบกรอกข้อมูล/สแกน QR
${MANUAL_TIMEOUT}     120s
${SHORT_TIMEOUT}      30s


*** Keywords ***
Open Browser To App
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Click Login Button
    Wait Until Page Contains Element    xpath=//button[contains(.,'เข้าสู่ระบบ')] | //a[contains(.,'เข้าสู่ระบบ')]    timeout=${SHORT_TIMEOUT}
    Click Element    xpath=//button[contains(.,'เข้าสู่ระบบ')] | //a[contains(.,'เข้าสู่ระบบ')]

Click QR Code Login
    Wait Until Page Contains Element    xpath=//button[contains(.,'QR code login')] | //a[contains(.,'QR code login')]    timeout=${SHORT_TIMEOUT}
    Click Element    xpath=//button[contains(.,'QR code login')] | //a[contains(.,'QR code login')]

Wait Until On LINE Page
    Wait Until Location Contains    ${LINE_HOST}    timeout=${SHORT_TIMEOUT}

Wait Until Back To App
    Wait Until Location Contains    ${APP_HOST}     timeout=${MANUAL_TIMEOUT}

Verify Welcome Page
    Wait Until Page Contains    ${WELCOME_TEXT}    timeout=${SHORT_TIMEOUT}
    Page Should Contain         ${WELCOME_TEXT}


*** Test Cases ***
F01.3_TC3 - Login With QR And Stay On Welcome Page
    [Documentation]    เข้า LINE → กด QR code login → ผู้ทดสอบสแกนในมือถือ → กลับมาหน้าเว็บและค้างไว้ → ต้องเห็น “ยินดีต้อนรับ”
    [Tags]    F01.3_TC3

    Click Login Button
    Wait Until On LINE Page

    Click QR Code Login
    Log    กรุณาใช้มือถือสแกน QR และกดยืนยันให้เสร็จ ภายใน ${MANUAL_TIMEOUT}

    Wait Until Back To App
    Verify Welcome Page
    Log    PASS: Login สำเร็จด้วย QR และอยู่ที่หน้ายินดีต้อนรับ


F01.2_TC2 - Login With Email And Password (Manual)
    [Documentation]    เข้า LINE → ผู้ทดสอบกรอก Email/Password เอง → กดเข้าสู่ระบบ → กลับมาหน้าเว็บ → ต้องเห็น “ยินดีต้อนรับ”
    [Tags]    F01.2_TC2

    Click Login Button
    Wait Until On LINE Page

    Log    กรุณากรอก Email และ Password บนหน้า LINE แล้วกด “เข้าสู่ระบบ” ภายใน ${MANUAL_TIMEOUT}
    Log    หมายเหตุ: เทสนี้ตั้งใจไม่ฝังรหัสผ่านในโค้ดเพื่อความปลอดภัย (ผู้ทดสอบกรอกเอง)

    Wait Until Back To App
    Verify Welcome Page
    Log    PASS: Login สำเร็จด้วย Email/Password และอยู่ที่หน้ายินดีต้อนรับ

F01.1_TC1 - Open Website And Click Login
    [Documentation]    เปิดเว็บไซต์ → กดเข้าสู่ระบบ → ต้องถูก redirect ไปหน้า LINE login
    [Tags]    F01.1_TC1

    Click Login Button
    Wait Until On LINE Page

    Log    PASS: กด Login แล้ว redirect ไปหน้า LINE สำเร็จ