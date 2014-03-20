class Solving < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :user_id
  validates_presence_of :user, :problem
end
