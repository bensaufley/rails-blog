class Admin::BlogPostsController < AdminController
  before_action :set_blog_post, only: [:edit, :update, :destroy]

  # Get /admin/posts(/:page)
  # Get /admin/posts.json
  def index
    @blog_posts = BlogPost
    if params[:tag].present?
      @blog_posts = @blog_posts.where('? = ANY (tags)', params[:tag])
      @search = "Tag: #{params[:tag]}"
    elsif params[:type].present? && params[:type].in?(BlogPost::POST_TYPES)
      @blog_posts = @blog_posts.where(post_type: params[:type])
      @search = "Type: #{params[:type].titleize}"
    end
    @blog_posts = @blog_posts.paginate(page: params[:page], per_page: 25)
  end

  # GET /admin/posts/new
  def new
    @blog_post = BlogPost.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @blog_post = BlogPost.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/posts/1
  # PATCH/PUT /admin/posts/1.json
  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.json
  def destroy
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_url, notice: 'Blog post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog_post
    @blog_post = BlogPost.find_by(permalink: params[:permalink])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :tags, :permalink)
  end
end
