class UsersController < ApplicationController
    skip_before_action :authorization, only: [:new, :create, :index]
    def index 
        @users = User.all
    end 
    
    def show
        @user = User.find(params[:id])
        @gig = Gig.new
        @joke = Joke.new
        # if @joke.valid?
        #     redirect_to user_path(@user)
        # else
        #     flash[:my_errors] = @user.errors.full_messages
        #     redirect_to user_path(@user)
        # end
    end 

    
    def new
        @user = User.new
    end
    
    def create
        @user = User.create(user_params)
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else 
            flash[:my_errors] = @user.errors.full_messages
            redirect_to new_user_path
        end
    end
    
    def edit
        @user = User.find(params[:id])

    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user)
          else
            flash[:my_errors] = @user.errors.full_messages
            redirect_to edit_user_path
        end
        
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :name, :email, :pic, :bio, :age, :password, :hometown)
    end
    
end
