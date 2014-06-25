class Friendship < ActiveRecord::Base
  scope :current, -> { where(pending: false) }
  scope :pending, -> { where(pending: true) }
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  delegate :email,
    to: :friend,
    prefix: true
end
