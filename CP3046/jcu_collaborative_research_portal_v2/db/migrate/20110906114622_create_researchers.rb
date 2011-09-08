class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.string :name
      t.string :jc_number
      t.string :title
      t.boolean :moderator
      t.string :email
      t.string :slug

      t.string :profile_image_file_name
      t.string :profile_image_content_type
      t.integer :profile_image_file_size
      t.datetime :profile_image_updated_at

      t.timestamps
    end
  end
end
