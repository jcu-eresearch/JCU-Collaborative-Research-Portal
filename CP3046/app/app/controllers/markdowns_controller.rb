class MarkdownsController < ApplicationController
  def preview
    @text = ( BlueCloth.new(params[:text]).to_html )
    render :partial => "preview_markdown_output", :locals => {:text => @text}
  end
end
