class DirectMessagePolicy < ApplicationPolicy
	attr_reader :user, :direct_message 

	def initialize(user, deirect_message)
		@user = user 
		@direct_message = direct_message
	end 

	def index?
		return true if @user
	end 

	def create
		index?  
	end 

	def destroy 
		if @user
			true if @direct_message.empty?
		end 
	end 
end 