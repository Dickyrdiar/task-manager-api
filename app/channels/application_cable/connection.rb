module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    
    def connect
      self.current_user = find_verified_user  
    end 

    protected 

    def find_verified_user
      auth_header = JSON.parse(cookies['auth_headers'])

      uid_name = JWT.headers_names[:'uid']
      access_token_name = JWT.headers_names[:'access-token']
      client_name = JWT.headers[:'client']

      uid = auth_headers[uid_name]
      token = auth_headers[access_token_name]
      client_id = auth_headers[client_name]

      @user = User.find_by_uid(uid)

      if @user && @user.valid_token?(token, client_id)
        @user 
      else 
        reject_unauthoriezed_connection
      end
    end 
  end
end
