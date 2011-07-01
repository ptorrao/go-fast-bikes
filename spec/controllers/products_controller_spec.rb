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

    describe "for signed-in admin users" do

      before(:each) do
        @admin_user = test_sign_in(Factory(:user, 
                                     :email => "admin@example.com", 
                                     :admin => true))
                              
        @products = []

        100.times do
          @products << Factory(:product,
                               :name => Factory.next(:product_name),
                               :description => Factory.next(:product_description),
                               :user_id => @admin_user)
        end                             
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All Products")
      end
      
     it "should have an element for each product" do
        get :index
        @products[0..29].each do |product|
          response.should have_selector("td", :content => product.name)
       end
     end      
      
      it "should paginate products" do
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/products?page=2",
                                           :content => "2")
        response.should have_selector("a", :href => "/products?page=2",
                                           :content => "Next")
      end
    end
  end  

  describe "GET 'new'" do

    describe "with non-logged-in user" do

      it "should not be successful" do
        get :new
        response.should_not be_success
      end
    end
    
    describe "with non-admin user" do

      before(:each) do
        user = Factory(:user, 
                      :email => "admin@example.com", 
                      :admin => false)
        test_sign_in(user)                  
      end

      it "should not be successful" do
        get :new
        response.should_not be_success
      end
    end
    
    describe "with admin user" do

      before(:each) do
        admin = Factory(:user, 
                        :email => "admin@example.com", 
                        :admin => true)
        test_sign_in(admin)                  
      end
        
      it "should be successful" do
        get :new
        response.should be_success
      end
    
      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "New Product")
      end
    
      it "should have a name field" do
        get :new
        response.should have_selector("input[name='product[name]'][type='text']")
      end

      it "should have an description field" do
        get :new
        response.should have_selector("input[name='product[description]'][type='text']")
      end
    end
  end

  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", 
                  :description => "" }
      end
      
      it "should not create a product" do
        lambda do
          post :create, :product => @attr
        end.should_not change(Product, :count)
      end

      it "should redirect to the sign-in page" do
        post :create, :product => @attr
        response.should redirect_to(signin_path())
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :name => "A new product name...", 
                  :description => "A new product description..." }
                  
        admin = Factory(:user, 
                        :email => "admin@example.com", 
                        :admin => true)
        test_sign_in(admin)                  
      end

      it "should create a product" do
        lambda do
          post :create, :product => @attr
        end.should change(Product, :count).by(1)
      end
      
      it "should redirect to the product show page" do
        post :create, :product => @attr
        response.should redirect_to(product_path(assigns(:product)))
      end
    end    
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @attr = { :name => "A new product name...", 
                :description => "A new product description..." }

      admin = Factory(:user, 
                      :email => "admin@example.com", 
                      :admin => true)
      test_sign_in(admin)
    end
    
    it "should be successful" do
      get :edit, :id => @product
      response.should be_success
    end
  
    it "should have the right title" do
      get :edit, :id => @product
      response.should have_selector("title", :content => "Edit Product")
    end
  end
end