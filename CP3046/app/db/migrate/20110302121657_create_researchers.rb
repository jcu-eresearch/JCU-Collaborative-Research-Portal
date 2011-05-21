class CreateResearchers < ActiveRecord::Migration
  def self.up
    create_table :researchers do |t|
      t.string :name
      t.string :title
      t.string :email
      t.string :jc_number
      t.boolean :moderator, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :researchers
  end
end
