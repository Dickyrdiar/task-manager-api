class ApplicationController < ActionController::API
    protect_from_forgery with: :exception

    def not_found
        render json: { error: 'not_found' }
    end 

    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header 

        begin 
            @decoded = JWT.decode(header)
            @current_user = User.find(@decode[:user_id])
           
        rescue ActiveRecord::RecordNotFound => e   
            render json: { messages: 'you need login or signup' }, status: :unauthorized
        rescue JWT::DecodeError => e 
            render json: { messages: 'you need login or signup' }, status: :unauthorized
        end
    end 

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end 

    def current_project 
        @current_project ||= current_user.project
    end 
end
