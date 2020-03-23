class SchoolRelationship < ApplicationRecord
    belongs_to :student, class_name: "User"
    belongs_to :school, class_name: "School"
    validates :student_id, presence: true
    validates :school_id, presence: true
end
