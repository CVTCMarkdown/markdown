class TrashedNotesController < ApplicationController
  before_action :set_note, only: [:update, :destroy]
  
  def index
    @notes = Note.where("active=?", false)
  end

  def update
    @note.active = true
    if @note.save
      redirect_to trashed_notes_url(), notice: 'Note was successfully shared.'
    end
  end

  def destroy
    if @note.destroy
      redirect_to trashed_notes_url(), notice: "The note is now gone"
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find_by! id: params[:id], active: false
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note)
    end
end
