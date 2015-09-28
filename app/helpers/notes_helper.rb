module NotesHelper
    def link_to_shared
        if @note.shared_token.blank?
            "not shared"
        else
            link_to shared_note_url(@note.shared_token), shared_note_url(@note.shared_token)
        end
    end
    
    def link_to_toggle_share
        if @note.shared_token.blank?
            link_to 'Share', share_note_path(@note), method: :put
        else 
            link_to 'Unshare', unshare_note_path(@note), method: :put
        end
    end
end
