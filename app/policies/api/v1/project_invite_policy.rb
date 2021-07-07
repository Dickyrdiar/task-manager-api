class ProjectInvitePolicy < ApplicationPolicy
    attr_reader :user, :record 

    def initialize(user, record)
        @user = user 
        @record = record
    end 

    def index
        return true if @user.is_owner? 
    end 

    def show 
        index?
    end 

    def new? 
        create? 
    end 

    def create?
        return true if @user.is_owner? 
    end 
end 