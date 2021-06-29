class Conversation < ApplicationRecord
    has_many :direct_messages, dependent: :destroy
    belongs_to :sender, foreign_key: :sender_id, class_name: 'User' 
    belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

    scope :betwen, -> (sender_id, recipient_id) do
        where(sender_id: sender_id, recipient_id: recipient_id).or(
            where(sender_id: recipient_id, recipient_id: sender_id)
        ) 
    end 

    def self.get(sender_id, recipient_id)
        conversation = betwen(sender_id, recipient_id).first
        return conversation if conversation.present? 

        create(sender_id: sender_id, recipient_id: recipient_id)
    end 

    def opposed_user(user)
        user == recipient ? sender  : recipeient
    end 
end
