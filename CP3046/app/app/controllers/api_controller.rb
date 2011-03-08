class ApiController < ApplicationController
	def preview_textile
		@text = ( RedCloth.new(params[:text]).to_html )
		render :partial => "preview_textile_output"
	end
end
