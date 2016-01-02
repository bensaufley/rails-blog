class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.string :tags, array: true
      t.string :slug

      t.timestamps null: false
    end

    add_index :blog_posts, :slug
    add_index :blog_posts, :created_at
    add_index :blog_posts, :tags, using: 'gin'
  end
end
