class PostsController < ApplicationController
  def index
    @posts = Post.all
    render 'posts/index'
  end

  def show
    @post = Post.find(id: post_params[:id])
    render 'posts/show'
  end

  private

    def post_params
      params.require(:post).permit(:id)
    end
end
