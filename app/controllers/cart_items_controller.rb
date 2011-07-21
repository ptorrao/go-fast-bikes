class CartItemsController < ApplicationController

  def new
    logger.info 'adding cart item: ' + params[:product_id]

    flash[:success] = 'Product ' + params[:product_id] +  ' added to cart!'

    redirect_back_or root_path
  end
end
