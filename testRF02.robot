*** Settings ***
Library    SeleniumLibrary

Suite Setup       Open Browser To App
Suite Teardown    NONE

*** Variables ***
${URL}            https://chiangmuan.igovapp.com/
${BROWSER}        chrome
${LINE_HOST}      access.line.me
${APP_HOST}       chiangmuan.igovapp.com

*** Keywords ***
Open Browser To App
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Click Login Button
    Click Element    xpath=//button[contains(.,'เข้าสู่ระบบ')] | //a[contains(.,'เข้าสู่ระบบ')]

Click QR Code Login
    Click Element    xpath=//button[contains(.,'QR code login')] | //a[contains(.,'QR code login')]

Wait Until On LINE Page
    Wait Until Location Contains    ${LINE_HOST}    timeout=20s

Wait Until Back To App
    Wait Until Location Contains    ${APP_HOST}    timeout=120s

*** Test Cases ***
Login With QR And Stay On Welcome Page
    [Documentation]    เข้า LINE → กด QR code login → สแกนในมือถือ → กลับมาหน้าเว็บและค้างไว้

    Click Login Button
    Wait Until On LINE Page

    Click QR Code Login

    Log    กรุณาใช้มือถือสแกน QR และกดยืนยันให้เสร็จ ภายใน 120 วินาที

    Wait Until Back To App

    Wait Until Page Contains    ยินดีต้อนรับ    timeout=30s
    Page Should Contain         ยินดีต้อนรับ

    Log    Login สำเร็จ และค้างอยู่ที่หน้ายินดีต้อนรับ
