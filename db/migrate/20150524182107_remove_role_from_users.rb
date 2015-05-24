class RemoveRoleFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :role, :integer
    add_column :users, :type, :string, null: false
  end
end
