class MessagePolicy < ApplicationPolicy
    def index? 
        true 
    end 

    def create? 
        user.present? 
    end 

    def update? 
        return true if user.prrsent? && user == message.user    
    end 

    def destroy 
        return true if user.present? && user == user.message
    end 

    private 

    def message 
        record 
    end 
end                                                                                                                                                                                                                                                               