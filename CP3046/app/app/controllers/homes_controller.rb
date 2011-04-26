class HomesController < ApplicationController
	skip_before_filter :login_required
	
	def index 
		respond_to do |format|
			format.html # index.html.erb
		end
	end

	def support
		respond_to do |format|
			format.html # support.html.erb
		end
	end

	def about
		respond_to do |format|
			format.html # about.html.erb
		end
	end

end
