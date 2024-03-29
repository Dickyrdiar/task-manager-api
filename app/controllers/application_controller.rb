class ApplicationController < ActionController::API
    include Pundit

    def protect_againts_forgery?
        false 
    end 

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized 

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
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e 
            render json: { errors: e.message }, status: :unauthorized
        end
    end 

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    

    def current_project 
        @current_project ||= Project.find(session[:project_id]) if session[:project_id]
    end 

    def current_group
        @current_group ||= Group.find(session[:group_id]) if session[:group_id] 
    end 

    private 

    # def user_not_authorized
    #     # flash[:alert] = "You are not authorized to perform this action."
    #     redirect_to(request.referrer || root_path)
    # end
end
