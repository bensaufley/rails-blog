Rails.application.routes.draw do

  get '/posts(/:page)', to: 'blog_posts#index', constraints: { page: /\d*/ }, as: :posts

  scope :admin, module: :admin do
    resources :blog_posts, path: :posts, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  root to: 'blog_posts#index'

  get '/*permalink', to: 'blog_posts#show', constraints: { permalink: /\d{4}\/\d{2}\/.+/ }
end
