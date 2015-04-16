class PostsController < ApplicationController
  def index
    @filterrific = initialize_filterrific(Post, params[:filterrific], {
      select_options: {
        mode: Post.options_for_mode,
        span: Post.options_for_span
      }
    }) or return
    if params[:filterrific]
      @posts = Post.friendly.filterrific_find(@filterrific).paginate(page: params[:page])
    else
      @posts = Post.all.paginate(page: params[:page])
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
    @post = Post.friendly.find(params[:id])
    render 'posts/show'
  end

  private

    def filterrific_params
      params.require(:filterrific).permit(:search, :mode, :span)
    end
end
