class Api::V1::ProjectsController < ApplicationController
    before_action :authorize_request, except: [:index, :show, :create, :update]
    before_action :set_project, except: [:show, :update, :destroy]

    def index
        @group = Group.find(params[:group_id])
        
        if params[:search].present? 
            @projects = Project.search(params[:search])
        else  
            @projects = Project.where(:group_id => @group.id)
        end 
        # require_params
    end

    def show 
        @project = Project.find(params[:id])
    end
   
    
    def create
        @group = Group.find(params[:group_id])
        @project = @group.projects.create(project_params.merge(user: current_user))

        if @project.valid? 
           render :show, status: :created
        else 
            render json: @group.errors, status: :unproccessable_entity
        end 
    end 

    def update 
        @project = Project.find(params[:id])

        if @project.update(project_params)
            render :show, status: :ok
        else 
            render json: @group.errors, status: :unproccessable_entity
        end  
    end 

    def destroy
        @project = Project.find(params[:id])
        @project.destroy 

        render json: { messages: 'project destroy success' }
    end 

    private  

    def require_params
        raise Pundit::NotAuthorizedError if params[:project_id].blank?
        
        @project = Project.find_by slug: params[:project_id]
        raise Pundit::NotAuthorizedError unless @project
    end 

    def set_project
        @project = Project.find(params[:id]) 
        authorize @project
    end 

    def project_params
        params.permit(:name, :desc, :date_begining, :user_id, :group_id) 
    end 
end
