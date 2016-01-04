require 'rails_helper'

RSpec.describe 'blog_posts/index', type: :view do
  before(:each) do
    FactoryGirl.create_list(:blog_post, 10)
    assign(:blog_posts, BlogPost.paginate(page: params[:page], per_page: 5))
  end

  it 'renders a list of blog_posts' do
    render
  end
end
