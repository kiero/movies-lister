class Movie < ActiveRecord::Base
  attr_accessible :cast, :director, :duration, :genre, :rate, :release, :title

  validates_presence_of :title, :release, :genre, :rate
  validates :rate, :inclusion => { :in => 0..10 }
end
