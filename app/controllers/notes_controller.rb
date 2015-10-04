class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy, :share, :unshare]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.where("active=?", true)
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end
  
  # PUT /note/1/share
  def share
    @note.share
    if @note.save
      redirect_to edit_note_url(@note), notice: 'Note was successfully shared.'
    end
  end
  
  # PUT /note/1/unshare
  def unshare
    @note.unshare
    if @note.save
      redirect_to edit_note_url(@note), notice: 'Note was successfully unshared.'
    end
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.active = true

    respond_to do |format|
      if @note.save
        flash[:notice] = 'Note was successfully created.'
        format.html { render :edit }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        flash[:notice] = 'Note was successfully updated.'
        format.html { render :edit }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.active = false
    respond_to do |format|
      if @note.save
        format.html { redirect_to trashed_notes_url, notice: 'Note was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find_by! id: params[:id], active: true
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :markdown, :tag_list)
    end
end
