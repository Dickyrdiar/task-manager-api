class ProjectPolicy <  ApplicationPolicy
    attr_reader :user, :project 

    def initialize(user, project)
        @user = user 
        @project = project
    end 

    def create?
        return true if @user.role == "owner"
    end 

    def update?
        create? 
    end 

    def destroy 
        return true if @user.role == "owner"
    end 
end 