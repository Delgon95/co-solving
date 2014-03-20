class Problem < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :start_time
  validates_presence_of :end_time
  has_many :solvings

  def user_status user_id
    query = Solving.where(user_id: user_id, problem_id: id)
    if query.empty?
      "untouched"
    else
      query.first.status
    end
  end
end
