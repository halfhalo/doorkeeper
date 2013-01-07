require "doorkeeper/version"
require "doorkeeper/engine"
require "doorkeeper/config"
require "doorkeeper/doorkeeper_for"

require 'doorkeeper/errors'
require 'doorkeeper/server'
require 'doorkeeper/request'

require 'doorkeeper/validators/redirect_uri_validator'

module Doorkeeper
  autoload :Validations, "doorkeeper/validations"

  module OAuth
    autoload :Scopes,                     "doorkeeper/oauth/scopes"
    autoload :Error,                      "doorkeeper/oauth/error"
    autoload :CodeResponse,               "doorkeeper/oauth/code_response"
    autoload :TokenResponse,              "doorkeeper/oauth/token_response"
    autoload :ErrorResponse,              "doorkeeper/oauth/error_response"
    autoload :PreAuthorization,           "doorkeeper/oauth/pre_authorization"
    autoload :AuthorizationCodeRequest,   "doorkeeper/oauth/authorization_code_request"
    autoload :RefreshTokenRequest,        "doorkeeper/oauth/refresh_token_request"
    autoload :PasswordAccessTokenRequest, "doorkeeper/oauth/password_access_token_request"
    autoload :ClientCredentialsRequest,   "doorkeeper/oauth/client_credentials_request"
    autoload :Authorization,              "doorkeeper/oauth/authorization"
    autoload :CodeRequest,                "doorkeeper/oauth/code_request"
    autoload :TokenRequest,               "doorkeeper/oauth/token_request"
    autoload :Client,                     "doorkeeper/oauth/client"
    autoload :Token,                      "doorkeeper/oauth/token"

    module Helpers
      autoload :ScopeChecker, "doorkeeper/oauth/helpers/scope_checker"
      autoload :URIChecker,   "doorkeeper/oauth/helpers/uri_checker"
      autoload :UniqueToken,  "doorkeeper/oauth/helpers/unique_token"
    end
  end

  module Models
    autoload :Scopes,            'doorkeeper/models/scopes'
    autoload :Expirable,         'doorkeeper/models/expirable'
    autoload :Revocable,         'doorkeeper/models/revocable'
    autoload :Accessible,        'doorkeeper/models/accessible'
    autoload :Registerable,      'doorkeeper/models/registerable'
    autoload :Authenticatable,   'doorkeeper/models/authenticatable'
    autoload :ClientAssociation, 'doorkeeper/models/client_association'
  end

  module Helpers
    autoload :Filter, "doorkeeper/helpers/filter"
    autoload :Controller, "doorkeeper/helpers/controller"
  end

  module Rails
    autoload :Routes, "doorkeeper/rails/routes"
  end

  def self.configured?
    @config.present?
  end

  def self.database_installed?
    [AccessToken, AccessGrant, Application].all? { |model| model.table_exists? }
  end

  def self.installed?
    configured? && database_installed?
  end

  def self.client
    @client
  end

  def self.client=(model)
    raise "You already have the model #{model} configured as doorkeeper client" if @client.present?
    model.first
    @client = model
  end
end
