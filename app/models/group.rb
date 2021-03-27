class Group < ApplicationRecord
    # uuid 
    before_create :set_uuid
    def set_uuid
        self.id  = SecureRandom.uuid  
    end 

    # validates 
    # validates_presence_of :name, :desc

    # database relation 
    has_many :projects
    belongs_to :user, optional: true
    
    # image model connection 
    # has_one_attached :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    # attachment :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
