# require 'json_web_token'

class ApplicationController < ActionController::API
    before_action :authorized 

    def encode_token(payload)
        JWT.encode(payload, 'yourSecret')
    end 

    def auth_header 
        request.header['Authorization']
    end 
end
