class ProjectMember < ApplicationRecord
    belongs_to :user
    belongs_to :project 

    enum role: [:general, :manager]
end
