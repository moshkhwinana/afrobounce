class RemoveQuicketLinkFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :quicket_link, :string
  end
end
