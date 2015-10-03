class Note < ActiveRecord::Base
    validates :title, :presence => true, :length => { :maximum => 250 }
    validates :markdown, :presence => true
    acts_as_taggable
    scope :with_text, -> (text) {where("markdown like ?", "%#{text}%")}
    scope :active, -> {where("active=?",true)}
    
    def share
       self.shared_token = SecureRandom.hex(10) 
    end
    
    def unshare
       self.shared_token = nil
    end
    
end