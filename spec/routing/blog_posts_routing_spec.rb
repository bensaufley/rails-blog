require 'rails_helper'

RSpec.describe BlogPostsController, type: :routing do
  describe 'routing' do

    it 'root returns #index' do
      expect(get: '/').to route_to('blog_posts#index')
    end

    it 'routes to page 2 of posts' do
      expect(get: '/posts/2').to route_to('blog_posts#index', page: '2')
    end

    it 'routes to tags index' do
      expect(get: '/tag/test-tag').to route_to('blog_posts#index', tag: 'test-tag')
    end

    it 'routes to types index' do
      expect(get: '/type/link').to route_to('blog_posts#index', type: 'link')
    end

    it 'routes to #show' do
      expect(get: '/2016/01/test-post').to route_to('blog_posts#show', permalink: '2016/01/test-post')
    end

  end
end
