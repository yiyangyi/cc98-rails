class NotesController < ApplicationController
  load_and_authorize_resource

  def index
    @notes = current_user.notes.recent_updated
  end

  def show
    @note = Note.find(params[:id])
    @note.hits.inc(1)
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.new(note_params)
    @note.publish = note_params[:publish] == '1'
    if @note.save()
      redirect_to(notes_path, notice: "New note created successfully!")
    else
      render action: :new
    end
  end

  def edit
    @note = current_user.notes.find_by_id(params[:id])
  end

  def update
    @note = current_user.notes.find_by_id(params[:id])
    if @note.update_attributes(note_params)
      redirect_to(notes_url)
    else
      render action: :edit
    end
  end

  def destory
    @note = current_user.notes.find_by_id(params[:id])
    @note.destroy
    redirect_to(notes_url)
  end

  def preview
    render text: MarkdownConverter.convert(params[:body])
  end

  private

  def note_params
  	params.require(:note).permit(:title, :body, :publish)
  end
end
