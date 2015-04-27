class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.references :item, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
    end
  end
end
