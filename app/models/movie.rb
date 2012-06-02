class Movie < ActiveRecord::Base
  attr_accessible :cast, :director, :duration, :genre, :rate, :release, :title
  attr_writer :current_step

  validates_presence_of :title, :release, :genre, :rate
  validates :rate, :inclusion => { :in => 0..10 }

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

  def last_step?
    current_step == steps.last
  end

end
