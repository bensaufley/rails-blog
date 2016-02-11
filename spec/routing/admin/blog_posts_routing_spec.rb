require 'rails_helper'

RSpec.describe Admin::BlogPostsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/posts').to route_to('admin/blog_posts#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/posts/new').to route_to('admin/blog_posts#new')
    end

    it 'routes to #create' do
      expect(post: '/admin/posts').to route_to('admin/blog_posts#create')
    end

    describe 'existing post' do
      let(:blog_post) { FactoryGirl.create(:blog_post) }

      it 'routes to #edit' do
        expect(get: "/#{blog_post.permalink}/edit")
          .to route_to('admin/blog_posts#edit', permalink: blog_post.permalink)
      end

      it 'routes to #update via PUT' do
        expect(put: "/#{blog_post.permalink}")
          .to route_to('admin/blog_posts#update', permalink: blog_post.permalink)
      end

      it 'routes to #update via PATCH' do
        expect(patch: "/#{blog_post.permalink}")
          .to route_to('admin/blog_posts#update', permalink: blog_post.permalink)
      end

      it 'routes to #destroy' do
        expect(delete: "/#{blog_post.permalink}")
          .to route_to('admin/blog_posts#destroy', permalink: blog_post.permalink)
      end
    end
  end
end
