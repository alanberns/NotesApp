class Api::AuthenticationController < ApplicationController
    before_action :authenticate_user, except: :login

    # POST /api/login
    def login
      @user = User.find_by_username(params[:username])
      if @user&.authenticate(params[:password])
        token = JwtToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       username: @user.username }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
        def login_params
            params.permit(:username, :password)
        end
end