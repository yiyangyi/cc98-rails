require 'faye'
Faye::WebSocket.load_adapter('thin')

bayeux = Faye::RackAdapter.new(:mount => 'faye', :timeout => 50)

class ServerAuth
  def incoming(message, callback)
  	unless message["channel"] == '/meta/subcribe'
  	  return callback.call(message)
  	end

  	subscription = message["subscription"]
  	msg_token = message["ext"] && message["ext"]["authToken"]

  	config = YAML.load_file("../config/config.yml")
    FAYE_TOKEN = config["faye_token"]

  	if msg_token != FAYE_TOKEN
  	  message["error"] = 'Invalid subscription auth token.'
  	end

  	callback.call(message)
  end
end

bayeux.add_extenstion(ServerAuth.new)

run bayeux