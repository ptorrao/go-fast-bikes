require 'spec_helper'

describe ProductsController do
  render_views

  describe "GET 'index'" do
    
    describe "for non-signed-in users" do
      it "should show random products" do
        get :index
        response.should be_success
      end    

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All Products")
      end
    end
    
    describe "for signed-in non-admin users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should show random products" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All Products")
      end
    end    

#    describe "for signed-in admin users" do

#      before(:each) do
#        @admin_user = test_sign_in(Factory(:user, 
#                                     :email => "admin@example.com", 
#                                     :admin => true))
                              
#        @products = []

#        100.times do
#          @products << Factory(:product,
#                               :nane => Factory.next(:name),
#                               :description => Factory.next(:description))
#        end                             
#      end

#      it "should be successful" do
#        get :index
#        response.should be_success
#      end

#      it "should have the right title" do
#        get :index
#        response.should have_selector("title", :content => "All products")
#      end
      
#     it "should have an element for each product" do
#        get :index
#        @products[0..30].each do |product|
#          response.should have_selector("td", :content => product.name)
#       end
#      end      
      
#      it "should paginate products" do
#        get :index
#        response.should have_selector("div.pagination")
#        response.should have_selector("span.disabled", :content => "Previous")
#        response.should have_selector("a", :href => "/products?page=2",
#                                           :content => "2")
#        response.should have_selector("a", :href => "/productss?page=2",
#                                           :content => "Next")
#      end
#    end
  end  
end