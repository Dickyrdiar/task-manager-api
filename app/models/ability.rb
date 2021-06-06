class Ability
  include CanCan::Ability

  def initialize(user)
    @user ||= User.new 
  
    if user.has_role? :owner 
      can :invite, Invitation
      can :manage, Group, user_id: user.id
      can :invite, ProjectInvite
      can :manage, Projetc, user_id: user.id  
    elsif has_role? :members 
      can :manager, Message, user_id: user.id 
    elsif 
      can :manage, Project
      can :manage, Group
    end 
  end 
end
