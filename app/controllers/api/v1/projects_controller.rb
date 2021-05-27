class Api::V1::ProjectsController < ApplicationController
   
    def index
        @group = Group.find(params[:group_id])
        @projects = Project.where(:group_id => @group.id).
        search(params[:query])
    end

    def show 
        @project = Project.find(params[:id])
    end
   
    def new
        @project = Project.new
    end 
    
    def create
        @group = Group.find(params[:group_id])
        @project = @group.projects.create(project_params.merge(user: current_user))
        # @project.user_id = current_user.id

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

    private  

    def search
        results = Project.search(search_params[:q], search_params)
    end 

    def set_project
        @project = Project.find(params[:id]) 
    end 

    def project_params
        params.permit(:name, :desc, :date_begining, :user_id, :group_id) 
    end 
end
