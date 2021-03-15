class Api::V1::MessagesController < ApplicationController
    def create
        @message = Message.new(message_params)
        @message.user = current_user 
        
        if @message.save 
            render json: {
                data: { message: @message }
            }, status: :ok
        else
            render json: {
                message: "message can't send",
                data: { }
            }, status: :failed
        end  
    end 
end
