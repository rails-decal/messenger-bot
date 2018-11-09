class MainController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:receive]
  REPLACE_THIS = "ignore" # ignore this line :)

  def index
    render plain: params["hub.challenge".to_sym]
  end

  # This method gets called when a message arrives to your Facebook page.
  def receive
    #
    # Call send_message here with two parameters:
    #
    # 1) The text of the response
    # 2) The sender ID from the params of this request. Check out your
    #    ngrok dashboard to see how to grab this ID, and if you're having
    #    trouble, check out the lab guide.
    send_message(
      # Fill in the two parameters described above here!
    )

    # We send back an arbitrary successful response to Facebook
    render json: { ok: true }
  end

  protected
  def send_message(text, conversation_id)
    conn = Faraday.new
    conn.post(
      # Replace the API URL. Make sure you use your access token in this URL!
      # It is available to you as Rails.application.credentials.facebook_token.
      "the API URL here", 
      {
        "messaging_type": "RESPONSE",
        "recipient": {
          # Your code here - it should come from the arguments to this function
          "id": REPLACE_THIS
        },
        "message": {
          # Your code here - it should also come from the arguments to this function
          "text": REPLACE_THIS
        }
      }
    )
  end
end
