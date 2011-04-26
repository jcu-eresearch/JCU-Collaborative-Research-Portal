class HomesController < ApplicationController
	skip_before_filter :login_required

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
