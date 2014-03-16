class Problem < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :start_time
  validates_presence_of :end_time
end
