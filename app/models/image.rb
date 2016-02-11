class Image < Attachment
  has_attached_file :file, styles: {
    thumb: '150x150#',
    small: '150x150>'
  }

  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
