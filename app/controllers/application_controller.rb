class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # http://guides.rubyonrails.org/i18n.html
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
  end

  # http://apidock.com/rails/ActionController/Helpers/ClassMethods/helper_method
  helper_method :current_cat

  def current_cat
    current_cat_id = session[:current_cat_id]
    if current_cat_id
      @current_cat ||= Cat.find(current_cat_id)
    end
  end

  # http://apidock.com/ruby/Module/alias_method
  alias_method :current_user, :current_cat

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first)
  end
end
