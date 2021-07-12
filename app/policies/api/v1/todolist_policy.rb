class TodolistPolicy < ApplicationPolicy
    attr_reader :user, :todolist 

    def index
        return true if @user.role == "owner"
        return true if @user.role == "member" 
    end 

    def create?
        return true if @user.role == "owner"
        return true if @user.role == "member" 
    end 

    def update
        create?
    end 

    def destroy? 
        create?
    end 
end 