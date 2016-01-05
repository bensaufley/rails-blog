require 'rails_helper'

RSpec.describe 'blog_posts/show', type: :view do
  before(:each) do
    @blog_post = assign(:blog_post, FactoryGirl.create(:blog_post).decorate)
  end

  it 'renders attributes in <p>' do
    render
  end
end
