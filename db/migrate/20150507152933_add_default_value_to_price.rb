class AddDefaultValueToPrice < ActiveRecord::Migration
  def change
    change_column :items, :price, :integer, default: 1
  end
end
