class ProjectPolicy < ApplicationPolicy
    def scope
        scope.with_roles([:user, :project_invite], current_user) 
    end 

    def show
        user.has_role?([:project_invite, :user], record) 
    end

    def index? 
        true 
    end 

    def create 
        true 
    end 

    def new 
        create
    end 

    def update? 
        user.has_role?(:user, record)
    end 
end 