# Handles API previews of Textile content (used by live updating forms)
class TextilesController < ApplicationController
  # POST /textile/preview
  #
  # API Page
  #
  # Takes a param, :text, and converts it from textile into html
  # Renders only the html version of the textile content (:text)
  def preview
    @text = ( RedCloth.new(params[:text] || '').to_html )
    render :partial => "preview_textile_output", :locals => {:text => @text}
  end
end
