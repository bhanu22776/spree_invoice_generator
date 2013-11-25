class AddLanguageToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :language, :string
  end
end
