class Api::V1::TagsController < ApplicationController
  def index 
    current_user = User.find request.env['current_user_id']
    return render status: 401 if current_user.nil?  
    tags = Tag.where(user_id: current_user.id).page(params[:page])
    render json: {resources: tags, pager: {
      page: params[:page] || 1,
      per_page: Tag.default_per_page,
      count: Tag.count
    }}
  end
  def show
    tag = Tag.find params[:id]
    return head :forbidden unless tag.user_id == request.env['current_user_id']
    render json: {resource: tag}
  end
end
