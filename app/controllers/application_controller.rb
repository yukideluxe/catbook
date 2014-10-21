class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
end
