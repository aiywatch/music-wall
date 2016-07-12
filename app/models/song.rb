class Song < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_many :comments

  validates :title, presence: true
  validates :author, presence: true

  def like?(user)
    voter = votes.find_all { |vote| vote.user_id == user.id }
    voter.size > 0

    # !votes.where(user_id: user.id).empty?
  end

  def vote_count
    votes.size
  end

end