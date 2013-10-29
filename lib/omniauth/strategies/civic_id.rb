require "omniauth/civic_id/version"
require "omniauth"
require "oauth2"

module OmniAuth
  module Strategies
    class CivicID
      include OmniAuth::Strategy

      option :name, 'civicid'

      option :client_options, {
        :site           => 'https://apis.accela.com/',
        :user_url       => 'https://apis.accela.com/v3/users/me',
        :authorize_url  => 'https://auth.accela.com/oauth2/authorize',
        :token_url      => 'https://apis.accela.com/oauth2/token'
      }

      option :authorize_options, [:scope]
      option :token_params, {}
      option :token_options, []
      option :provider_ignores_state, false

      attr_accessor :access_token

      def callback_url
        full_host + script_name + callback_path
      end

      def client
        ::OAuth2::Client.new(options.app_id, options.app_secret, deep_symbolize(options.client_options))
      end

      uid do
        raw_info['id']
      end

      info do
        { 
          'name'     => raw_info['loginName'],
          'email'    => raw_info['email'],
          'raw_info' => raw_info
        }
      end

      credentials do 
        {
          'token'         => access_token.token,
          'refresh_token' => access_token.refresh_token,
          'expires_in'    => access_token.expires_at,
          'expires_at'    => access_token.expires_in
        }
      end

      def request_phase
        redirect client.auth_code.authorize_url({:redirect_uri => callback_url}.merge(authorize_params))
      end

      def callback_phase
        self.access_token = build_access_token
        self.access_token = access_token.refresh! if access_token.expired?
        super
      end

      def raw_info
        @raw_info ||= access_token.get(options.client_options.user_url, {:headers => auth_token_params}).parsed
      end


      protected

      def deep_symbolize(hash)
        hash.inject({}) do |h, (k,v)|
          h[k.to_sym] = v.is_a?(Hash) ? deep_symbolize(v) : v
          h
        end
      end

      def build_access_token
        verifier = request.params['code']
        client.auth_code.get_token(verifier, {:redirect_uri => callback_url, :headers => auth_token_params}, {:header_format => '%s'})
      end

      def authorize_params
        {
          :environment => options.environment,
          :scope       => options.scope
        }
      end

      def auth_token_params
        { "x-accela-appid" => options.app_id }
      end

    end
  end
end
