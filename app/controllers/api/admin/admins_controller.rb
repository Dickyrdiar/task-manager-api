class Api::Admin::AdminsController < BaseController
    before_action :admin_request, except: [:index, :create, :show, :update, :destory]
    # before_action :set_admin, except: [:show, :update, :destroy]

    def index
        @admins = Admin.all 
    end 

    def show
        @admin = Admin.find(params[:id])
    end 

    def create
        @admin = Admin.new(admin_params)

        if @admin.save 
            render :show, status: :ok 
        else  
            render json: @admins.errors, status: :unproccesabel_entity
        end 
    end 

    def update
        if @admin.update(admin_params)
            render :show, status: :ok 
        else  
            render json: @admin.error, status: :unproccesable_entity
        end 
    end 

    def destroy
        @admin.destroy  
        render json: {
            messages: 'admin destroy success'
        } 
    end 

    def set_admin 
        @admin = Admin.find(params[:id])
    end 

    def admin_params
        params.require(:admin).permit(:email, :password, :username)
    end 
end
