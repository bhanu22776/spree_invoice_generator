Spree::User.class_eval do
    attr_accessible  :language

#Validation for Language
    validates :language, presence: true

end