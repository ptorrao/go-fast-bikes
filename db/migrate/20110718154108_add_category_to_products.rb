class AddCategoryToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :category_id, :integer, :default => 0
  end

  def self.down
    remove_column :products, :category_id
  end
end
