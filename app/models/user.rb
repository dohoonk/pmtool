class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :projects, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments

end
