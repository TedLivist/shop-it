class AuthenticationTokenService
  def self.call(user_id)
    exp = 2.weeks.from_now.to_i
    payload = { user_id:, exp: }

    if Rails.env.production?
      JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY_PRODUCTION_ENV', nil))
    else
      JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY_DEVELOPMENT_ENV', nil))
    end
  end

  def self.decode(token)
    if Rails.env.production?
      JWT.decode(token, ENV.fetch('JWT_SECRET_KEY_PRODUCTION_ENV', nil), true, algorithm: 'HS256')
    else
      JWT.decode(token, ENV.fetch('JWT_SECRET_KEY_DEVELOPMENT_ENV', nil), true, algorithm: 'HS256')
    end
  rescue JWT::ExpiredSignature, JWT::DecodeError
    false
  end

  def self.valid_payload(payload)
    !expired(payload)
  end

  def self.expired(payload)
    Time.zone.at(payload['exp']) < Time.now.utc
  end

  def self.expired_token
    render json: { error: 'Expired token! login again' }, status: :unauthorized
  end
end
