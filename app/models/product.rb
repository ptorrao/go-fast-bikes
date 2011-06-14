# == Schema Information
# Schema version: 20110614114050
#
# Table name: products
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Product < ActiveRecord::Base
  belongs_to :user
  
  validates :description, :length => { :maximum => 1024 }
end
