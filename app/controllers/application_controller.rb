class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  before_action :setup_view_env

  #--------------------------------------------------------------------------------  
  def setup_view_env
    set_current_script_uid
    set_env
  end

  # Set the script name to be run according to current controller/action
  # example :
  # when on Users/index, current_script_uid = "UsersIndex"
  #--------------------------------------------------------------------------------  
  def set_current_script_uid(action = nil)
    gon.current_script_uid = params[:controller].capitalize
    
    gon.current_script_uid += if action
      action.capitalize
    else
      params[:action].capitalize
    end
  end

  #--------------------------------------------------------------------------------  
  def set_env()
    gon.rails_env = Rails.env
  end

  private
  
  #--------------------------------------------------------------------------------  
  def flash_notice(message)
    flash[:notice] = message
  end

  #--------------------------------------------------------------------------------  
  def flash_alert(message)
    flash[:alert] = message
  end

  #--------------------------------------------------------------------------------  
  def flash_notice_now(message)
    flash.now[:notice] = message
  end

  #--------------------------------------------------------------------------------  
  def flash_alert_now(message)
    flash.now[:alert] = message
  end
end
