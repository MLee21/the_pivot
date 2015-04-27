class ChangeColumnEmail < ActiveRecord::Migration
  def change
    remove_column :users, :email_address
    add_column :users, :email, :string
  end
end
