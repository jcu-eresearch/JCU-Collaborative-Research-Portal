class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :researcher
  validates :post, :presence => true
  validates :researcher, :presence => true
  validates :body, :presence => true

  def body_as_html
    BlueCloth.new(body).to_html
  end
end
