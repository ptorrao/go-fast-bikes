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
  attr_accessible :name, :description

  belongs_to :user

  validates :name,        :presence => true, :length => { :maximum => 128 }
  validates :description, :presence => true, :length => { :maximum => 1024 }
  validates :user_id,     :presence => true
  
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
