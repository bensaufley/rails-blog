require 'open-uri'

namespace :blog do
  desc 'Import Wordpress-formatted blog export XML file'
  task import: :environment do
    blog_export = File.open(File.join(Rails.root, 'db', 'files', 'blog-export.xml'))
    puts "Read XML (#{blog_export.size} bytes)"
    blog_xml = Nokogiri::XML(blog_export.read)
    # ["attachment", "feedback", "page", "post", "nav_menu_item"]
    tags = blog_xml.xpath('rss/channel/wp:tag/wp:tag_name').map(&:content)
    posts = blog_xml.xpath('rss/channel/item[wp:post_type="post"][wp:status="publish"]')

    puts "Importing #{posts.size} blog posts (#{tags.size} tags)..."

    posts.each do |post|
      post_date = Time.parse(post.xpath('wp:post_date').text)
      blog_post = BlogPost.find_or_initialize_by(permalink: "#{post_date.strftime('%Y/%m')}/#{post.xpath('wp:post_name').text}")
      blog_post.title = post.xpath('title').text
      blog_post.content = post.xpath('content:encoded').text
      blog_post.tags = post.xpath('category[@domain="post_tag"]').map(&:text)
      if blog_post.save
        blog_post.update_attribute(:created_at, post_date)
        puts "Added #{blog_post.title}"
      else
        puts "Could not add #{blog_post.title}: #{blog_post.errors.messages}"
      end
    end
  end

end
