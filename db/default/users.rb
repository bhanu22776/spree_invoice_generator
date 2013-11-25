
require 'highline/import'

# see last line where we create an admin if there is none, asking for email , password ,language.

def prompt_for_admin_password
  if ENV['ADMIN_PASSWORD']
    password = ENV['ADMIN_PASSWORD'].dup
    say "Admin Password #{password}"
  else
    password = ask('Password [kirana123]: ') do |q|
      q.echo = false
      q.validate = /^(|.{5,40})$/
      q.responses[:not_valid] = 'Invalid password. Must be at least 5 characters long.'
      q.whitespace = :strip
    end
    password = 'kirana123' if password.blank?
  end

  password
end

def prompt_for_admin_email
  if ENV['ADMIN_EMAIL']
    email = ENV['ADMIN_EMAIL'].dup
    say "Admin User #{email}"
  else
    email = ask('Email [admin@kirana.com]: ') do |q|
      q.echo = true
      q.whitespace = :strip
    end
    email = 'admin@kirana.com' if email.blank?
  end

  email
end

def prompt_for_admin_user_language
  if ENV['ADMIN_LANGUAGE']
    language = ENV['ADMIN_LANGUAGE'].dup
    say "Admin LANGUAGE #{language}"
  else
    language = ask('Language [en]: ') do |q|
      q.echo = true
      q.whitespace = :strip
    end
    language = 'en' if language.blank?
  end

  language
end

def create_admin_user
  if ENV['AUTO_ACCEPT']
    password = 'kirana123'
    email = 'admin@kirana.com'
    language = 'en'
  else
    puts 'Create the KIRANA Admin User (press enter for defaults).'
    #name = prompt_for_admin_name unless name
    email = prompt_for_admin_email
    password = prompt_for_admin_password
    puts 'For English :  en , French - fr , Destuch -de (Enter langague code as mention)'
    language =  prompt_for_admin_user_language
  end
  attributes = {
      :password => password,
      :password_confirmation => password,
      :language=> language,
      :email => email,
      :login => email
  }

  load 'spree/user.rb'

  if Spree::User.find_by_email(email)
    say "\nWARNING: There is already a user with the email: #{email}, so no account changes were made. If you wish to create an additional admin user, please run rake spree_auth:admin:create again with a different email.\n\n"
  else
    admin = Spree::User.new(attributes)
    if admin.save
      role = Spree::Role.find_or_create_by_name 'admin'
      admin.spree_roles << role
      admin.save
      say "Done!"
    else
      say "There was some problems with persisting new admin user:"
      admin.errors.full_messages.each do |error|
        say error
      end
    end
  end
end

if Spree::User.admin.empty?
  create_admin_user
else
  puts 'kirana Admin user has already been previously created.'
  if agree('Would you like to create a new KIRANA admin user? (yes/no)')
    create_admin_user
  else
    puts 'No kirana admin user created.'
  end
end