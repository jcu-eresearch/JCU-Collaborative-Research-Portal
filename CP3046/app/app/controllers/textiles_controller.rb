class TextilesController < ApplicationController
  def preview
    @text = ( RedCloth.new(params[:text] || '').to_html )
    render :partial => "preview_textile_output", :locals => {:text => @text}
  end
end
