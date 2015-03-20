requrie 'net/http'
require 'uri'
class FayeClient
  def self.send(channel, params)
  	Thread.new do 
  	  message = {channel: channel, data: params, ext: {auth_tokem: Setting.faye_tokem}}
  	  uri = URI.parse(Setting.faye_server)
  	  NET::HTTP.post_form(uri, message.to_json)
  	end
  end
end