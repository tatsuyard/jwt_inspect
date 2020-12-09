require 'securerandom'
require 'jwt'
require 'dotenv'

Dotenv.load('../.env')

ZENDESK_SHARED_SECRET = ENV['ZENDESK_SHARED_SECRET']
ZENDESK_SUBDOMAIN     = ENV['ZENDESK_SUBDOMAIN']

def sign_into_zendesk
  iat = Time.now.to_i
  jti = "#{iat}/#{SecureRandom.hex(18)}"

  payload = JWT.encode({
    :iat   => iat,
    :jti   => jti,
    :name  => 'name',
    :email => 'email',
    :organization => 'organization',
  }, ZENDESK_SHARED_SECRET)

  puts zendesk_sso_url(payload)
end

def zendesk_sso_url(payload)
  url = "https://#{ZENDESK_SUBDOMAIN}.zendesk.com/access/jwt?jwt=#{payload}"
  url
end

sign_into_zendesk
