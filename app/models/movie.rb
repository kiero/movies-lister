class Movie < ActiveRecord::Base
  attr_accessible :cast, :director, :duration, :genre, :rate, :release, :title, :to_see, :tmdb_id
  attr_writer :current_step
  attr_accessor :tmdb_id

  validates_presence_of :title, :genre
  validates :rate, :presence => true, :unless => :to_see
  validates :rate, :inclusion => { :in => 0..10 }, :unless => :to_see

  def current_step
    @current_step || steps.first
  end

  def steps
    %w(add_movie possible_movies save_movie)
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def second_step?
    current_step == "possible_movies"
  end

  def last_step?
    current_step == steps.last
  end

end
