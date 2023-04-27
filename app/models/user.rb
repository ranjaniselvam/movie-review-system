class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movies
  has_many :reviews,dependent:  :destroy
  after_save :send_welcome_email

  private
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
