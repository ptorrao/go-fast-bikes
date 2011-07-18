class ProductsController < ApplicationController
  before_filter :is_admin,        :except => [:index, :show]
  before_filter :authorized_user, :only => [:destroy]
  
  def index
    @title = "All Products"
    @products = Product.paginate(:page => params[:page])
  end

  def new
    @product = Product.new
    @title = "New Product"
  end

  def create
    @product = current_user.products.build(params[:product])

    if @product.save
      flash[:success] = "Product created!"
      redirect_to @product
    else
      flash[:failure] = "Couldn't create the product..."
      render :action => "new"
    end  
  end

  def show
    @product = Product.find(params[:id])
    @title = @product.name
  end

  def edit
    @product = Product.find(params[:id])
    @title = "Edit Product"
  end

  def update
    @product = Product.find(params[:id])
    
    if @product.update_attributes(params[:product])
      flash[:success] = "Product updated."
      redirect_to @product
    else
      @title = "Edit Product"
      render 'edit'
    end
  end  

  def destroy
    @product.destroy
    redirect_back_or products_path
  end
  
  def update_units
    @product = Product.find(params[:id])
#    @product.update_attributes(:units, :units + params[:units])
  end

  private

    def is_admin
      if signed_in?
#        logger.debug "BEFORE FILTER|SIGNED IN: OK"

        if current_user.admin?
          logger.debug "BEFORE FILTER|ADMIN: OK"
        else
#          logger.debug "BEFORE FILTER|ADMIN: NOK!"
          redirect_to root_path
        end
      else
#        logger.debug "BEFORE FILTER|SIGNED IN: NOK!"
        redirect_to signin_path
      end
    end
  
    def authorized_user
      @product = current_user.products.find_by_id(params[:id])
      redirect_to root_path if @product.nil?
    end
end
