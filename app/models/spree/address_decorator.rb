Spree::Address.class_eval do
  attr_accessible  :vat_number
  #validates :vat_number, presence: true
end