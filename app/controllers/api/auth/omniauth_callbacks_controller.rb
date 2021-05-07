# frozen_string_literal: true

class ::Api::Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  respond_to :json

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
  
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: "GitHub") if is_navigational_format? 
    else  
      session["devise.github_data"] = request.env["omaniauth.auth"]
      render json: @user 
    end 
  end 

  def google_oauth2 
    @user = User.from_omanituh(request.env['omniauth.auth']) 

    if @user.persisted? 
      flash[:notice] = I18n.t 'devise omniauth callbacks success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else  
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      render json: @user 
    end 
  end 

  def failure 
  end 
end
