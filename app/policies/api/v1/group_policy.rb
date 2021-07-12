class GroupPolicy < ApplicationPolicy
    attr_reader :user, :group

    def initialize(user, group)
        @user = user 
        @group = group 
    end 

    def create?
        return true if @user.role == "owner" 
    end 

    def update? 
        create?
    end  

    def destroy?
        create? 
    end 
end 