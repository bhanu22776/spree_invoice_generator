module Spree
  module Admin
    class CompanySettingsController < BaseController
      def update
        Spree::Company::Config.set(params[:preferences])

        respond_to do |format|
          format.html {
            redirect_to edit_admin_company_settings_path
          }
        end
      end
    end
  end
end