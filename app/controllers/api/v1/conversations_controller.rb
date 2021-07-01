class Api::V1::ConversationsController <  ApplicationController
   before_action :authorize_request, only: [:index, :create]

    def index 
        @conversations = Conversation.involving(surrent_user)
    end 
   
    def show
        if Conversation.between(params[:sender_id], params[:recipient_id]).present?
            @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).firts? 
        else 
            @conversation = Conversation.create(conversation_params)
        end 

        render :show, status: :ok 
    end 

    private 

    def conversation_params
        params.permit(:sender, :recipient_id)
    end 
end 