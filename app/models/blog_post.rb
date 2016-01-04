class BlogPost < ActiveRecord::Base
  validates :title, :content, :permalink, presence: true
  before_validation :process

  attr_accessor :slug

  default_scope { order(created_at: :asc) }

  def to_param
    permalink
  end

  private

  def process
    unless self.slug.nil?
      self.permalink = (self.created_at.presence || Time.now).strftime('%Y/%m/') + (title || '').downcase.gsub(/[^A-Z]+/i,'-').sub(/\-$/,'')
    end
    self.tags = self.tags.split(',').map(&:trim) if self.tags.is_a?(String)
  end
end
