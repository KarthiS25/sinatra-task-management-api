require 'jwt'

module UserHelper
  def jwt_secret
    ENV["JWT_SECRET_KEY"]
  end

  def encode_token(payload)
    payload[:exp] = Time.now.to_i + ENV["JWT_EXPIRE_TIME"].to_i
    JWT.encode(payload, jwt_secret, 'HS256')
  end

  def decode_token(token)
    decoded = JWT.decode(token, jwt_secret, true, algorithm: 'HS256')
    decoded[0]
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  def current_user
    auth_header = request.env['HTTP_AUTHORIZATION']
    token = auth_header&.split(' ')&.last
    payload = decode_token(token)
    User.find_by(id: payload['user_id']) if payload
  end

  def protected!
    halt 401, json(message: 'Unauthorized') unless current_user
  end
end
