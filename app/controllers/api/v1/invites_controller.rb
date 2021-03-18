class Api::V1::InvitesController < ApplicationController
    def create
       @project = Project.find(params[:project_id])
       
    end 
end
