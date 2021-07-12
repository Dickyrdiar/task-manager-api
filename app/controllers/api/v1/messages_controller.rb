class Api::V1::MessagesController < ApplicationController
    before_action :authorize_request, except: [:index, :create]
    before_action :find_project!, except: [:destroy]

    def index
        @project = Project.find(params[:project_id])
        if params[:search].present? 
            @message = Message.search(params[:search])
        else  
            @message = Message.where(:peoject_id => @project.id)
        end 

        # find_project_room_user
    end 
    
    def create
        @message = Message.new(message_params.merge(user: current_user))
        @message.project = Project.find(params[:project_id])
        # @message.project_room_user = ProjectRoomUser.find(params[:project_room_user_id])
        
        if @message.save
            ActionCable.server.broadcast "project_channel", { project_id: @project.id }
            # return render json: @message #dbugging only
            render :show , status: :ok 
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

    def find_project!
        @project = Project.find(params[:project_id])
        authorize @message
    end 

    def message_params 
        params.require(:message).permit(:text, :image,)
    end 
end
