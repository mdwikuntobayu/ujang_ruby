class UsersController < ApplicationController
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
end
