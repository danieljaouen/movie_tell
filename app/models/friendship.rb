class Friendship < ActiveRecord::Base
  scope :current, -> { where(pending: false) }
  scope :pending, -> { where(pending: true) }
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  before_create :send_email

  delegate :email,
    to: :friend,
    prefix: true

  private

  def send_email
    if self.pending
      NotificationMailer.new_friend_request(self.user).deliver
    end
  end
end
