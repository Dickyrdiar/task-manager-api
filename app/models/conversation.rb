class Conversation < ApplicationRecord
    # validates :author, uniquenes: {scope: :receiver}

    belongs_to :author, class_name: 'User'
    belongs_to :receiver, class_name: 'User'
    has_many :direct_messages, -> {order(created_at: :asc)}, dependent: :destroy

    scope :participating, -> (user) do
        where(author_id: sender_id, receiver_id: receiver_id).or(where(author_id: receiver_id, receiver_id: sender_id)).limit(1)
    end 

    def with(current_user)
        author == current_user ? receiver : author
    end 

    def participates?(user)
        author == user || receiver == user
    end
end
