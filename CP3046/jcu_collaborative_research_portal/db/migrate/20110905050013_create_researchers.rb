class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.string :name
      t.string :jc_number
      t.string :title
      t.boolean :moderator
      t.string :email
      t.string :slug

      t.timestamps
    end
  end
end
