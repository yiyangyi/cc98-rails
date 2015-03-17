class LikesController < ApplicationController
  before_action :require_user
  before_action :find_likeable
  
  def create
    current_user.like(@item)
    render text: @item.reload.likes_count
  end

  def destroy
    current_user.unlike(@item)
    render text: @item.reload.likes_count
  end

  private
  def find_likeable
    @success = false
    @element_id = "likable_#{params[:type]}_#{params[:id]}"
    unless params[:type].in?(%W(Topic Reply))
      render text: '-1'
      false
    end

    case @params[:type].downcase
      when 'topic'
        klass = Topic
      when 'reply'
        klass = Reply
      else
        false
    end

    @item = klass.find_by_id(params[:id])
    if @item.blank?
      render text: '-2'
      false
    end
  end
end
