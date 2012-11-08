class UsersController < ApplicationController
  def new
  	@title = "New"
  end
  
  def show
  	@user = User.find(1)
  end
end
