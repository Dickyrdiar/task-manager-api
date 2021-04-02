class Api::V1::SearchController < ApplicationController
    def search
        @project = Project.search_by_term(params[:query])
        render json: @project
    end 
end
