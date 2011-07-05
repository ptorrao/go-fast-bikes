class PagesController < ApplicationController

  def home
    @title = "Home"
    @random_products = Product.all(:order => 'RANDOM()', :limit => 4)
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end
end
