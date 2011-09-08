# Handles API previews of Markdown content (used by live updating forms)
class MarkdownsController < ApplicationController

  # POST /markdown/preview
  #
  # API Page
  #
  # Takes a param, :text, and converts it from markdown into html
  # Renders only the html version of the markdown content (:text)
  def preview
    @text = ( BlueCloth.new(params[:text]).to_html )
    render :partial => "preview_markdown_output", :locals => {:text => @text}
  end
end
