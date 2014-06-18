class UserStats < ActiveRecord::Base
  belongs_to :user

  scope :today, ->(day = Date.today) {
    where('created_at > ? AND created_at < ?', 
      day.beginning_of_day, day.end_of_day).first_or_create
  }

end
