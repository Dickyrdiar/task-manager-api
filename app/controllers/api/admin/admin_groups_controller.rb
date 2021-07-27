class Api::Admin::AdminGroupsController < BaseController
    before_action :admin_request, except: [:index, :show]

    def index
        @groups = Group.all
        # render json: @groups
    end 

    def show 
        @group = Group.find(params[:id])
    end 

    def destroy 
    end 
end 