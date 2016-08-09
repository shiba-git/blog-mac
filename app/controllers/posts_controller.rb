class PostsController < ApplicationController
 before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]


	def new 
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
    	if @post.save
    		flash[:success] = "投稿が完了しました。"
      		redirect_to post_path(@post)
    	else
      	render 'new'
    	end
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			flash[:success] = "編集が完了しました。"
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to user_path(current_user)
	end


	private

	   def post_params
	      params.require(:post).permit(:title, :description, :picture)
	   end

	   def logged_in_user
    		unless logged_in?
      		store_location
      		flash[:danger] = "ログインしてください"
      		redirect_to login_url
       end
  end
end
