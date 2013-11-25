### ADDED AT BOTTOM
#Added Invoice for Users Account.
  Deface::Override.new(:virtual_path => %q{spree/orders/show},
                       :insert_before => "[data-hook='links']",
                       :name => "invoiceprint1213",
                       :partial => "spree/admin/orders/print_buttons2"
                      )


#  Deface::Override.new(:virtual_path => 'spree/checkout/summary',
#                        :replace => "data-hook='checkout_summary_box'",
#                        :name => "invoiceprint1213qwqw",
#                        :text => 'spree/admin/orders/print_buttons2'
#                       )

# #Adding  Language to Spree Admin User Form
#    Deface::Override.new(:virtual_path => 'spree/checkout/summary',
#                        :replace => "div#checkout-summary",
#                        :name => 'languageasdasd',
#                        :text =>  '<h1>HI</h1>'
#                         )


# Deface::Override.new(:virtual_path => "spree/checkout/summary", 
#                      :name => "example-1", 
#                      :replace => "div#checkout-summary-box", 
#                      :text => "<h1>New Post</h1>")