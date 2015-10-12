require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Headquarters < ::OmniAuth::Strategies::OAuth2
      include ::OmniAuth::Strategy

      URL      = ENV['HQ_URL'] || 'https://hq.subvisual.co'
      PATH     = '/oauth/authorize'

      option :name, :headquarters
      option :client_options, site: URL, authorize_url: PATH

      uid do
        raw_info['id']
      end

      info do
        {
          email: raw_info['email']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end
    end
  end
end
