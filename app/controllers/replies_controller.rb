class RepliesController < ApplicationController
  before_action :find_topic

  def create
    @reply = Reply.new(reply_params)
    @reply.topic_id = @topic.id
    @reply.user_id = current_user.id
    if @reply.save()
      current_user.read_topic(@topic)
      @msg = ""
    else
      @msg = @reply.errors.full_messages.join("<br />")
    end
  end

  def edit
    @reply = Reply.find(params[:id])
  end

  def update
    @reply = Reply.find(params[:id])
    if @reply.update_attributes(reply_params)
      redirect_to topic_path(@reply.topic_id), notice: "Updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    if @reply.destroy
      redirect_to topic_path(@reply.topic_id), notice: "Deleted successfully."
    else
      redirect_to topic_path(@reply.topic_id), alert: "System error, please check out later."
    end
  end

  protected

  def find_topic
  	@topic = Reply.find(params[:id])
  end

  private

  def reply_params
  	params.require(:reply).permit(:body)
  end

end
