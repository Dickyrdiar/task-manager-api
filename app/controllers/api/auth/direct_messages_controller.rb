class Api::Auth::DirectMessagesController < ApplicationController
    def index
        @direct_messages = DirectMessage.where(user_id: current_user)
    end 

    def show 
        @direct_message = DirectMessage.find(params[:id])
    end 

    def create 
        @user = User.find(params[:user_id])
        @direct_message = @user.direct_messages.create(direct_messages_params.merge(user_id: current_user))
    
        if @direct_message.save
            ActionCable.server.broadcast "room_channel", content: @direct_message.text 
            render :show, status: :created
        else 
            render json: @direct_message.errors, status: :unproccessable_entity
        end 
    end 

    def destroy 
        @direct_message = DirectMessage.find(params[:direct_messages_id])
        @direct_message.destroy 

        render json: {direct_message: 'messages has destroy'}, status: :ok 
    end 

    private 

    def set_dirrect_messages
        @direct_message = DirectMessage.find(params[:id])
    end 

    def direct_messages_params
        params.require(:direct_message).permit(:user_id, :text, :image)
    end 
end
