class OrdersController < ApplicationController
  before_filter :authenticate, :only => [:index, :create, :destroy]
  before_filter :authorized_user, :only => [:index, :destroy]

  def index
    @title = "All Orders"
    @orders = @user.orders.paginate(:page => params[:page])
  end
  
  def create
    @order = current_user.orders.build(params[:order])
    if @order.save
      flash[:success] = "Order created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @order.destroy
    redirect_back_or root_path
  end
  
  private
  
    def authorized_user
      @order = current_user.orders.find_by_id(params[:id])
      redirect_to root_path if @order.nil?
    end
end