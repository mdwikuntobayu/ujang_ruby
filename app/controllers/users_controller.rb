class UsersController < ApplicationController
	before_filter :authenticate,  :only => [:edit, :update]
	before_filter :correct_user, :only => [:edit, :update]

  def new
  	@title = "Sign Up"
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		redirect_to user_path(@user), :flash =>{:success => "helo Thank for join"}
  	else
  		@title = "Sign Up"
  		render 'new'
  	end
  end
  
  def show
  	@user = User.find(params[:id])
  	@title = @user.name
  end
  
  def edit
  	@user = User.find(params[:id])
  	@title = "Edit User"
  end
  
  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
  		redirect_to user_path(@user), :flash =>{:success => "Update Success"}
  	else
  		render 'edit'
  	end
  end
  
  private
  
  		def authenticate  
  			deny_access
  		end
  		
  		def correct_user
  			@user = User.find(params[:id])
  			redirect_to(root_path) unless current_user? @user
  		end
end
