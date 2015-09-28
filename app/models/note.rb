class Note < ActiveRecord::Base
    validates :title, :presence => true, :length => { :maximum => 250 }
    validates :markdown, :presence => true
    acts_as_taggable
    
    def share
       self.shared_token = SecureRandom.base64(10) 
    end
    
    def unshare
       self.shared_token = nil
    end
    
end