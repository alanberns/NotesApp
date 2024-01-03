class ApplicationController < ActionController::API

    before_action :authenticate_user

    private
        def authenticate_user
            header_auth = request.headers['Authorization']
            token = header_auth.split(' ').last if header_auth
            begin
                @decoded = JwtToken.decode(token)
                puts @decoded
                @current_user = User.find(@decoded[:user_id])
                puts @current_user
            rescue ActiveRecord::RecordNotFound => e
                render json: {errors: e.message }, status: :unauthorized
            rescue JWT::DecodeError => e
                render json: { errors: e.message }, status: :unauthorized
            end
        end
end
