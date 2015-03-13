class RepliesController < ApplicationController
  
  def create
  end

  def edit
  end

  def update
  end

  def destroy
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
