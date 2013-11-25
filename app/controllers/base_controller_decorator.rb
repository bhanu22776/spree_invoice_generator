Spree::BaseController.class_eval do
  before_filter :set_locale

  def set_locale
    if spree_current_user && session[:locale] != params[:locale]
      session[:locale] = spree_current_user.language if spree_current_user.language
    end
    session[:locale] = params[:locale] if params[:locale]
  end

end