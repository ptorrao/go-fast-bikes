require 'spec_helper'

describe OrdersController do
  render_views
  
  describe "access control" do
    
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = { :notes => "" }
      end
      
      it "should not create an order" do
        lambda do
          post :create, :order => @attr
        end.should_not change(Order, :count)
      end
      
      it "should render the home page" do
        post :create, :order => @attr
        response.should render_template('pages/home')
      end      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :notes => "Lorem ipsum" }
      end
      
      it "should create an order" do
        lambda do
          post :create, :order => @attr
        end.should change(Order, :count).by(1)
      end
      
      it "should redirect to the home page" do
        post :create, :order => @attr
        response.should redirect_to(root_path)
      end
      
      it "should have a flash message" do
        post :create, :order => @attr
        flash[:success].should =~ /order created/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @order = Factory(:order, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @order
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @order = Factory(:order, :user => @user)
      end

      it "should destroy the order" do
        lambda do 
          delete :destroy, :id => @order
        end.should change(Order, :count).by(-1)
      end
    end
  end
end