class Product < ActiveRecord::Base
  belongs_to :user
  
  validates :description, :length => { :maximum => 1024 }
end
