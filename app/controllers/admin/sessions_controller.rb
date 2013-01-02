class Admin::SessionsController < ApplicationController
  layout 'login'

  def show
    if using_open_id?
      create
    else
      redirect_to :action => 'new'
    end
  end

  def new
  end

  def create
    return successful_login if allow_login_bypass? && params[:bypass_login]

	google_openid = enki_config.author_open_ids.first
    authenticate_with_open_id(google_openid) do |result, identity_url|
      if result.successful?
        if enki_config.author_open_ids.include?(URI.parse(identity_url))
          return successful_login
        else
          flash.now[:error] = "You are not authorized"
        end
      else
        flash.now[:error] = result.message
      end
      render :action => 'new'
    end
  end

  def destroy
    session[:logged_in] = false
    redirect_to('/')
  end

protected

  def successful_login
    session[:logged_in] = true
    redirect_to(admin_root_path)
  end

  def allow_login_bypass?
    %w(development test).include?(Rails.env)
  end
  helper_method :allow_login_bypass?
end
