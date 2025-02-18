*** Settings ***
Resource     ../../configuration/reqres/globalconfig/allresource.resource


*** Variables ***
${GET}    get
${POST}    post
${PUT}    put
${DELETE}    delete
${PATCH}   patch


*** Keywords ***	
Call API
    [Documentation]    Owner : supasete.1998@gmail.com
    [Arguments]    ${base_url}    ${method}    ${path_url}    ${headers}=${None}     ${query}=${None}    ${data}=${None}
    Create Session    create_session    ${base_url}      verify=true
    IF    "${method}" == "${GET}"
        ${response}  GET On Session  create_session  ${path_url}  headers=${headers}   params=${query}
        RETURN    ${response}

    ELSE IF   "${method}" == "${POST}"
        ${response}    POST On Session    create_session    ${path_url}   headers=${headers}    params=${query}    json=${data}
        RETURN    ${response}
        
    ELSE IF     "${method}" == "${DELETE}"
        ${response}    DELETE On Session    create_session    ${path_url}   headers=${headers}    params=${query}    json=${data}
        RETURN    ${response}       

    ELSE IF     "${method}" == "${PUT}"
        ${response}    PUT On Session    create_session    ${path_url}   headers=${headers}    params=${query}      json=${data}
        RETURN    ${response}
    END

Validate Status Code
    [Documentation]    Owner : supasete.1998@gmail.com
    [Arguments]   ${response}  ${expected_status_code}
    ${respones_status_code}    Set Variable    ${response.status_code}
    Should Be Equal As Strings    ${respones_status_code}    ${expected_status_code}

Validate Response Message
    [Documentation]    Owner : supasete.1998@gmail.com
    [Arguments]   ${response}  ${expected_message}
    ${respones_message}    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${respones_message}    ${expected_message}

Prepare User Detail Expected
    [Documentation]    Owner : supasete.1998@gmail.com
    [Arguments]  ${response_name}=  ${reponse_job}=  ${reponse_id}=${none}  ${response_createdAt}=
    ${exp_user_detail_1}     Create Dictionary    name=${response_name}    job=${reponse_job}  id=${reponse_id}  createdAt=${response_createdAt}
    Set Suite Variable      ${exp_user_detail_1}

Prepare User Detail After Edit Expected
    [Documentation]    Owner : supasete.1998@gmail.com
    [Arguments]  ${response_name}=  ${reponse_job}=  ${response_updatedAt}=
    ${exp_user_detail_1}     Create Dictionary    name=${response_name}    job=${reponse_job}  updatedAt=${response_updatedAt}
    Set Suite Variable      ${exp_user_detail_1}

Prepare User Detail After Get Expected
    [Documentation]    Owner : supasete.1998@gmail.com
    ${response_payload}  Load Json From File  ${CURDIR}/../../resources/reqres/schema/get_user_exp.json
    Set Test Variable  ${response_payload}

Create User     
    [Documentation]    Owner : supasete.1998@gmail.com
    ${create_user}  Load Json From File  ${CURDIR}/../../resources/reqres/schema/create_user.json 
    ${response}    Call API    https://reqres.in   post    /api/users     data=${create_user}
    Set Test Variable  ${response}
    Set Test Variable  ${response_id}  ${response.json()['id']}
    Set Test Variable  ${response_createdAt}  ${response.json()['createdAt']}

Edit User
    [Documentation]    Owner : supasete.1998@gmail.com
    ${edit_user}  Load Json From File  ${CURDIR}/../../resources/reqres/schema/edit_user.json            
    ${response}    Call API    https://reqres.in   put    /api/users/2     data=${edit_user}
    Set Test Variable  ${response}
    Set Test Variable  ${response_updatedAt}  ${response.json()['updatedAt']}

Delete User      
    [Documentation]    Owner : supasete.1998@gmail.com          
    ${response}    Call API    https://reqres.in   delete    /api/users/2
    Set Test Variable  ${response}

Single User
    [Documentation]    Owner : supasete.1998@gmail.com
    ${response}    Call API    https://reqres.in    get    /api/users/2
    Set Test Variable  ${response}