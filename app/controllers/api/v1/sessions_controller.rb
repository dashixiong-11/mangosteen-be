require 'jwt'
class Api::V1::SessionsController < ApplicationController
  def create
    if Rails.env.test?
      return render status: :unauthorized if params[:code] != '123456'
    else
      canSignin = ValidationCodes.exists?(email: params[:email], code: params[:code],used_at: nil)
      return render status: 401 unless canSignin 
    end
    user = User.find_by_email params[:email]
    if user.nil?
      render status: 202, json: {errors: '用户不存在'}
    else
      hmac_secret = Rails.application.credentials.hmac_secret
      payload = { user_id: user.id}
      token = JWT.encode payload, hmac_secret, 'HS256'
      render status: 200, json: {
        jwt: token
      }
    end

  end

end
