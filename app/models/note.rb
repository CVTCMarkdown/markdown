class Note < ActiveRecord::Base
    validates :title, :length => { :maximum => 250 }
end
