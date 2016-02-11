# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_160_110_194_355) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'attachments', force: :cascade do |t|
    t.string   'title'
    t.text     'description'
    t.string   'type'
    t.datetime 'created_at',        null: false
    t.datetime 'updated_at',        null: false
    t.string   'file_file_name'
    t.string   'file_content_type'
    t.integer  'file_file_size'
    t.datetime 'file_updated_at'
  end

  create_table 'blog_posts', force: :cascade do |t|
    t.string   'title'
    t.text     'content'
    t.string   'tags', array: true
    t.string   'permalink'
    t.string   'post_type'
    t.json     'info'
    t.datetime 'publish_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'blog_posts', ['created_at'], name: 'index_blog_posts_on_created_at', using: :btree
  add_index 'blog_posts', ['permalink'], name: 'index_blog_posts_on_permalink', unique: true, using: :btree
  add_index 'blog_posts', ['tags'], name: 'index_blog_posts_on_tags', using: :gin
end
