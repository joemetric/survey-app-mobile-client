class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :path
      t.timestamps
    end

    add_column :answers, :picture_id, :integer
  end

  def self.down
    drop_table :pictures
    remove_column :answers, :picture_id
  end
end
