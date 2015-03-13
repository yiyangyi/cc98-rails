class NotesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destory
  end

  def preview
  end

  private

  def note_params
  	params.require(:note).permit(:title, :body, :publish)
  end
end
