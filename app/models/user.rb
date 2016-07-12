require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :songs
  has_many :votes
  has_many :comments
  
  validates :username, presence: true, uniqueness: true
  validates :password_hash, presence: true

  def self.authen(params)
    user = find_by(username: params[:username])
    if user && user.password == params[:password]
      user
    end

    # where(username: params[:username], password_hash: Password.create(params[:password]))
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end