class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.references :user, index: true, foreign_key: true
      t.references :status, index: true, foreign_key: true
    end
  end
end
