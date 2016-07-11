class Song < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true
  validates :author, presence: true

  def self.all_with_user

  end
end