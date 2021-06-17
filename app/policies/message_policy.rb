class MessagePolicy < ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
        @user = user 
        @record = record
    end 

    def index?
        return true if @user.is_owner? 
        return true if @user.is_members? 
    end 

    def show? 
        true
    end 

    def create
        index?
    end 

    def new? 
       create? 
    end 

    def update? 
        show? 
    end 

    def edit? 
        show? 
    end 

    def destroy? 
       show?
    end 
end                                                                                                                                                                                                                                                               