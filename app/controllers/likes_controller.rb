class LikesController < ApplicationController
  before_action :require_user
  before_action :find_likeable
  
  def create
  end

  def destroy
  end

  private
  def find_likeable
  end
end
