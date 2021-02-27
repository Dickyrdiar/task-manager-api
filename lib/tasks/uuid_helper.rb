module UuidHelper
    def self.included(base)
        base.primary_key = 'id'
        base.before_create :assign_id
    end  

    private  
    def assign_id 
        self.uuid = UUIDTools::UUID.timestamps_create().to_s.upcase if id_changed?
    end 
end 