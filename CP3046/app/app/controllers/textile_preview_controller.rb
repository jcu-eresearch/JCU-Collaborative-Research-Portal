class TextilePreviewController < ApplicationController
	def preview
		@text = ( RedCloth.new(params[:previewtext]).to_html )
		render :partial => "preview"
	end
end
