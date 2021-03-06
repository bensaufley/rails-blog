class BlogPostsController < ApplicationController
  # GET /
  # GET /posts(/:page)
  # GET /posts(/:page).json
  def index
    @blog_posts = BlogPost
    filter_by_tag
    filter_by_type
    @blog_posts = @blog_posts.paginate(page: params[:page], per_page: 5)
  end

  # GET /*permalink - YYYY/MM/title-slug
  def show
    @blog_post = BlogPost.find_by(permalink: params[:permalink])
    raise(ActionController::RoutingError, 'Not Found') unless @blog_post.present?
    @blog_post = @blog_post.decorate
  end

  private

  def filter_by_tag
    @blog_posts = @blog_posts.where('? = ANY (tags)', params[:tag]) if params[:tag].present?
  end

  def filter_by_type
    if params[:type].present? && params[:type].in?(BlogPost::POST_TYPES)
      @blog_posts = @blog_posts.where(post_type: params[:type])
    end
  end
end
