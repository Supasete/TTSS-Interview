*** Variables ***
# Login Page
${txtUsername}                                       data-test=username
${txtPassword}                                       data-test=password
${btnLogin}                                          data-test=login-button

# Products Page
${lblProductSauceLabsBackpack}                       xpath=//*[@data-test="inventory-item"][1]/div[2]/div[1]/a/div
${lblProduct}                                        xpath=//*[@data-test="inventory-item"]
${btnShoppingCart}                                   data-test=shopping-cart-link

# Product Detail Page
${lblProductnamedetailpage}                          xpath=//*[@class="inventory_details_name large_size"]
${btnAddtocartdetailpage}                            xpath=//*[@data-test="add-to-cart"]
${btnBackToProducts}                                 xpath=//*[@data-test="back-to-products"]

# Cart Page
${lblTitleCartPage}                                  data-test=title
${lblProductNameCartPage}                            xpath=//*[@data-test="inventory-item"]/div[2]/a/div
${btnCheckout}                                       data-test=checkout

# Checkout : Personal Information Page
${lblTitleCheckoutPage}                              data-test=title
${lblFirstName}                                      data-test=firstName
${lblLastName}                                       data-test=lastName
${lblPostalCode}                                     data-test=postalCode
${btnContinue}                                       data-test=continue

# Checkout : Overview Page
${lblItemTotal}                                      xpath=//*[@id="checkout_summary_container"]/div/div[2]/div[6]
${lblTax}                                            xpath=//*[@id="checkout_summary_container"]/div/div[2]/div[7]
${lblTotal}                                          xpath=//*[@id="checkout_summary_container"]/div/div[2]/div[8]
${btnFinish}                                         data-test=finish

# Order Complete Page
${lblOrderComplete}                                  xpath=//*[@id="checkout_complete_container"]/h2
