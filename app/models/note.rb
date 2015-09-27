class Note < ActiveRecord::Base
    validates :title, :presence => true, :length => { :maximum => 250 }
    validates :markdown, :presence => true
    acts_as_taggable 
end