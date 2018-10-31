require "./fcm/*"
require "json"
require "http/client"

module Fcm
  class Base
    getter base_uri = "https://fcm.googleapis.com/fcm/"
    getter timeout = 30
    getter format = :json

    def initialize(@api_key : String)
    end

    def send(registration_id, options : Hash(String, String))
      message = { "to" => registration_id }.merge(options)
      response = HTTP::Client.post(
        @base_uri + "send",
        headers: HTTP::Headers {"Authorization" => "key=#{@api_key}", "Content-Type" => "application/json" },
        body: message.to_json
      )
    end

  end
end
