# frozen_string_literal: true

class ::Api::Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  respond_to :json

  def github
    @user = User.create_from_github_data(request.env['omniauth.auth'])
    
    if @user.persisted? 
      sign_in_and_redirect
      set_flash_message(:notice, :success, kind: 'Github') if navigational_format
    else 
      flash[:error] = 'there waas a problem signin pleas register'
      render json:  @user.errors, status: :unproccessable_entity
    end 
  end 

  def google_oauth2 
    @user = User.from_omanituh(request.env['omniauth.auth']) 

    if @user.persisted? 
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else  
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      render json:  @user.errors, status: :unproccessable_entity 
    end 
  end 

  def twitter 
  end 
end
