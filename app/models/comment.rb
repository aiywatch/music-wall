class Comment < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  validates :user_id, presence: true
  validates :song_id, presence: true
  validates :comment, presence: true
  validates :star, presence: true


end