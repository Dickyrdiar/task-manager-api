class Api::V1::ConversationsController < ApplicationController
    before_action :authorize_request, except: [:index, :create]
    # before_action :set_conversation, except: [:show, :destroy]
   
    def index
        @conversations = Conversation.where("author_id = ? OR receiver_id = ?", current_user.id, current_user.id)
        @users = User.where.not(id: current_user.id) 
    end 

    def show 
    end 

    def create
        if Conversation.betwen(params[:author_id], params[:receiver_id]).present? 
            @conversation = Conversation.between(params[:author_id], params[:receiver_id]).first
            @conversation.author = current_user
            @conversation.group = Group.find(params[:group_id])
        else
            @conversation.create!(conversation_params) 
        end 
        render :show, status: :ok
    end 

    def destroy
        @conversation = Conversation.find(params[:id])
        @conversation.destroy 
        
        render json: { message: 'conversation destroy' }, status: :unprocessable_entity
    end 

    private  

    # def set_conversation 
    #     @conversation = Conversation.find(params[:id])
    #     authorize @conversation
    # end 

    def conversation_params
        params.permit(:author_id, :receiver_id)
    end   
end 