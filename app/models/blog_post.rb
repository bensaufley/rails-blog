class BlogPost < ActiveRecord::Base
  POST_TYPES = %w(post link image).freeze

  validates :title, :content, :permalink, :post_type, :publish_at, presence: true
  validates :permalink, uniqueness: true
  validates :post_type, inclusion: { in: POST_TYPES }
  after_initialize :init
  before_validation :process

  default_scope { where('publish_at <= ?', Time.current).order(publish_at: :desc) }
  scope :unpublished, -> { where('publish_at > ?', Time.current).order(publish_at: :desc) }

  def to_param
    permalink
  end

  def info
    super.deep_symbolize_keys
  end

  private

  def init
    self.post_type ||= 'post'
  end

  def process
    set_publish_at
    set_permalink
    set_tags
  end

  def set_publish_at
    self.publish_at ||= Time.current
  end

  def set_permalink
    return unless permalink.blank? && title.present?
    self.permalink = self.publish_at.strftime('%Y/%m/') + slug
  end

  def set_tags
    self.tags = tags.split(',').map(&:trim) if tags.is_a?(String)
  end

  def slug
    title[0, 50].downcase.gsub(/[^A-Z]+/i, '-').sub(/^\-?(.*)\-?$/, '\1')
  end
end
