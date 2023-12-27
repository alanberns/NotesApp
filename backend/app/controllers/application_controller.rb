class ApplicationController < ActionController::API

    before_action :authenticate_user

    private
        def authenticate_user
            header = request.headers['Authtorization']
            header = header.split(' ').last if header
            begin
                @decoded = JwtToken.decode(header)
                @current_user = User.find(@decoded[:user_id])
            rescue ActiveRecord::RecordNotFound => e
                render json: {errors: e.message }, status: :unauthorized
            rescue JWT::DecodeError => e
                render json: { errors: e.message }, status: :unauthorized
            end
        end
end
