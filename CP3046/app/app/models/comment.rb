# A Comment has a:
# researcher::  The Researcher who made the comment
# post::        The Post the comment was made on
# body::        The contents of the comment (Markdown)
class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :researcher
  validates :post, :presence => true
  validates :researcher, :presence => true
  validates :body, :presence => true

  # Return the body content converted from markdown, to html.
  def body_as_html
    BlueCloth.new(body).to_html
  end
end
