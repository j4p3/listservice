class PostsController < ApplicationController
  def index
    @filterrific = initialize_filterrific(Post, params[:filterrific], {
      select_options: {
        mode: Post.options_for_mode,
        span: Post.options_for_span
      }
    }) or return
    if params[:filterrific]
      @posts = Post.filterrific_find(@filterrific)
    else
      @posts = Post.all
    end
    render 'posts/index'
  end

  def show
    @filterrific = initialize_filterrific(Post, params[:filterrific], {
      select_options: {
        mode: Post.options_for_mode,
        span: Post.options_for_span
      }
    }) or return
    @post = Post.find(params[:id])
    render 'posts/show'
  end

  private

    def filterrific_params
      params.require(:filterrific).permit(:search, :mode, :span)
    end
end
