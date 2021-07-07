class GroupPolicy < ApplicationPolicy
    attr_reader :user, :record 

    def initialize(user, record)
        @user = user 
        @record = record
    end 

    def index
        return true if @user.is_owner?
        return true if @user.is_members? 
    end 

    def show?  
        index? 
    end 

    def create? 
        index?
    end
    
    def new? 
        create? 
    end 

    def update? 
        create? 
    end 

    def edit? 
        create?   
    end 

    def destroy? 
        if @user.is_owner? 
            true if @record.group_empty? 
        end 
    end 
end 