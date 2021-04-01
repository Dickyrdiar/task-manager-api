class Api::V1::SearchController < ApplicationController
    def projectSearch
        results = Project.search(search_params[:q], search_params)
        
        projects = results.map do |r|
            r.merge(r.delete('__source')).merge('id': r.delete('_id')) 
        end 
        render json: { projects: projects }, status: :ok
    end 

    private  

    def search_params
        params.permit(:q, :message, :username)
    end 
end
