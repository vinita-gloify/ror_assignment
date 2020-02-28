class UsersController < ApplicationController
    before_filter :check_if_admin

    def index
        @users = User.where(role: :author)
    end
      
    def new
      @user = User.new
    end 
   
    def create
        @user = User.new(user_params)
        temp_password = SecureRandom.hex  #SecureRandom is a library which generate the random hexa decimal 
        @user.password = temp_password
        @user.password_confirmation = temp_password
        if @user.save
            UserMailer.welcome_author(@user,temp_password).deliver_now
           redirect_to @user
        else
           render 'new'
        end 
    end
   
    def show
       @user = User.find(params[:id])
    end 
      
    def edit
       @user = User.find(params[:id])
    end 
   
    def update
        @user = User.find(params[:id])
        if @user.update(params[:user].permit(:name, :date_of_birth, :email, roles: []))
           redirect_to @user
        else
           render 'edit'
        end   
    end 
   
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path
    end    
   
    private
   
    def user_params
        params.require(:user).permit(:name, :date_of_birth, :email, roles: [])
    end 
    
    def check_if_admin
        if signed_in?
          redirect_to root_path unless current_user.role == 'admin'
        else
          redirect_to root_path
        end
    end

end
