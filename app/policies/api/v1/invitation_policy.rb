class InvitationPolicy <  ApplicationPolicy
    attr_reader :user, :invitation 

    def create?
        return true if @user.role == "owner" 
    end 

    def destroy?
        create?
    end
end 