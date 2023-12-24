class AuhtenticationController < ApplicationController
    skip_before_action :authenticate_user
    
    def login
        @user = User.find_by(username: params[:username])
        if  @user&.authenticate(params[:password])
            token = JwtToken.encode(user_id: @user.id)
            time = Time.now + 24.hours.to_i
            render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                            username: @user.username}, status: :ok

        else
            render json: { error: 'Usuario y/o contraseña inválidos'}, status: :unauthorized
        end
    end
end