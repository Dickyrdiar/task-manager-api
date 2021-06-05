class Ability
  include CanCan::Ability

  def initialize(user)
    @user ||= User.new 
  
    if user.role? :owner 
      can :manage, :all 
    elsif user.role? :members
      can :manage, :all    
    elsif @project_invite.role? :members 
      can :manage, :messages  
      cannot :group, :user
    elsif @invitaion.role? :members 
      can :manager, :invitation 
      cannot :user, :invitaiton 
    end 
  end 
end
