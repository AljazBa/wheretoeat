class Restaurant < ActiveRecord::Base
  has_many :menus
  has_many :votes

  def grouped_menus
    menus_array = []
    for date in Date.today..4.days.from_now
      menus_array << {date: date, menus: menus.where('date=? OR regular=true', date).order(:regular)}
    end
    menus_array
  end

  def todays_menus
    @todays_menus ||= menus.where('date=? OR regular=true', Date.today).order(:regular)
  end

  def today_votes_number(user)
    @no_of_votes ||= votes.where(date: Date.today, group: user.group).count
  end

  def voters(user)
    @voters ||= votes.where(date: Date.today, group: user.group).map do |vote|
      vote.user
    end
  end
end
