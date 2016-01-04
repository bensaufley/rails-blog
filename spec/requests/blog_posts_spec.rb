require 'rails_helper'

RSpec.describe 'BlogPosts', type: :request do
  describe 'GET /posts' do
    it 'redirects to root' do
      get '/posts'
      expect(response).to redirect_to('/')
    end
  end

  pending 'GET /posts/:page'
end
