class CategoriesController < ApplicationController
  before_filter :is_admin
  before_filter :authorized_user, :only => [:destroy]

  def index
    @title = "All Root Categories"
    @categories = Category.all(:order => "name")
  end
  
  def new
    @category = Category.new
    @title = "New Category"
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      flash[:success] = "Category created!"
      redirect_to categories_path
    else
      flash[:failure] = "Couldn't create the category..."
      render :action => 'new'
    end  
  end
  
  def show
    @category = Category.find(params[:id])
    @title = @category.name
  end

  def edit
    @category = Category.find(params[:id])
    @title = "Edit Category"
  end

  def update
    @category = Category.find(params[:id])
    
    if @category.update_attributes(params[:category])
      flash[:success] = "Category updated."
      redirect_to @category
    else
      @title = "Edit Category"
      render 'edit'
    end
  end  

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

    def is_admin
      if signed_in?
        if current_user.admin?
          logger.debug "BEFORE FILTER|ADMIN: OK"
        else
          redirect_to root_path
        end
      else
        redirect_to signin_path
      end
    end

    def authorized_user
      @category = Category.find(params[:id])
      redirect_to categories_path if @category.nil?
    end
end
