*** Settings ***
Resource  ../../configuration/saucedemo/globalconfig/allresource.resource

*** Keywords ***
Login Saucedemo
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for login to saucedemo with username and password
    ...               ${username} : Input username from saucedemo such as standard_user, locked_out_user, problem_user, performance_glitch_user, error_user and visual_user
    ...               ${password} : Input password from saucedemo such as secret_sauce
    [Arguments]    ${username}    ${password}
    Wait For Elements State  ${txtUsername}  visible
    Fill Text  ${txtUsername}  ${username}
    Wait For Elements State  ${txtPassword}  visible
    Fill Text  ${txtPassword}  ${password}
    Click Element  ${btnLogin}
    Wait For Elements State  ${lblProductSauceLabsBackpack}  visible

Select Add Product From List To Cart
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for select product that contain T-Shirt, Backpack and Flashlight in product name and click add to cart
    ${index}  Get Element Count  ${lblProduct}
    ${add_product}  Create List
    FOR  ${i}  IN RANGE  ${index}
        ${i}  Evaluate  ${i}+1
        Click Element  //*[@data-test="inventory-item"][${i}]/div[2]/div[1]/a/div
        ${product_name}  Get Text  ${lblProductnamedetailpage}
        ${product_list}  Get File  ${CURDIR}/../../configuration/saucedemo/localconfig/selectedProduct.txt
        ${product_list}  Split To Lines  ${product_list}
        ${found_selected_product}  Run Keyword And Return Status  List Should Contain Value  ${product_list}  ${product_name}
        IF  ${found_selected_product} == ${True} 
            Click Element  ${btnAddtocartdetailpage}
            Append To List  ${add_product}  ${product_name}
            Click Element  ${btnBackToProducts}
        ELSE
            Click Element  ${btnBackToProducts}
        END
    END
    Set Test Variable  ${ADD_PRODUCT}  ${add_product}

Go To Shopping Cart Page
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for go to shopping cart page and verify title
    Click Element  ${btnShoppingcart}
    Wait For Elements State  ${lblTitlecartpage}  visible
    ${checkout_title}  Get Text  ${lblTitlecartpage}
    Should Be Equal  ${checkout_title}  Your Cart

Verify Product In Cart Equal Selected Product
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for verify product in cart equal selected product by amount of product and product name
    ${count_product_in_cart}    Get Element Count  ${lblProductNameCartPage}
    ${added_product}  Create List
    FOR    ${i}    IN RANGE    ${count_product_in_cart}
        ${i}  Evaluate  ${i}+1
        ${product}  Get Text  //*[@data-test="inventory-item"][${i}]/div[2]/a/div
        Append To List  ${added_product}  ${product}
    END
    ${count_added_product}  Get Length  ${added_product}
    ${count_add_product}  Get Length  ${ADD_PRODUCT}
    ${equal_status}  Run Keyword And Return Status  Should Be Equal  ${count_added_product}  ${count_add_product}
    Run keyword if  ${equal_status} == ${False}  Fail  Product In Cart Not Equal Selected Product
    FOR  ${i}  IN RANGE  ${count_added_product}
        ${product_correct}  Run Keyword And Return Status  Should Be Equal  ${added_product}[${i}]  ${ADD_PRODUCT}[${i}]
        Run Keyword If  ${product_correct} == ${False}  Fail  Product In Cart Not Correct As Selected Product
    END
    Set Test Variable  ${ADDED_PRODUCT}  ${added_product}

Remove Selected Product From Shopping Cart
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for remove selected product from shopping cart by product name contain selected name
    ${index}  Get Element Count  ${lblProductNameCartPage}
    ${i}  Set Variable  0
    WHILE  ${i} < ${index}
        ${current_index}  Evaluate  ${i}+1
        ${product_name}  Get Text  //*[@data-test="inventory-item"][${current_index}]/div[2]/a/div
        ${remove_product_list}  Get File  ${CURDIR}/../../configuration/saucedemo/localconfig/removeProduct.txt
        ${remove_product_list}  Split To Lines  ${remove_product_list}
        ${found_selected_product}  Run Keyword And Return Status  List Should Contain Value  ${remove_product_list}  ${product_name}
        IF  ${found_selected_product}
            Click Element    //*[@data-test="inventory-item"][${current_index}]/div[2]/div[2]/button
            Remove Item By Value  ${ADDED_PRODUCT}  ${product_name}
            ${index}  Evaluate  ${index}-1
            ${i}  Set Variable  0 
        ELSE
            ${i}  Evaluate  ${i}+1
        END
    END

