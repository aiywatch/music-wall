class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :song_id, presence: true
  validates :user_id, presence: true
end