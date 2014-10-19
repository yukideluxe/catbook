class CatsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :load_cat, except: :index

  def index
    page  = params[:page].to_i || 1

    # page scope is provided by kamikari gem
    # https://github.com/amatsuda/kaminari/blob/master/lib/kaminari/models/active_record_model_extension.rb#L13
    @cats = Cat.visible.page(page)
  end

  def show
  end

  def edit
  end

  def update
    if @cat.update(cats_params)
      flash[:notice] = "Cat updated successfully"

      redirect_to cat_path(@cat)
    else
      flash[:error]  = "Ops! We couldn't update the cat, please review the errors"

      render :edit
    end
  end

  private

  def load_cat
    @cat = Cat.where("id = #{params[:id]}").visible.first

    render text: 'Not Found', status: '404' unless @cat
  end

  def cats_params
    { visible: true }.merge(params[:cat])
  end
end
