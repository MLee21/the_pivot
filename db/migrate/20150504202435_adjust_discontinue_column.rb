class AdjustDiscontinueColumn < ActiveRecord::Migration
  def change
    remove_column :items, :discontinue
    add_column :items, :discontinue, :boolean, default: false
  end
end
