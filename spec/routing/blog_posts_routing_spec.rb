require 'rails_helper'

RSpec.describe BlogPostsController, type: :routing do
  describe 'routing' do

    it 'root returns #index' do
      expect(get: '/').to route_to('blog_posts#index')
    end

    it 'routes to #show' do
      expect(get: '/2016/01/test-post').to route_to('blog_posts#show', permalink: '2016/01/test-post')
    end

  end
end
