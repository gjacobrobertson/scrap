require 'spec_helper'

describe UsersController do
render_views

  describe "GET 'index'" do

    describe "as a signed in user" do

      before(:each) do
        @user = Factory(:user)
        session[:user_id] = @user[:id]
      end

      it "should return http success" do
        get :index
        response.should be_successful
      end
    end

    describe "without being signed in" do

      it "should redirect to the signin page" do
        get :index
        response.should redirect_to signin_path
      end
    end
  end

  describe "GET 'show'" do

    describe "as a signed in user" do

      before(:each) do
        @user = Factory(:user)
        session[:user_id] = @user[:id]
      end

      it "should return http success" do
        get :show, :id => @user
        response.should be_successful
      end
    end

    describe "without being signed in" do

      before(:each) do
        @user = Factory(:user)
      end
      
      it "should redirect to the signin page" do
        get :show, :id => @user
        response.should redirect_to signin_path
      end
    end
  end

  describe "GET 'new'" do

    describe "as a signed in user" do

      before(:each) do
        @user = Factory(:user)
        session[:user_id] = @user[:id]
      end

      it "should redirect to the home page" do
        get :new
        response.should redirect_to root_path
      end
    end

    describe "without being signed in" do
      
      it "should return http success" do
        get :new
        response.should be_successful
      end
    end
  end

  describe "POST 'create'" do

    describe "as a signed in user" do

      before(:each) do
        @user = Factory(:user)
        session[:user_id] = @user[:id]
      end

      it "should redirect to the home page" do
        post :create
        response.should redirect_to(root_path)
      end
    end

    describe "without being signed in" do

      describe "failure" do

        before(:each) do
          @attr = { :name => "",
                    :email => "",
                    :password => "",
                    :password_confirmation => ""
          }
        end

        it "should not create a user" do
          lambda do
            post:create, :user => @attr
          end.should_not change(User, :count)
        end

        it "should render the 'new' page" do
          post :create, :user => @attr
          response.should render_template('new')
        end
      end

      describe "success" do
        
        before(:each) do
          @attr = { :name => "New User",
                    :email => "user@example.com",
                    :password => "foobar",
                    :password_confirmation => "foobar"
          }
        end

        it "should create a user" do
          lambda do
            post :create, :user => @attr
          end.should change(User, :count).by(1)
        end

        it "should redirect to the home page" do
          post :create, :user => @attr
          response.should redirect_to root_path
        end
      end
    end
  end

  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as an authorized user" do

      before(:each) do
        session[:user_id] = @user[:id]
      end

      it "should be successful" do
        get :edit, :id => @user
        response.should be_success
      end
    end

    describe "as an unauthorized user" do

      before(:each) do
        @malicious_user = Factory(:user, :email => "malicious@user.com")
        session[:user_id] = @malicious_user[:id]
      end

      it "should redirect to the home page" do
        get :edit, :id => @user
        response.should redirect_to root_path
      end
    end

    describe "without being signed in" do

      it "should redirect to the signin page" do
        get :edit, :id => @user
        response.should redirect_to signin_path
      end
    end
  end

  describe "PUT' update'" do
    
    before(:each) do
      @user = Factory(:user)
      @attr = { :name => "New Name",
                :email => "user@example.org",
                :password => "barbaz",
                :password_confirmation => "barbaz" }
    end

    describe "as an authorized user" do

      before(:each) do
        session[:user_id] = @user[:id]
      end

      describe "failure" do

        before(:each) do
          @attr = { :email => "",
                    :name => "",
                    :password => "",
                    :password_confirmation => "" }
        end

        it "should not update the user's attributes" do
          old_name = @user.name
          old_email = @user.email
          put :update, :id => @user, :user => @attr
          @user.reload
          @user.name.should == old_name
          @user.email.should == old_email
        end

        it "should render the 'edit' page" do
          put :update, :id => @user, :user => @attr
          response.should render_template('edit')
        end
      end

      describe "success" do

        it "should change the user's attributes" do
          put :update, :id => @user, :user => @attr
          @user.reload
          @user.name.should == @attr[:name]
          @user.email.should == @attr[:email]
        end

        it "should redirect to the home page" do
          put :update, :id => @user, :user => @attr
          response.should redirect_to root_path
        end
      end
    end

    describe "as an unauthorized user" do

      before(:each) do
        @malicious_user = Factory(:user, :email => "malicious@user.com")
        session[:user_id] = @malicious_user[:id]
      end

      it "should not update the user's attributes" do
        old_name = @user.name
        old_email = @user.email
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == old_name
        @user.email.should == old_email
      end

      it "should redirect to the home page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to root_path
      end
    end

    describe "without being signed in" do

      it "should not update the user's attributes" do
        old_name = @user.name
        old_email = @user.email
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == old_name
        @user.email.should == old_email
      end

      it "should redirect to the signin page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to signin_path
      end
    end
  end

  describe "DESTROY 'delete'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as an authorized user" do

      before(:each) do
        session[:user_id] = @user[:id]
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the home page" do
        delete :destroy, :id => @user
        response.should redirect_to root_path
      end
    end

    describe "as an unauthorized user" do

      before(:each) do
        @malicious_user = Factory(:user, :email => "malicious@user.com")
        session[:user_id] = @malicious_user[:id]
      end

      it "should not destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should_not change(User, :count)
      end

      it "should redirect to the home page" do
        delete :destroy, :id => @user
        response.should redirect_to root_path 
      end
    end

    describe "without being signed in" do

      it "should not destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should_not change(User, :count)
      end

      it "should redirect to the signin page" do
        delete :destroy, :id => @user
        response.should redirect_to signin_path
      end
    end
  end
end
