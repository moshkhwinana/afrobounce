class ChangeDateColumnTypeInEvents < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :date, :date
  end
end
# easier than removing and adding column to keep date data
