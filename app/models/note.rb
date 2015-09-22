class Note < ActiveRecord::Base
    validates :title, :presence => true
    validates :markdown, :presence => true
end
