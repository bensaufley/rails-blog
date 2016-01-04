Rails.application.routes.draw do

  get '/posts/:page', to: 'blog_posts#index', page: /\d*/, as: :posts
  get '/posts', to: redirect('/')

  scope :admin, module: :admin do
    resources :blog_posts, path: :posts, only: [ :index, :new, :create ]
  end

  get '/*permalink/edit', to: 'admin/blog_posts#edit', permalink: /\d{4}\/\d{2}\/.+/, as: :edit_blog_post
  get '/*permalink', to: 'blog_posts#show', permalink: /\d{4}\/\d{2}\/.+/, as: :blog_post
  match '/*permalink', to: 'admin/blog_posts#update', via: [ :put, :patch ], permalink: /\d{4}\/\d{2}\/.+/
  delete '/*permalink', to: 'admin/blog_posts#destroy', permalink: /\d{4}\/\d{2}\/.+/

  root to: 'blog_posts#index'
end
