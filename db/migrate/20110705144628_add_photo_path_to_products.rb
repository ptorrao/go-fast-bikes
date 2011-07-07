class AddPhotoPathToProducts < ActiveRecord::Migration
  def self.up
      add_column :products, :photo1_file_name,    :string
      add_column :products, :photo1_content_type, :string
      add_column :products, :photo1_file_size,    :integer
      add_column :products, :photo1_updated_at,   :datetime
      add_column :products, :photo2_file_name,    :string
      add_column :products, :photo2_content_type, :string
      add_column :products, :photo2_file_size,    :integer
      add_column :products, :photo2_updated_at,   :datetime
      add_column :products, :photo3_file_name,    :string
      add_column :products, :photo3_content_type, :string
      add_column :products, :photo3_file_size,    :integer
      add_column :products, :photo3_updated_at,   :datetime
      add_column :products, :photo4_file_name,    :string
      add_column :products, :photo4_content_type, :string
      add_column :products, :photo4_file_size,    :integer
      add_column :products, :photo4_updated_at,   :datetime
    end

    def self.down
      remove_column :products, :photo1_file_name
      remove_column :products, :photo1_content_type
      remove_column :products, :photo1_file_size
      remove_column :products, :photo1_updated_at
      remove_column :products, :photo2_file_name
      remove_column :products, :photo2_content_type
      remove_column :products, :photo2_file_size
      remove_column :products, :photo2_updated_at
      remove_column :products, :photo3_file_name
      remove_column :products, :photo3_content_type
      remove_column :products, :photo3_file_size
      remove_column :products, :photo3_updated_at
      remove_column :products, :photo4_file_name
      remove_column :products, :photo4_content_type
      remove_column :products, :photo4_file_size
      remove_column :products, :photo4_updated_at
    end
end
