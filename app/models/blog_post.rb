class BlogPost < ActiveRecord::Base
  POST_TYPES = %w(post link image)

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
    self.publish_at ||= Time.current
    if self.permalink.blank? && self.title.present?
      self.permalink = self.publish_at.strftime('%Y/%m/') + self.title[0,50].downcase.gsub(/[^A-Z]+/i,'-').sub(/\-$/,'')
    end
    self.tags = self.tags.split(',').map(&:trim) if self.tags.is_a?(String)
  end
end
