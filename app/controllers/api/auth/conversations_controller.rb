class ConversationsController <  ApplicationController
    def create 
        @conversation = Conversation.get(current_user.id params[:user_id])
        add_to_conversation unlless conversated? 

        render :show, status: :ok 
    end 

    def close 
        @conversation = Conversation.find(params[:id])
        session[:conversation].delete(@conversation.id)

        render json: {message: 'converstion closed'}
    end 

    private

    def add_to_conversation
        session[:conversation] ||=[]
        session[:conversation] << @conversation.id
    end 

    def conversated?
        session[:conversation].include?(@conversation.id)
    end 
end 