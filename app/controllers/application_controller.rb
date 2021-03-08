class ApplicationController < ActionController::API
    def not_found
        render json: { error: 'not_found' }
    end 

    def authenticate_user!
        header = request.headers['Authorization']
        header = header.split(' ').last if header 
        
        begin
            @decode = Tiddle.decode(header)
            @current_user = User.find(@decode[:user_id])
        rescue ActiveRecord::RecordNotFound => e  
            render json: { errors: e.message }, status: :unauthorized
        rescue Tiddle::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized   
        end
    end
end
