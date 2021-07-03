class Api::V1::ConversationsController < ApplicationController
    before_action :authorize_request, except: [:index, :create]
   
    def index
        @conversations = Conversation.where("author_id = ? OR receiver_id = ?", current_user.id, current_user.id)
        @users = User.where.not(id: current_user.id) 
    end 

    def create
        if Conversation.betwen(params[:author_id], params[:receiver_id]).present? 
            @conversation = Conversation.between(params[:author_id], params[:receiver_id]).first
        else
            @conversation.create!(conversation_params) 
        end 
        render :show, status: :ok
    end 

    private  

    def conversation_params
        params.permit(:author_id, :receiver_id)
    end 
end 