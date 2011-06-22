class Order < ActiveRecord::Base
  attr_accessible :notes
  
  belongs_to :user
  
  validates :notes,   :presence => true, :length => { :maximum => 1024 }
  validates :user_id, :presence => true
  
  default_scope :order => 'orders.created_at DESC'
end
