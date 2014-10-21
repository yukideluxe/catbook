class SessionsController < ApplicationController
  def new
  end

  def create
    # Check if user with email exists
    cat = Cat.find_by_email(params[:email])
    if cat &&cat.authenticate(params[:password])
      # Password is correct
      # Set the session to current cat
      # Will use cookie
      session[:cat_id] = cat.id

      redirect_to root_url
    else
      # There's no cat or the password is incorrect
      render :new
    end
  end

  def destroy
    session[:cat_id] = nil
    redirect_to :back
  end
end
