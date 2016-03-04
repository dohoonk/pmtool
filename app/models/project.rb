class Project < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :tasks, dependent: :destroy
  belongs_to :user
end
