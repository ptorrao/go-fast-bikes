class AddBrandModelWeightAndUnitsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :brand, :string
    add_column :products, :model, :string
    add_column :products, :weight, :float
    add_column :products, :units, :integer
  end

  def self.down
    remove_column :products, :units
    remove_column :products, :weight
    remove_column :products, :model
    remove_column :products, :brand
  end
end