Verify Product In Shopping Cart After Remove Selected Product
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for verify product in cart equal selected product by product name
    ${count_product_after_remove}  Get Element Count  ${lblProductNameCartPage}
    ${index}  Set Variable  0
    FOR  ${i}  IN RANGE  ${count_product_after_remove}
        ${i}  Evaluate  ${i}+1
        ${remain_product}  Get Text  //*[@data-test="inventory-item"][${i}]/div[2]/a/div
        Should Be Equal  ${ADDED_PRODUCT}[${index}]  ${remain_product}
        ${index}  Evaluate  ${index}+1
    END

Go To Checkout Page
    [Documentation]   Owner: supasete.1998@gmail.com
    Click Element  ${btnCheckout}
    Wait For Elements State  ${lblTitleCheckoutPage}  visible
    ${checkout_title}  Get Text  ${lblTitleCheckoutPage}
    Should Be Equal  ${checkout_title}  Checkout: Your Information

Fill Personal Information And Click Continue
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               ${first_name} : Input first name
    ...               ${last_name} : Input last name
    ...               ${postal_code} : Input postal code
    [Arguments]    ${first_name}  ${last_name}  ${postal_code}
    Input Text  ${lblFirstName}  ${first_name}
    Input Text  ${lblLastName}  ${last_name}
    Input Text  ${lblPostalCode}  ${postal_code}
    Click Element  ${btnContinue}

Verify Product And Product Price In Checkout Page
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for verify product and product price in checkout page by amount of product and product price
    ${index}  Get Length  ${ADDED_PRODUCT}
    ${product_no}  Set Variable  0
    ${amount_product_price}  Set Variable  0.0
    FOR    ${i}    IN RANGE    ${index}
        ${i}    Evaluate    ${i} + 1
        ${product_name}  Get Text  //*[@data-test="inventory-item"][${i}]/div[2]/a/div
        ${product_price}  Get Text  //*[@data-test="inventory-item"][${i}]/div[2]/div[2]/div
        ${product_price_decimal}    Evaluate    float(${product_price.replace('$', '')})
        ${amount_product_price}  Evaluate  ${amount_product_price} + ${product_price_decimal}
        Should Be Equal    ${ADDED_PRODUCT}[${product_no}]  ${product_name}  
        ${product_no}    Evaluate    ${product_no} + 1
    END
    Set Test Variable  ${AMOUNT_PRODUCT_PRICE}  ${amount_product_price}

Verify Price Total In Checkout Page
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for verify product total price, tax and total price in checkout page
    # Item Total
    ${actual_product_price}  Get Text  ${lblItemTotal}
    ${actual_product_price}    Evaluate    float(${actual_product_price.replace('Item total: $', '')})
    Should Be Equal  ${actual_product_price}  ${AMOUNT_PRODUCT_PRICE}
    # Tax
    ${tax_amount}  Evaluate  ${AMOUNT_PRODUCT_PRICE} * 8/100
    ${tax_amount_decimal}    Evaluate  float("%.2f" % ${tax_amount})
    ${actual_tax}  Get Text  ${lblTax}
    ${actual_tax}  Evaluate  float(${actual_tax.replace('Tax: $', '')})
    Should Be Equal  ${actual_tax}  ${tax_amount_decimal}
    # Total
    ${total_price}  Evaluate  ${AMOUNT_PRODUCT_PRICE} + ${tax_amount}
    ${total_price_decimal}  Evaluate  float("%.2f" % ${total_price})
    ${actual_total}  Get Text  ${lblTotal}
    ${actual_total_decimal}  Evaluate  float(${actual_total.replace('Total: $', '')})
    Should Be Equal  ${actual_total_decimal}  ${total_price_decimal}

Finish Order
    [Documentation]   Owner: supasete.1998@gmail.com
    Click Element  ${btnFinish}

Verify Order Complete Page
    [Documentation]   Owner: supasete.1998@gmail.com
    ...               Keyword for verify order complete page
    Wait For Elements State  ${lblOrderComplete}  visible
    ${complete_order_text}  Get Text  ${lblOrderComplete}
    Should Be Equal  ${complete_order_text}  Thank you for your order!

Remove Item By Value
    [Documentation]   Owner: supasete.1998@gmail.com
    [Arguments]  ${list}  ${value}
    ${index}  Evaluate  ${list}.index("${value}")
    Remove From List  ${list}  ${index}

Click Element
    [Documentation]   Owner: supasete.1998@gmail.com
    [Arguments]    ${selector}
    Wait For Elements State  ${selector}  visible
    Click  ${selector}

Input Text
    [Documentation]   Owner: supasete.1998@gmail.com
    [Arguments]    ${selector}  ${text}
    Wait For Elements State  ${selector}  visible
    Fill Text  ${selector}  ${text}