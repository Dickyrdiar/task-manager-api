class GroupPolicy < ApplicationPolicy
    class Scope
        attr_reader :user, :group
        
        def initialize(user, group = nil)
            @user = user 
            @group = group 
        end 
    end 
end 