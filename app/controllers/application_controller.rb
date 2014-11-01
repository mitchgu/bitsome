require "oauth2"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :prepare_oauth_client

  COINBASE_CLIENT_ID = '7abefe9ae0829021549ad7f51e7e8c18aaafa55852ff09c4d258dbf0454a106e'
  COINBASE_CLIENT_SECRET = 'a7a9396ba91e85e9b1bead017e36881a31bf0581fb4f72c808aa07729b114671'
  COINBASE_CALLBACK_URI = 'https://localhost:3000/dashboard/oauth'

  def check_for_linked_coinbase
  	redirect_to dashboard_link_coinbase_path if current_user.coinbase_email.nil?
  end

  def prepare_oauth_client
    @oauth_client = OAuth2::Client.new(COINBASE_CLIENT_ID, COINBASE_CLIENT_SECRET, site: 'https://coinbase.com')
  end

  def current_coinbase_client
    if current_user.oauth_credentials
      @current_coinbase_client ||= Coinbase::OAuthClient.new(COINBASE_CLIENT_ID, COINBASE_CLIENT_SECRET, current_user.oauth_credentials.symbolize_keys)
    else
      nil
    end
  end

end
