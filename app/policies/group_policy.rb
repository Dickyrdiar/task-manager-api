class GroupsPolicy <  ApplicationPolicy
    class Scope < Scope
        def resolve 
            scope.with_roles([:owner, :member])
        end  
    end 
end 