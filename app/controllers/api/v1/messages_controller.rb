class Api::V1::MessagesController < ApplicationController
    before_action :authorize_request, except: [:index, :show, :create, :update, :destroy]

    def index
        @project = Project.find(params[:project_id])
        if params[:search].present? 
            @message = Message.search(params[:search])
        else  
            @message = Message.where(:peoject_id => @project.id)
        end 
    end 
    
    def create
        @project = Project.find(params[:project_id])
        @message = @project.messages.create(message_params.merge(user: current_user))
        p @message.errors.full_messages
        
        if @message.save
            ActionCable.server.broadcast "project_channel", content: @message.text
            render json: @message, status: :ok 
        else  
            render json: { error: 'invalid message' }, status: :failed
        end 
    end 

    def destroy
        @message = Message.find(params[:message_id])
        @message.destroy  
        
        render json: { message: 'message has delete' }, status: :ok
    end 

    private  

    def message_params 
        params.require(:message).permit(:text, :image, :user_id, :sender_id, )
    end 
end
