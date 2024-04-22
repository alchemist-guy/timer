# db/seeds.rb
require 'date'

# Find or create a user to associate with the work sessions
user = User.find_or_create_by!(email: 'noshad@gmail.com') do |u|
  u.password = 'password123'  # Set a default password for the user
  u.password_confirmation = 'password123'
end

# Clear existing work sessions for a clean slate
user.work_sessions.destroy_all

# Define the start of the week
start_of_week = Date.today.beginning_of_week(:monday)  # Adjust to your desired start of the week

# Create work sessions for each day of the week
(0..6).each do |i|
  # Calculate the start and end time for a typical workday (9:00 AM to 5:00 PM)
  workday_start = (start_of_week + i).to_time.change(hour: 9, min: 0, sec: 0)
  workday_end = (start_of_week + i).to_time.change(hour: 17, min: 0, sec: 0)

  # Create a new work session for this day
  user.work_sessions.create!(
    start_time: workday_start,
    end_time: workday_end
  )
end

puts "Seeded work sessions for #{user.email} for the week starting from #{start_of_week}"
