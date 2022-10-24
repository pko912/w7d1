class UsersController < ApplicationController

    def new
        render :new
    end

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    def edit
        @user = User.find_by(id: params[:id])
        render :edit
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.update!(user_params)
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.destroy
    end

    private

    def user_params
        params.require(:user).permit(:username,:password_digest, :session_token)
    end

end
