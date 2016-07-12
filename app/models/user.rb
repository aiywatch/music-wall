require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :songs
  has_many :votes
  has_many :comments
  
  validates :username, presence: true
  validates :password, presence: true

  def self.authen(params)
    where(username: params[:username], password: params[:password])
  end

  # def password
  #   @password ||= Password.new(password_hash)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end
end