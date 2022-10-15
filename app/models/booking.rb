class Booking < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :date_cannot_be_in_the_past, :end_date_cannot_be_lower_than_start_date
  belongs_to :user
  belongs_to :service

  def date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def end_date_cannot_be_lower_than_start_date
    return if start_date.blank? || end_date.blank?

    if start_date > end_date
      errors.add(:end_date, "can't be lower than start date")
    end
  end
end
