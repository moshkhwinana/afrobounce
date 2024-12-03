class RemoveWebticketLinkFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :webticket_link, :string
  end
end
