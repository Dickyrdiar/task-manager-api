class Api::V1::TodolistsController < ApplicationController
  before_action :authorize_request, except: [:index, :create]
  before_action :set_todolist,  except: [:show, :update, :destroy]

  def index
    @project = Project.find(params[:project_id])
    @todolist = Todolist.where(project_id: @project.id)
  end

  def create
    @project = Project.find(params[:project_id])
    @todolist = @project.todolists.create(todolist_params.merge(user: current_user)) 

    if @todolist.save 
      render :show, status: :created 
    else 
      render json: @todolist.errors, status: :unproccessable_entity 
    end 
  end 

  def update
    @todolist = Todolist.find(params[:todolists_id])

    if @todolist.update 
      render json: @todolist, status: :updated 
    else 
      render json: { message: 'todolist failed' }, status: :unproccessable_entity
    end 
  end 

  def destroy
    @todolist.find(params[:todolists_id])
    @todolist.destroy  
    
    reder json: { messages: 'todolist success destroy' }
  end 

  private  
  def set_todolist
    @todolist = Todolist.find(params[:id]) 
    authorize @todolist
  end 

  def todolist_params
    params.permit(:title, :done)
  end 
end
