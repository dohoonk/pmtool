class Project < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :tasks, dependent: :destroy
  belongs_to :user

  has_many :favourite_projects, dependent: :destroy
  has_many :fav_users, through: :favourite_projects, source: :favourite_projects
end
