class RegistrationsController < ApplicationController
	def new
    @cat = Cat.new
	end

	def create
		@cat = Cat.new(cat_params)
		if @cat.save # will check password confirmation
				session[:cat_id] = @cat.id
				CatMailer.welcome_email(@cat).deliver
				redirect_to root_url
		else
		# There's been an error
		render :new
		end
	end
  
	def show
		@cat = Cat.find_by(params[:id])
	end

	def update
		@cat = Cat.find(params[:id])
		if @cat.update(cat_params)
			redirect_to root_path
		else
			render :edit
		end
	end


  private
  def cat_params
    params.require(:cat).permit(
          :email, :password, :password_confirmation, :name, :birthday)
  end
end
