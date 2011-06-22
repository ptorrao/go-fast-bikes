class OrdersController < ApplicationController
  before_filter :authenticate
  
  def create
    @order = current_user.orders.build(params[:order])
    if @order.save
      flash[:success] = "Order created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
  end
end