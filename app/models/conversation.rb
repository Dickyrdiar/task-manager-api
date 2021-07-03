class Conversation < ApplicationRecord
    # validates :author, uniquenes: {scope: :receiver}

    belongs_to :author, class_name: 'User', foreign_key: "author_id"
    belongs_to :receiver, class_name: 'User', foreign_key: "receiver_id"
    has_many :direct_messages , dependent: :destroy

    scope :betwen, -> (author_id, receiver_id) do
        where("(conversations.author_id = ? AND conversations.receiver_id = ?) OR (conversations.receiver_id = ? AND conversations.author_id = ? ", author_id, receiver_id, author_id, receiver_id) 
    end 

    def recipient(current_user)
        self.author_id == current_user.id ? self.receiver : self.author
    end 

    def unread_direct_messages_count(current_user)
        self.dirrect_messages.where("user_id != ? AND read = ?", current_user.id, false).count
    end
end
