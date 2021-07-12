class MessagePolicy < ApplicationPolicy
    attr_reader :user, :message

    def create?
        return true if @user.role == "owner"
        return true if @user.role  == "member"
    end 

    def destroy? 
        create?
    end 
end                                                                                                                                                                                                                                                               