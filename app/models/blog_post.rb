class BlogPost < ActiveRecord::Base
  validates :title, :content, presence: true
  validate :unique_slug?
  before_save :break_up_tags

  default_scope { order(created_at: :asc) }

  def self.find_by_permalink(permalink)
    parsed = permalink.match(/^(?<ym>\d{4}\/\d{2})\/(?<slug>.+)$/)
    mo = Time.parse(parsed[:ym] + '/01')
    self.where(created_at: (mo..mo.end_of_month)).find_by(slug: parsed[:slug])
  end

  def permalink
    "/#{created_at.strftime('%Y/%m')}/#{slug}"
  end

  def to_param
    "#{created_at.strftime('%Y/%m')}/#{slug}"
  end

  private

  def unique_slug?
    slug = (title || '').downcase.gsub(/[^A-Z]+/i,'-') unless slug.present?
    date = created_at.presence || Time.now
    errors.add(:slug, slug + ' already exists for this month') if BlogPost.where(created_at: (date.beginning_of_month..date.end_of_month), slug: slug)
  end

  def break_up_tags
    tags = tags.split(',').map(&:trim) if tags.is_a?(String)
  end
end
