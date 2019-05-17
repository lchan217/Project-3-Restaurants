class Restaurant < ApplicationRecord
  has_many :locations
  has_many :items
  has_many :users, through: :locations

  validates_presence_of :name, { message: "Name can't be blank"}

  accepts_nested_attributes_for :locations

  def self.search(search)
    if search
      restaurant = Restaurant.find_by(state: search)
      if restaurant
        self.where(state: restaurant.state)
      else
        self.all
      end
    else
      self.all
    end
  end

  def city_and_state
    if self.city == nil || self.city == ""
      self.state
    else
      self.city + ", " + self.state
    end
  end

  def self.options
    self.select(:state).distinct.order(:state)
  end
end
