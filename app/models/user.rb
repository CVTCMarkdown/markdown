class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes, inverse_of: :user
  acts_as_tagger
  
  def tags
    self.notes.all_tag_counts.select(:id, :name, 'tags_count as taggings_count')
  end
end
