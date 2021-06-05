class GroupPolicy < ApplicationPolicy
    def initialize(user, record)
        @user = user
        record = record
    end 

    
end 