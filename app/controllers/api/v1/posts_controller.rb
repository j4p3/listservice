module Api
  module V1
    class PostsController < ApplicationController
      include TokenAuthentication
      include Rails.application.routes.url_helpers

      def index
        @posts = Post.all.paginate(page: params[:page])
        render json: {
          prev_page: api_v1_posts_path(params: {page: @posts.previous_page}),
          current_page: api_v1_posts_path(params: {page: @posts.current_page}),
          next_page: api_v1_posts_path(params: {page: @posts.next_page}),
          pages: @posts.total_pages,
          count: @posts.total_entries,
          entries: @posts
        }
      end

      def show
        @post = Post.find(params[:id])
        render json: @post
      end

      def create
        unless filter
          head :unauthorized
        else
          @post = Post.create(post_params)
          render json: @post, status: :created
        end
      end
      
    private

      def post_params
        params.require(:post).permit(:author, :subject, :body)
      end
    end
  end
end
