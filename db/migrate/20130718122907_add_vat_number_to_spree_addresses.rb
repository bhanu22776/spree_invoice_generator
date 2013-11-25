class AddVatNumberToSpreeAddresses < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :vat_number, :string
  end
end
