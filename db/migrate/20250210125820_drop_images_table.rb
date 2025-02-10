class DropImagesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :images
  end
end
