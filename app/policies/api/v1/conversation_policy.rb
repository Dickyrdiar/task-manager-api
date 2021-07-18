class ConversationPolicy < ApplicationPolicy
    attr_reader :user, :conversation 

    def create?
        return true if @user 
    end 

    def destroy? 
        create? 
    end 
end 