class NotificationController < ApplicationController
  
  def create
    Notification.new
  end

end