class CreateResearchersGroupsJoinTable < ActiveRecord::Migration
	def self.up
		create_table :groups_researchers, :id => false do |t|
			t.integer :researcher_id
			t.integer :group_id
		end
	end

	def self.down
		drop_table :groups_researchers
	end
end
