class Api::V1::ProjectsController < ApplicationController
    # before_action :authenticate_user!, except: [:create, :index, :destroy, :update]
    

    def index
        @projects = Project.all 
        render json: @projects 
    end

   
    def new
        @project = group.projects.build
    end 
    
    def create
        # @project = Project.new(project_params)
        @user = User.find(params[:id])
        @project = Project.new(project_params.merge(group: group))
        
        if @project.save 
            render json: {
                messages: 'project create',
                is_messages: true, 
                data: { project: @project }
            }, status: :ok
        else 
            render json: {
                messages: 'project failed', 
                is_messages: false, 
                data: {}
            }, status: :failed 
        end 
    end 

    def update 
        @project = Project.find(params[:id])

        if @project.update(project_params)
            render json: {
                message: 'project update', 
                is_messages: true, 
                data: { project: @project }
            }, status: :ok
        else 
            render json: {
                messages: 'update failed', 
                is_messages: false, 
                data: {  }
            }, status: :failed 
        end  
    end 

    def destroy
        @project = Project.find(params[:id])
        @project.destroy 

        render json: { messages: 'project destroy success' }
    end 

    def invite
        @project  = Project.find(params[:id])
        invite_user = User.invite!*strong_invite_params, current_user)
        invite_user.update(project: @project.id)
        invited_user.projects << @project 
    end 

    private  

    def set_project
        @project = Project.find(params[:id]) 
    end 

    def project_params
        params.permit(:name, :desc, :date_begining) 
    end 
end
