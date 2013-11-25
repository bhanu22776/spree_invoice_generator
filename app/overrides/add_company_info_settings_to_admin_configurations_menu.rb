#Adding company information configuration in Admin Configuration Tabs.

Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                                                             :name => "add_company_information_admin_option",
                                                             :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                                                             :text => "<%= configurations_sidebar_menu_item Spree.t('company.company_settings'), edit_admin_company_settings_path %>",
                                                             :disabled => false)

#Adding company information configuration in Admin Configuration Tabs.
#Adding company information configuration in Admin Configuration Tabs.

