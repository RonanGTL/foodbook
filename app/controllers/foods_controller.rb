class FoodsController < ApplicationController
  def posts
		@posts= Post.all
  end

  def posts_category
		case params[:category]
		when "asian"
			@category= "Asian"
		when "american"
			@category= "American"
		when "european"
			@category ="European"
		else
			@category = "International"
		end
		@posts=Post.where(category: @category)
  end

  def show
  end

  def write
  end

  def write_complete
  end

  def edit
  end

  def edit_complete
  end

  def delete_complete
  end
end
