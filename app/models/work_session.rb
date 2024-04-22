# app/models/work_session.rb
class WorkSession < ApplicationRecord
    belongs_to :user
  
    # Validation for presence of start and end times
    validates :start_time, presence: true
    validates :end_time, presence: true, if: :punched_out?
  
    # Calculate the total duration in minutes
    def total_duration
      return 0 unless end_time
      ((end_time - start_time) / 60).round
    end
  
    # Check if the session has ended
    def punched_out?
      !end_time.nil?
    end
  end
  