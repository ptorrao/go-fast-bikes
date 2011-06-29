class ProductsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def index
    @title = "All Products"
    @products = Product.paginate(:page => params[:page])
  end

  def create
    @product = current_user.product.build(params[:product])
    if @product.save
      flash[:success] = "Product created!"
      redirect_to root_path
    else
      flash[:failure] = "Couldn't create the product..."
    end  
  end

  def destroy
    @product.destroy
    redirect_back_or root_path
  end
  
  private
  
    def authorized_user
      @product = current_user.products.find_by_id(params[:id])
      redirect_to root_path if @product.nil?
    end
end
