class Address < ActiveRecord::Base
	belongs_to :addressable, :polymorphic => true
	# validates :postcode, :numericality => true, :length => { :minimum => 4 }

	def to_s
		attributes.inspect
	end

	def to_html
		%{
			<div class='address'>
				<p class='line1'>#{line1}</p>
				<p class='line2'>#{line2}</p>
				<p class='city'>#{city}</p>
				<p class='state'>#{state}</p>
				<p class='postcode'>#{postcode}</p>
			</div>
		}
	end
end
