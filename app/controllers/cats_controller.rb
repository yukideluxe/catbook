class CatsController < ApplicationController
  # http://api.rubyonrails.org/classes/ActiveSupport/Rescuable/ClassMethods.html
  rescue_from Pundit::NotAuthorizedError, with: :deny_access

  include Pundit

  before_action :load_cat_of_the_month, only: :index
  before_action :load_cat, except: :index

  def index
    page  = params[:page].to_i || 1

    # page scope is provided by kamikari gem
    # https://github.com/amatsuda/kaminari/blob/master/lib/kaminari/models/active_record_model_extension.rb#L13
    @cats = policy_scope(Cat).order("id ASC").page(page)
  end

  def show
    authorize @cat
  end

  def edit
    authorize @cat
  end

  def update
    authorize @cat

    if @cat.update(cats_params)
      # http://guides.rubyonrails.org/action_controller_overview.html#the-flash
      flash[:notice] = "Cat updated successfully"

      redirect_to cat_path(@cat)
    else
      flash[:error]  = "Ops! We couldn't update the cat, please review the errors"

      render :edit
    end
  end

  private

  def load_cat
    @cat = Cat.find(params[:id])
  end

  def cats_params
    params.require(:cat).permit(:name, :birthday, :visible)
  end

  # Do you think this is a good place to put this logic?
  # Where would you move it?
  def load_cat_of_the_month
    last_month_follower_relation = FollowerRelation.where("EXTRACT(MONTH FROM created_at) = ? AND EXTRACT(YEAR FROM created_at) = ?", 1.month.ago.month, 1.month.ago.year)

    current_time       = Time.now
    date_of_expiration = current_time.end_of_month - current_time

    # You could also use Rails.cache.read and Rails.cache.write! Review the documentation :)

    @cat_of_the_month = Rails.cache.fetch("cat_of_the_month", expires_in: date_of_expiration) do
      # First alternative
      # Retrieve results from database without order and use ruby function to order hash
      count_of_followers = last_month_follower_relation.group(:followed_cat_id).count
      # http://www.rubyinside.com/how-to/ruby-sort-hash
      cat_of_the_month_data = count_of_followers.sort_by { |k, v| -v }.first

      Cat.find(cat_of_the_month_data.first) if cat_of_the_month_data
    end

    # # Second alternative
    # # Order the results with SQL query an retrieve one result
    # # I just googled "Order by group by count" to find this solution
    # cat_of_month_id = last_month_follower_relation.
    #   group(:followed_cat_id).
    #   select("followed_cat_id, COUNT(*) as followers_count").
    #   order("followers_count DESC").
    #   limit(1).first.try(:followed_cat_id)
    #
    # # http://apidock.com/rails/Object/try
    #
    # @cat_of_the_month = Cat.find(cat_of_month_id) if cat_of_month_id
  end

  def deny_access
    # http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
    # http://apidock.com/rails/ActionController/Base/render#254-List-of-status-codes-and-their-symbols
    render text: "Your are not authorized to perform this action", status: :unauthorized
  end
end
