class Course < ActiveRecord::Base
  has_many :enrollments,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: "Enrollment"

  has_many :enrolled_students,
    through: :enrollments,
    source: :student

  belongs_to :prereq,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: :Course

  has_one :instructor,
    primary_key: :instructor_id,
    foreign_key: :id,
    class_name: :User

end
