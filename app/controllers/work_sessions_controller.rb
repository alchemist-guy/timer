# app/controllers/work_sessions_controller.rb
class WorkSessionsController < ApplicationController
    before_action :authenticate_user!  # Ensure user is logged in
  
    def index
      today = Time.zone.now
  
      # Calculate daily total
      daily_sessions = current_user.work_sessions.where(
        "start_time >= ? AND start_time < ?", today.beginning_of_day, today.end_of_day
      )
      @daily_total_duration = daily_sessions.sum(&:total_duration)
  
      # Calculate weekly total
      weekly_sessions = current_user.work_sessions.where(
        "start_time >= ? AND start_time < ?", today.beginning_of_week, today.end_of_week
      )
      @weekly_total_duration = weekly_sessions.sum(&:total_duration)
  
      # Calculate monthly total
      monthly_sessions = current_user.work_sessions.where(
        "start_time >= ? AND start_time < ?", today.beginning_of_month, today.end_of_month
      )
      @monthly_total_duration = monthly_sessions.sum(&:total_duration)
  
      # Group sessions by date for display
      @grouped_sessions = current_user.work_sessions.group_by { |ws| ws.start_time.to_date }
    end
  
    def punch_in
      # Create a new work session for the current user
      current_user.work_sessions.create!(start_time: Time.current)
      redirect_to work_sessions_path, notice: "Punched in successfully."
    end
  
    def punch_out
      # Find the latest open session for the current user and close it
      open_session = current_user.work_sessions.where(end_time: nil).order(:start_time).last
      if open_session
        open_session.update!(end_time: Time.current)
        redirect_to work_sessions_path, notice: "Punched out successfully."
      else
        redirect_to work_sessions_path, alert: "No open session found to punch out."
      end
    end
  end
  