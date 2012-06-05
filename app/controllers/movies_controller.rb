
class MoviesController < ApplicationController
  def index
    @movies = Movie.where("to_see = ?", 'f')
  end
end
