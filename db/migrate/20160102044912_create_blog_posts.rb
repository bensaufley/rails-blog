class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.string :tags, array: true
      t.string :permalink

      t.timestamps null: false
    end

    add_index :blog_posts, :permalink, unique: true
    add_index :blog_posts, :created_at
    add_index :blog_posts, :tags, using: 'gin'
  end
end
