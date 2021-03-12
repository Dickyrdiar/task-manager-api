class Api::V1::MessagesController < ApplicationController
    before_action :authorize_request, except: [:create, :destroy]
    
    def create 
        @message = projects.messages.build(message_params)

        if @message.save 
            render json: {
                message: 'message send', 
                is_message: true, 
                data: { message: @message }
            }, status: :ok
        else 
            render json: {
                message: 'message dont send', 
                is_message: false, 
                data: {}
            }, status: :failed 
        end 
    end 


    def destroy 
    end 
end
