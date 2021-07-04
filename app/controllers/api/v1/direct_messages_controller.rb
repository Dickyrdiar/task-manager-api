class Api::V1::DirectMessagesController < ApplicationController
    before_action :authorize_request, except: [:index, :show, :create]
    before_action :find_conversation!
    before_action :set_direct_message, only: [:destroy]

    def index 
        @conversation.direct_messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)
        direct_messages = @conversation.direct_messages.new 
    end 

    def new 
    end 

    def create
        @direct_message = @conversation.direct_messages.new(direct_message_params)
        @direct_message.user = current_user
        
        if @direct_message.save
            ActionCable.server.broadcast "room_channel", { conversation_id: @conversation.id }
            render :show, status: :created 
        end 
    end 

    def destroy 
        @direct_message.destroy 

        render json: { respond: 'direct message destroy' }
    end 

    private

    def set_direct_message
        @direct_message = DirectMessage.find(params[:id]) 
    end 

    def direct_message_params
        params.require(:direct_message).permit(:body) 
    end 

    def find_conversation!
       @conversation = Conversation.find(params[:conversation_id])
    end 
end
