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
  attr_accessible :name, :description, :price, 
                  :photo1, :photo2, :photo3, :photo4,
                  :brand, :model, :weight, :units,
                  :category_id

  belongs_to :user
  belongs_to :category

  has_many :cart_items
  has_many :carts, :through => :cart_items

  validates :name,        :presence => true, :length => { :maximum => 128 }
  validates :description, :presence => true, :length => { :maximum => 1024 }
  validates :price,       :presence => true
  validates :user_id,     :presence => true
  validates :brand,       :presence => true
  validates :model,       :presence => true
  validates :weight,      :presence => true
  validates :units,       :presence => true
  validates :category_id, :presence => true
  
  validates_numericality_of :price
  validates_numericality_of :weight
  validates_numericality_of :units

  validate :check_price

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

  def check_price
    if price.nil? || price < 0.1
      errors.add(:price, "should be at least 10 cents")
    end
  end
end
