class BaseController < ActionController::API
    include Pundit

    def admin_request 
        header = request['Authorization']
        header = header.split(' ').last if header 

        begin
            @decode = JWT.decode(header)
            @current_admin = Admin.find(@decode[:admin_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errros: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e  
            render json: { errors: e.message }, status: :unauthorized
        end  
    end 

    def current_admin
        @current_admin ||= Admin.find(session[admin_id]) if session[:admin_id] 
    end 
end 