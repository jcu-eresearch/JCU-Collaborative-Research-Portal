class CreateResearchers < ActiveRecord::Migration
  def self.up
    create_table :researchers do |t|
      t.string :name
      t.string :title
      t.text :address

      t.timestamps
    end
  end

  def self.down
    drop_table :researchers
  end
end
