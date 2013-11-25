#Invoice Print Configurations
#Spree::Config[:admin_interface_logo]

module Spree
  class InvoiceGeneratorConfiguration < Preferences::Configuration
    preference :print_invoice_logo_path, :string, :default => Spree::Config[:admin_interface_logo]
    preference :print_buttons, :string, :default => 'Invoice' 
  end
end
