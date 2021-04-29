class Api::V2::TodolistsController < ApplicationController
  def index
    @todolist = Todolist.all 
    render json: @todolists
  end

  def create
    @todolist = Todolist.creta(todolist_params) 

    if @todolist.save 
      render json: @todolist, status: :created 
    else 
      render json: @todolist.errors, status: :unproccessable_entity 
    end 
  end 
end
