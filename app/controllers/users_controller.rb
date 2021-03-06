class UsersController < ApplicationController
  before_filter :authenticate,    :only => [:index, :show, :edit, :update]
  before_filter :authorized_user, :only => [:show, :edit, :update]
  before_filter :admin_user,      :only => [:index, :destroy]

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def new
    @user = User.new
    @title = "Sign up"
    render :layout => 'login_page'
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to go-fast-bikes.com!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end  
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  private 
  
    def authorized_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
    
    def admin_user
      if signed_in?
        redirect_to(root_path) unless current_user.admin?
      else 
        redirect_to(signin_path)
      end
    end
end
