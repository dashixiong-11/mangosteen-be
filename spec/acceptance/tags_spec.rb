
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "标签" do
  authentication :basic, :auth
  let(:current_user) { User.create email: '1@qq.com' }
  let(:auth) { "Bearer #{current_user.generate_jwt}" }
  get "/api/v1/tags" do
    parameter :page, '页码'
    with_options :scope => :resources do
      response_field :id, 'ID'
      response_field :name, "名称"
      response_field :sign, "符号"
      response_field :user_id, "用户ID"
      response_field :deleted_at, "删除时间"
    end
    example "获取标签列表" do
      11.times do Tag.create name: 'x', sign:'x', user_id: current_user.id end
      do_request
      expect(status).to eq 200
      json = JSON.parse response_body
      expect(json['resources'].size).to eq 10
    end
  end
end