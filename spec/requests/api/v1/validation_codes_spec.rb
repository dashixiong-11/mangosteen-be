require 'rails_helper'

RSpec.describe "ValidationCodes", type: :request do
  describe "验证码" do
    it "可以被发送" do
      post '/api/v1/validation_codes', params: {email: '2788347834@qq.com'}
      expect(response).to have_http_status(200)
      post '/api/v1/validation_codes', params: {email: '2788347834@qq.com'}
      expect(response).to have_http_status(429)
    end
    it "邮件格式不合法返回422" do
      post '/api/v1/validation_codes', params: {email: '2788347834'}
      expect(response).to have_http_status(422)
      json = JSON.parse response.body
      expect(json['errors']['email'][0]).to eq('is invalid')
    end
  end
end
