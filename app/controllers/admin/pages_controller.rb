
class Admin::PagesController < ApplicationController
  layout 'admin'

  def dashboard
    @movies = Movie.all
  end

  def add_movie
    @movie = Movie.new
  end
end
