class PhotosController < ApplicationController
  load_and_authorize_resource

  def create
    @photo = Photo.new
    @photo.photo = params[:Filedata]
    @photo.user_id = current_user.id
    @photo.save
    render text: @photo.photo.url
  end
end
