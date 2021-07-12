class ProjectInvitePolicy < ApplicationPolicy
    attr_reader :user, :project_invite 

    def create?
        return true if @user.role == "owner"
        return true if @user.role == "member"
    end 

    def show? 
        create? 
    end 

    def destroy? 
        create?
    end
end 