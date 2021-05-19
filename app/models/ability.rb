# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user ||= User.new

    can :join, Group do |group| 
      !group.members.include?(user)
    end
  end
end
