class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_cat
    if session[:cat_id]
      @current_cat ||= Cat.find(session[:cat_id])
    end
  end

  helper_method :current_cat
end
