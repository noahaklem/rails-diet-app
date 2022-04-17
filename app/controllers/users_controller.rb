class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
          redirect_to @user
        else
          render 'edit'
        end
      end

    def index
        @users = User.all
    end

    def create
       user_params[:pro] = Pro.find_by_id(params[:pro])
        @user = User.new(user_params)
     if @user.save!
         session[:user_id] = @user.id
         redirect_to user_path(@user)
        else
        render :new
        end
    end

    def show
        redirect_if_not_logged_in
        @user = User.find_by_id(params[:id])
       if !@user 
          redirect_to '/'
       end
    end
    
      private
    
      def user_params
        params.require(:user).permit(:name, :email, :password_digest, :age, :weight, :gender, :health, :diet_type, :restrictions, allergens_attributes: [:id, :ingredients])
      end
end
