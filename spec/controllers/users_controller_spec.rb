require 'spec_helper'

describe UsersController do
	
	describe "GET 'show'" do
	
		before(:each) do
			@user = FactoryGirl.create(:user)
		end
		
		it "should be successful" do
			get :show, :id => @user
			response.should be_success
		end
		
		it "should find the right user" do
			get :show, :id => @user
			assigns(:user).should == @user
		end
			
	end
		
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
  
  	describe "failure" do
  		before(:each) do
  			@attr = {:name => "",  :email => "", :password => "", :password_confirmation => ""}
  		end
  		 		
  		it "should render the 'new' page" do
  			post :create, :user => @attr
  			response.should render_template('new')
  		end
  		
  		it "should not create user" do
  			lambda do 
  				post :create, :user => @attr
  			end.should_not change(User, :count)
  		end  	
  	end
  	
  	describe "success" do
  		before(:each) do
  			@attr = {:name => "New User",  :email => "user@email.com", :password => "userpass", :password_confirmation => "userpass"}
  		end
  		
  		it "should create user" do
  			lambda do
  				post :create, :user => @attr
  			end.should change(User, :count).by(1)
  		end
  		
  		it "should redirect to user page" do
  			post :create, :user => @attr
  			response.should redirect_to(user_path(assigns(:user)))
  		end
  	end  
  	
  end
  
  describe "GET 'edit'" do
  	before(:each) do
			@user = FactoryGirl.create(:user)
		end
		
		it "should be successful " do
			get :edit, :id => @user
			response.should be_success
		end
  end
  
    describe "PUT 'update'" do
  		before(:each) do
				@user = FactoryGirl.create(:user)
			end
			
			describe "faillur" do
				before(:each) do
					@attr = {:name => "",  :email => "", :password => "", :password_confirmation => ""}
				end
				
				it "should render the edit page" do
					put :update, :id => @user, :user => @attr
					response.should render_template('edit')
				end	
			end
			
			describe "success" do
				before(:each) do
					@attr = {:name => "New Name",  :email => "new@email.com", :password => "abcdef", :password_confirmation => "abcdef"}
				end
					
				it "should change the user attributes" do
					put :update, :id => @user, :user => @attr
					user = assigns(:user)
					@user.reload
					@user.name.should == user.name
					@user.email.should == user.email
					@user.encrypted_password.should == user.encrypted_password
				end
			end
		end

end
