class AddTimestampsToOrders < ActiveRecord::Migration
  def change
    change_table(:orders) { |t| t.timestamps }
  end
end
