renderer = Redcarpet::Render::HTML.new(
  filter_html: false,
  no_images: false,
  no_links: false,
  no_styles: true,
  escape_html: false,
  safe_links_only: false,
  with_toc_data: true,
  hard_wrap: false,
  xhtml: false,
  prettify: true,
  link_attributes: {}
)

MARKDOWN = Redcarpet::Markdown.new(
  renderer,
  no_intra_emphasis: true,
  fenced_code_blocks: true,
  autolink: true,
  disable_indented_code_blocks: true,
  strikethrough: true,
  lax_spacing: true,
  space_after_headers: false,
  superscript: true,
  underline: false,
  highlight: true,
  quote: false,
  footnotes: true
)
