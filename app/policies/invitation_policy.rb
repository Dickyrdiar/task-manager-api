class InvitationPolicy <  ApplicationPolicy
    attr_reader :user, :record 

    def initialize(user, record)
        @user = user 
        @record = record
    end 

    def create? 
        return true if @user.is_owner?
    end 

    def update? 
        create? 
    end 

    # def destroy
    #     if @user.is_owner?
    #         return  
    # end 
end 