class GroupsPolicy <  ApplicationPolicy
    class Scope < Scope
        def resolve 
            scope.with_roles([:owner, :group_member], current_user)
        end  
    end 

    def show? 
        user.has_role?([:group_member, :owner], record) 
    end

    def index? 
        true 
    end 

    def create? 
        true  
    end 

    def new? 
        create? 
    end 

    def update? 
        user.has_role?(:owner, record)
    end 

    def edit? 
        update? 
    end 

    def destroy? 
        update? 
    end 
end 