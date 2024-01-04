class Api::UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  # POST /user/
  def create
    @user = User.new()
    params.permit(:username, :password)
    @user.username = params[:username]
    @user.password = params[:password]

    if @user.save
      render json: @user.to_json( :only => [:username] ), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /user/
  def show
    render json: @current_user.to_json( :only => [:username] ), status: 200 
  end

  # PATCH/PUT /user/
  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user/
  def destroy
    @current_user.destroy!
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
