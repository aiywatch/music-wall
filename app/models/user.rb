class User < ActiveRecord::Base
  has_many :songs
  validates :username, presence: true
  validates :password, presence: true

  def self.authen(params)
    all.where(username: params[:username], password: params[:password])
  end
end