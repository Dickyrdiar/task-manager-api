class Api::V1::DirectMessagesController < ApplicationController
    before_action :authorize_request, only: [:index, :show, :create]

    def index
        if current_user == @conversation.sender || current_user == @conversation.recipient
            @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
            @direct_message = @conversation.direct_mesagges.order("created_at DESC")
        else 
            render json: { message: 'you dont have access' } 
        end 
    end 

    def create
        @direct_message = @conversation.direct_messages.new(direct_message_params.merge(user_id: current_user))
        @direct_messages = @conversation.direct_messages.order("created_at DESC")
        # @direct_message.user = User.find(params[:user_id])
        
        if @direct_message.save
            ActionCable.server.broadcast "room_channel", content: @direct_message.body
            rendr :show, status: :created 
        end 
    end 

    def set_conversation
        @conversation = Conversation.find(params[:conversation_id]) 
    end 

    def direct_message_params
        params.require(:direct_message).permit(:body, :user_id) 
    end 
end
