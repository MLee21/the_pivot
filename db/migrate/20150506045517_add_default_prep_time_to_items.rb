class AddDefaultPrepTimeToItems < ActiveRecord::Migration
  def change
    add_column :items, :prep_time, :integer, default: 12
  end
end
