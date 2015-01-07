class FoodsController < ApplicationController
	before_action :login_check
	skip_before_action :login_check, :only => [:posts, :posts_category, :show]
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
		@post=Post.find(params[:id])
		@comment_writer= User.where(id: session[:user_id])[0]
  end

  def write
  end

  def write_complete
		post=Post.new
		post.user_id=session[:user_id]
		post.category=params[:post_category]
		post.title=params[:post_title]
		post.content= params[:post_content]
		post.image=params[:image]
		if post.save
			flash[:alert]= "Saved successfully."
			redirect_to "/foods/show/#{post.id}"
		else
			flash[:alert] = post.errors.values.flatten.join(' ')
			redirect_to :back
		end
  end

  def edit
		@post=Post.find(params[:id])
		if @post.user_id != session[:user_id]
			flash[:alert]="Unauthorized."
			redirect_to :back
		end
  end

  def edit_complete
		post=Post.find(params[:id])
		post.category=params[:post_category]
		post.title=params[:post_title]
		post.content=params[:post_content]
		if post.save
			flash[:alert] = "Edited successfully."
			redirect_to "/foods/show/#{post.id}"
		else
			flash[:alert]= post.errors.values.flatten.join(' ')
			redirct_to :back
		end
  end

  def delete_complete
		post=Post.find(params[:id])
		if post.user_id == session[:user_id]
			post.destroy
			flash[:alert] = "Deleted successfully."
			redirect_to "/"
		else
			flash[:alert] = "Unauthorized."
			redirect_to :back
		end
  end
	
	def write_comment_complete
		comment = Comment.new
		comment.user_id= session[:user_id]
		comment.post_id= params[:post_id]
		comment.content= params[:comment_content]
		comment.save
		
		flash[:alert]="Added new comment."
		redirect_to "/foods/show/#{comment.post_id}"
	end

	def delete_comment_complete
		comment=Comment.find(params[:id])
		if comment.user_id == session[:user_id]
			comment.destroy
			flash[:alert] = "Comment deleted."
			redirect_to "/foods/show/#{comment.post_id}"
		else
			flash[:alert]= "Unauthorized."
			redirect_to :back
		end
	end
end
