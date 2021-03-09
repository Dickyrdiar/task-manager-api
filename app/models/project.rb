class Project < ApplicationRecord
    # uuid 
    before_create :set_uuid 
    def set_uuid 
        self.id = SecureRandom.uuid 
    end

    # validates 
    validates_presence_of :name, :desc, :date_begining

    # database relation 
    has_many :messages, dependent: :destroy  
    # has_and_belongs_to_many :users
end
