#Added Bulk Generation Button in Admin Reports.
  Deface::Override.new(:virtual_path => "spree/admin/reports/index",
                       :name => 'printbuttons',
                       :insert_after => "[data-hook='reports_header']",
                       :partial => "spree/admin/orders/print_buttons1"
                       )

#Added Print Invoice to Order show page in Admin.
  Deface::Override.new(:virtual_path  => "spree/layouts/admin",
                       :insert_after => "[data-hook='toolbar']",
                       :partial => "spree/admin/orders/print_buttons",
                       :name => "Invoices"
                       )


#Added Invoice for Users Account.
  Deface::Override.new(:virtual_path => %q{spree/orders/show},
                       :insert_before => "div#order",
                       :name => "invoiceprint",
                       :partial => "spree/admin/orders/print_buttons2"
                      )


#Adding  Language to Spree Admin User Form
   Deface::Override.new(:virtual_path => 'spree/admin/users/_form',
                       :insert_after => "[data-hook='admin_user_form_fields']",
                       :name => 'language',
                       :text => ' <p>
                                      <%= f.label :language, Spree.t(:language) %><br>
                                      <%= f.select :language, [:fr, :nl, :de,:en], {:include_blank => false} %>
                                  </p>'
                        )


##Adding Language to Admin/Users/Show  at Admin interface

  Deface::Override.new(:virtual_path => "spree/admin/users/show",
                       :insert_after => "[data-hook='email']",
                       :name => "languageshowpage",
                       :text => " <td style='text-align:center'> <b> <%= Spree.t('Language') %>:</b></td>
                                  <td> <%= @user.language %> </td>"
                       )

#  Adding Language to Users show page at User Interface.
 Deface::Override.new(:virtual_path => "spree/users/show",
                      :name => "add_language_to_account_summary",
                      :original => '1b7abb3395f278fbd9b8a60ac80519845dd707c9',
                       :insert_after => "dl#user-info",
                      :text =>  "<h3> <b> <%= Spree.t('Language') %>:
                                 <%= @user.language %>  </b> </h3><hr> "
                      )

