class UsersController < ApplicationController
  def new
  	@title = "Sign Up"
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to user_path(@user), {:success => "helo Thank for join"}
  	else
  		@title = "Sign Up"
  		render 'new'
  	end
  end
  
  def show
  	@user = User.find(params[:id])
  	@title = @user.name
  end
end
