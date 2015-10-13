class TrashedNotesController < ApplicationController
  before_action :set_note, only: [:update, :destroy]
  
  def index
    @notes = current_user.notes.inactive
  end

  def update
    @note.active = true
    if @note.save
      redirect_to trashed_notes_url(), notice: 'Note was successfully restored.'
    end
  end

  def destroy
    if @note.destroy
      redirect_to trashed_notes_url(), notice: 'Note was successfully destroyed.'
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = current_user.notes.inactive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note)
    end
end
