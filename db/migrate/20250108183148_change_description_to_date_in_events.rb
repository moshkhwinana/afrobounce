class ChangeDescriptionToDateInEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :description, :text
    add_column :events, :date, :text
  end
end
