class Notification < ApplicationCable::Channel
  def subscribed
    stream_from "notifications:#{current_user}"
  end

  def unsubscribed
    stop_all_stream
  end
end
