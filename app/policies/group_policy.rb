class GroupPolicy < ApplicationPolicy 
    class Scope < Scope 
        scope.with_roles([:user, :invitation], current_user)
    end 

    def show
        user.has_role?([:invitation, :user], record) 
    end 

    def index? 
        true 
    end 

    def create 
        true 
    end 

    def new
        create? 
    end 

    def update?
        user.has_role?(:user, record) 
    end 
end 