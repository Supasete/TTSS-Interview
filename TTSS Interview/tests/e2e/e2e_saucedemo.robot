*** Settings ***
Resource  ../../configuration/saucedemo/globalconfig/allresource.resource


*** Test Cases ***
Verify Complete Ordering Work Flow On Saucedemo Website
    [Documentation]       Owner: supasete.1998@gmail.com
    ...    *** Description ***
    ...    ตรวจสอบการสั่งซื้อสินค้าและการทำงานบนเว็บไซต์ saucedemo
    ...    ==>
    ...    *** Test Steps ***
    ...    1. เข้าสู่หน้าเว็บ saucedemo และทำการ login ด้วย username/password ตัวอย่างที่เว็บไซต์จัดเตรียมไว้ให้ 
    ...    2. เลือกหาซื้อสินค้า T-Shirt, Flashlight และ Backpack หากพบสินค้าเหล่านี้ ให้คลิกปุ่ม Add to cart เพื่อหยิบใส่รถเข็น 
    ...    โดยต้องเลือกดูสินค้าให้ครบทุกตัว หากไม่พบสินค้า โปรแกรมจะดำเนินการต่อ ไปยังขั้นตอนถัดไป แต่ต้องบันทึกในผลการทดสอบ (test result)
    ...    3. ลูกค้าตัดสินใจคืนสินค้า Backpack โดยคลิกปุ่ม Remove จากนั้นตรวจสอบสินค้าในตะกร้า หากถูกต้องครบถ้วน 
    ...    ให้คลิกปุ่ม Checkout เพื่อดำเนินการชำระเงิน หากพบสินค้าที่ไม่ต้องการ ให้คลิกปุ่ม Remove เพื่อลบออก
    ...    4. กรอกข้อมูลผู้สั่งซื้อ จากนั้นกดปุ่ม Continue เพื่อดำเนินการต่อ
    ...    5. ตรวจสอบรายการสินค้าครั้งสุดท้าย และราคารวมว่าถูกต้องทั้งหมดหรือไม่ โดยสินค้ามีการคิดภาษีอยู่ที่ 8% ของราคารวมของสินค้า
    ...    6. หากการสั่งซื้อสำเร็จ จะต้องปรากฏหน้าจอ Thank you for your order!
    ...    7. แสดง log หรือบันทึกการทำงานของโปรแกรม automate ที่เกิดขึ้น สามารถแสดงในรูปแบบ text file, Json หรือชุด text ที่เป็น test result
    ...    ==>
    ...    *** Expect Result ***
    ...    1. โปรแกรม test สามารถค้นหาสินค้าที่เป็น “T-Shirt” ได้ถูกต้อง และหยิบใส่ตะกร้ารถเข็น
    ...    2. โปรแกรม test สามารถคำนวณราคารวมของสินค้าและภาษีได้ถูกต้อง
    ...    3. โปรแกรม test สามารถดำเนินการสั่งซื้อสำเร็จ
    ...    ==>  
    [Tags]    e2e
    Open Browser  ${URL}
    Login Saucedemo  ${usernameStandard}  ${password}
    Select Add Product From List To Cart
    Go To Shopping Cart Page
    Verify Product In Cart Equal Selected Product
    Remove Selected Product From Shopping Cart
    Verify Product In Shopping Cart After Remove Selected Product
    Go To Checkout Page
    Fill Personal Information And Click Continue  ${name}  ${last_name}  ${postal_code}
    Verify Product And Product Price In Checkout Page
    Verify Price Total In Checkout Page
    Finish Order
    Verify Order Complete Page