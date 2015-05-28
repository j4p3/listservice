module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all.paginate(page: params[:page])
        render json: @posts
      end

      def show
        @post = Post.find(params[:id])
        render json: @post
      end

      def create
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
