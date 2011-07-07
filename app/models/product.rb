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
  attr_accessible :name, :description, :photo1, :photo2, :photo3, :photo4

  belongs_to :user

  validates :name,        :presence => true, :length => { :maximum => 128 }
  validates :description, :presence => true, :length => { :maximum => 1024 }
  validates :user_id,     :presence => true
  
  has_attached_file :photo1,
                    :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "20x20" },
                    :url => "/images/:class/:id/:style_:basename.:extension",
                    :default_style => :thumb
  has_attached_file :photo2,
                    :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "20x20" },
                    :url => "/images/:class/:id/:style_:basename.:extension",
                    :default_style => :thumb
  has_attached_file :photo3,
                    :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "20x20" },
                    :url => "/images/:class/:id/:style_:basename.:extension",
                    :default_style => :thumb
  has_attached_file :photo4,
                    :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "20x20" },
                    :url => "/images/:class/:id/:style_:basename.:extension",
                    :default_style => :thumb
end
