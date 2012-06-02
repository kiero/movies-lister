
class Admin::MoviesController < ApplicationController
  layout 'admin'

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    @movie.current_step = session[:step]
    if params[:back_button]
      @movie.previous_step
    else
      @movie.next_step
    end
    session[:step] = @movie.current_step
    render :new
  end
end
