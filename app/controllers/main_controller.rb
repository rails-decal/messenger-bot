class MainController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:receive]
  def index
    render plain: params["hub.challenge".to_sym]
  end

  def receive
    send_message("ok", params[:entry].first[:messaging].first[:sender][:id])
    render json: { ok: true }
  end

  protected
  def send_message(text, conversation_id)
    conn = Faraday.new
    conn.post(
      "https://graph.facebook.com/v2.6/me/messages?access_token=#{Rails.application.credentials.facebook_token}",
      {
        "messaging_type": "RESPONSE",
        "recipient": {
          "id": conversation_id
        },
        "message":{
          "text": text
        }
      }
    )
  end
end
