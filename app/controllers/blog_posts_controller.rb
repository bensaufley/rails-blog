class BlogPostsController < ApplicationController
  # GET /
  # GET /posts(/:page)
  # GET /posts(/:page).json
  def index
    @blog_posts = BlogPost
    @blog_posts = @blog_posts.where('? = ANY (tags)', params[:tag]) if params[:tag].present?
    @blog_posts = @blog_posts.paginate(page: params[:page], per_page: 5)
  end

  # GET /*permalink - YYYY/MM/slug
  def show
    @blog_post = BlogPost.find_by(permalink: params[:permalink]).decorate
    raise ActionController::RoutingError.new('Not Found') unless @blog_post.present?
  end
end
