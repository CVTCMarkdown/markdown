class SharedNoteController < ApplicationController
  def show
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end
end
