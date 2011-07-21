class CartController < ApplicationController

  def new
    logger.info 'cart redirecting to cart_items...'
    logger.info 'product id: ' + params[:product_id]

    redirect_to :controller => 'cart_items', :action => 'new', :product_id => params[:product_id]
  end

  def show
    @title = 'The Cart'
  end

end
