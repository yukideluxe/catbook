# http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
class LoginController < ApplicationController
  def create
    cat = Cat.where(email: params[:email]).first

    # Session engaged
    if cat && cat.authenticate(params[:password])
      flash[:success] = "Login sucessful! Welcome #{cat.name}!"

      session[:loggedin_cat_id] = cat.id
    else
      flash[:error] = "Login was not sucessful"
    end

    redirect_to cats_path
  end

  def destroy
    session[:loggedin_cat_id] = nil

    respond_to do |format|
      format.js { render js: "window.location.href='#{cats_path}'" }
    end
  end
end
