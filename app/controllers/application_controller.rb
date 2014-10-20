class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # http://apidock.com/rails/ActionController/Helpers/ClassMethods/helper_method
  helper_method :loggedin_cat

  def loggedin_cat
    loggedin_cat_id = session[:loggedin_cat_id]
    if loggedin_cat_id
      Cat.find(loggedin_cat_id)
    end
  end

  # http://apidock.com/ruby/Module/alias_method
  alias_method :current_user, :loggedin_cat
end
