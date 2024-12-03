class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :date
      t.string :webticket_link

      t.timestamps
    end
  end
end
