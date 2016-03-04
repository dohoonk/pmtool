class Discussion < ActiveRecord::Base
  validates :title, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user
end
