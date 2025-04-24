require 'sinatra/base'
require 'sinatra/contrib'

class UsersController < Sinatra::Base
  helpers UserHelper
  register Sinatra::ActiveRecordExtension
  helpers Sinatra::JSON

  post '/sign-up' do
    request_payload = JSON.parse(request.body.read)
    email = request_payload['email']
    password = request_payload['password']

    user = User.create(email: email, password: password)
    token = encode_token(user_id: user.id)
    json(id: user.id, token: token)
  end

  post '/login' do
    request_payload = JSON.parse(request.body.read)
    email = request_payload['email']
    password = request_payload['password']

    user = User.find_by(email: email)
    if user&.authenticate(password)
      token = encode_token(user_id: user.id)
      json(id: user.id, token: token)
    else
      halt 401, json(message: 'Invalid credentials')
    end
  end

  delete '/logout' do
  end
end
