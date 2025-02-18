*** Settings ***
Resource  ../../configuration/reqres/globalconfig/allresource.resource


*** Test Cases ***
Verify Create User Success
    [Documentation]       Owner: supasete.1998@gmail.com
    ...    *** Description ***
    ...    ตรวจสอบการสร้าง user บนเว็บไซต์ reqres.in
    ...    ==>
    ...    *** Test Data ***
    ...    "name": "morpheus",
    ...    "job": "leader"
    ...    ==>
    ...    *** Test Steps ***
    ...    1. จัดเตรียม payload สําหรับสร้าง user
    ...    2. ส่ง request สําหรับสร้าง user ไปที่ https://reqres.in/api/users
    ...    3. ตรวจสอบ response code และ response message
    ...    ==>
    ...    *** Expect Result ***
    ...    1. Response Code :201
    ...    2. Response Message : 
    ...    "name": "morpheus",
    ...    "job": "leader",
    ...    "id": "XXX",
    ...    "createdAt": "XXXX-XX-XXXXX:XX:XX.XXXX"
    ...    ==>  
    [Tags]    Create
    Create User
    Prepare User Detail Expected  morpheus  leader  ${response_id}  ${response_createdAt}
    Validate Status Code  ${response}  201
    Validate Response Message  ${response}  ${exp_user_detail_1}

Verify Update User Information Success
    [Documentation]       Owner: supasete.1998@gmail.com
    ...    *** Description ***
    ...    ตรวจสอบการแก้ไข user information บนเว็บไซต์ reqres.in
    ...    ==>
    ...    *** Test Data ***
    ...    "name": "morpheus",
    ...    "job": "zion resident"
    ...    ==>
    ...    *** Test Steps ***
    ...    1. จัดเตรียม payload สําหรับแก้ไข user
    ...    2. ส่ง request แก้ไข user ไปที่ https://reqres.in/api/users/2
    ...    3. ตรวจสอบ response code และ response message
    ...    ==>
    ...    *** Expect Result ***
    ...    1. Response Code :200
    ...    2. Response Message : 
    ...    "name": "morpheus",
    ...    "job": "zion resident",
    ...    "updatedAt": "XXXX-XX-XXXXX:XX:XX.XXXX"
    ...    ==>  
    [Tags]    Edit
    Edit User
    Prepare User Detail After Edit Expected  morpheus  zion resident  ${response_updatedAt}
    Validate Status Code  ${response}  200
    Validate Response Message  ${response}  ${exp_user_detail_1}

Verify Delete User Success
    [Documentation]       Owner: supasete.1998@gmail.com
    ...    *** Description ***
    ...    ตรวจสอบการลบ user บนเว็บไซต์ reqres.in
    ...    ==>
    ...    *** Test Steps ***
    ...    2. ส่ง request ลบ user ไปที่ https://reqres.in/api/users/2
    ...    3. ตรวจสอบ response code และ response message
    ...    ==>
    ...    *** Expect Result ***
    ...    1. Response Code :204
    ...    ==>  
    [Tags]    Delete
    Delete User
    Validate Status Code  ${response}  204

Single User
    [Documentation]       Owner: supasete.1998@gmail.com
    ...    *** Description ***
    ...    ตรวจสอบการ Get user บนเว็บไซต์ reqres.in ใน ID ที่กำหนด
    ...    ==>
    ...    *** Test Steps ***
    ...    1. ส่ง request Get user ไปที่ https://reqres.in/api/users/2
    ...    2. ตรวจสอบ response code และ response message
    ...    ==>
    ...    *** Expect Result ***
    ...    1. Response Code :200
    ...    2. Response Message :
    ...    {
    ...        "data": {
    ...            "id": 2,
    ...            "email": "janet.weaver@reqres.in",
    ...            "first_name": "Janet",
    ...            "last_name": "Weaver",
    ...            "avatar": "https://reqres.in/img/faces/2-image.jpg"
    ...        },
    ...        "support": {
    ...            "url": "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
    ...            "text": "Tired of writing endless social media content? Let Content Caddy generate it for you."
    ...        }
    ...    }
    ...    ==>  
    [Tags]    Get
    Single User
    Prepare User Detail After Get Expected
    Validate Status Code  ${response}  200
    Validate Response Message  ${response}  ${response_payload}

    