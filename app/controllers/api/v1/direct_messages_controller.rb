class Api::V1::DirectMessagesController < ApplicationController
    before_action :authorize_request, except: [:index, :show, :create]
    # before_action :find_conversation!
    # before_action :set_direct_message, only: [:create, :destroy]

    def index 
        @direct_messages = DirectMessage.where("author_id = ? OR receiver_id = ?", current_user.id, current_user.id)
        @users = User.where.not(id: current_user.id)
    end 

    def new 
    end 

    def create
        @direct_message = @conversation.direct_messages.new(direct_message_params.merge(:user_id => current_user))
        request.remote_ip

        if @direct_message.save
            ActionCable.server.broadcast "room_channel", { conversation_id: @conversation.id }
            render :show, status: :created 
        else 
            render json: @direct_message.errors, status: :unproccessable_entity
        end 
       
    end 

    def destroy 
        @direct_message.destroy 

        render json: { respond: 'direct message destroy' }
    end 

    private

    def set_direct_message
        @direct_message = DirectMessage.find(params[:id]) 
        authorize @direct_message
    end 

    def direct_message_params
        params.require(:direct_message).permit(:body) 
    end 

    # def find_conversation!
    #    @conversation = Conversation.find(params[:conversation_id])
    # end 
end
