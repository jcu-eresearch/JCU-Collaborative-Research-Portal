class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :slug

      t.integer :researcher_id

      t.timestamps
    end
  end
end