class Api::V1::ProjectsController < ApplicationController
    # before_action :set_project, only: [:index, :create, :update, :edit, :destroy]
    before_action :authenticate_user!

    def index
        @projects = Project.all 
        render json: @projects 
    end

    def show 
        render json: @project.as_json
    end 
    
    def create
        @project = Project.new(project_params)
        
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
        @project.destroy 
    end 

    private  

    def set_project
        @project = Project.find(params[:id]) 
    end 

    def project_params
        params.permit(:name, :desc, :date_begining) 
    end 
end
