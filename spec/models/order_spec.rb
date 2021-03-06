require 'spec_helper'

describe Order do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :notes => "value for notes" }
  end
  
  it "should create a new instance given valid attributes" do
    @user.orders.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @order = @user.orders.create(@attr)
    end
    
    it "should have a user attribute" do
      @order.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @order.user_id.should == @user.id
      @order.user.should == @user
    end
  end
  
  describe "validations" do
    
    it "should require a user id" do
      Order.new(@attr).should_not be_valid
    end
    
    it "should require nonblank notes" do
      @user.orders.build(:notes => "   ").should_not be_valid
    end
    
    it "should reject long notes" do
      @user.orders.build(:notes => "a" * 1025).should_not be_valid
    end
  end
end
