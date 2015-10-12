class SharedNoteController < ApplicationController
  before_action :set_note, only: [:show]
  def show
    render :layout => false
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find_by_shared_token(params[:shared_token])
    end
    
     # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:shared_token)
    end
    
end
