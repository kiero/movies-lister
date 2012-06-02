class Movie < ActiveRecord::Base
  attr_accessible :cast, :director, :duration, :genre, :rate, :release, :title
end
