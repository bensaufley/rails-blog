require 'rails_helper'

RSpec.describe Admin::BlogPostsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # BlogPost. As you add validations to BlogPost, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      title: Faker::Lorem.sentence((4..8).to_a.sample),
      content: Faker::Lorem.paragraphs.join("\n\n"),
      slug: '',
      tags: Faker::Lorem.words((2..6).to_a.sample).join(',')
    }
  end
  let(:invalid_attributes) { { title: '', content: '' } }

  let(:valid_session) { {} }

  before :each do
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'secret') # rubocop:disable Metrics/LineLength
  end

  describe 'GET #new' do
    it 'assigns a new blog_post as @blog_post' do
      get :new, {}, valid_session
      expect(assigns(:blog_post)).to be_a_new(BlogPost)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested blog_post as @blog_post' do
      blog_post = FactoryGirl.create(:blog_post)
      get :edit, { permalink: blog_post.permalink }, valid_session
      expect(assigns(:blog_post)).to eq(blog_post)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new BlogPost' do
        expect do
          post :create, { blog_post: valid_attributes }, valid_session
        end.to change(BlogPost, :count).by(1)
      end

      it 'assigns a newly created blog_post as @blog_post' do
        post :create, { blog_post: valid_attributes }, valid_session
        expect(assigns(:blog_post)).to be_a(BlogPost)
        expect(assigns(:blog_post)).to be_persisted
      end

      it 'redirects to the created blog_post' do
        post :create, { blog_post: valid_attributes }, valid_session
        expect(response).to redirect_to(BlogPost.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved blog_post as @blog_post' do
        post :create, { blog_post: invalid_attributes }, valid_session
        expect(assigns(:blog_post)).to be_a_new(BlogPost)
      end

      it 're-renders the "new" template' do
        post :create, { blog_post: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested blog_post' do
        blog_post = FactoryGirl.create(:blog_post)
        put :update, { permalink: blog_post.permalink, blog_post: new_attributes }, valid_session
        blog_post.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested blog_post as @blog_post' do
        blog_post = FactoryGirl.create(:blog_post)
        put :update, { permalink: blog_post.permalink, blog_post: valid_attributes }, valid_session
        expect(assigns(:blog_post)).to eq(blog_post)
      end

      it 'redirects to the blog_post' do
        blog_post = FactoryGirl.create(:blog_post)
        put :update, { permalink: blog_post.permalink, blog_post: valid_attributes }, valid_session
        expect(response).to redirect_to(blog_post.reload)
      end
    end

    context 'with invalid params' do
      it 'assigns the blog_post as @blog_post' do
        blog_post = FactoryGirl.create(:blog_post)
        put :update, { permalink: blog_post.permalink, blog_post: invalid_attributes }, valid_session
        expect(assigns(:blog_post)).to eq(blog_post)
      end

      it 're-renders the "edit" template' do
        blog_post = FactoryGirl.create(:blog_post)
        put :update, { permalink: blog_post.permalink, blog_post: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested blog_post' do
      blog_post = FactoryGirl.create(:blog_post)
      expect do
        delete :destroy, { permalink: blog_post.permalink }, valid_session
      end.to change(BlogPost, :count).by(-1)
    end

    it 'redirects to the blog_posts list' do
      blog_post = FactoryGirl.create(:blog_post)
      delete :destroy, { permalink: blog_post.permalink }, valid_session
      expect(response).to redirect_to(blog_posts_url)
    end
  end
end
