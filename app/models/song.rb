class Song < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :title, presence: true
  validates :author, presence: true

  def like?(user)
    a = votes.find_all { |vote| vote.user_id == user.id }
    a.size > 0
  end
end