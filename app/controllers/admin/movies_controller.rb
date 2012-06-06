
class Admin::MoviesController < ApplicationController
  #before_filter :set_tmdb_api, :only => :create
  before_filter :authorization
  layout 'admin'

  def index
    @movies = Movie.where("to_see = ?", true)
    @movie_years = @movies.group_by { |m| m.release.year }
  end

  def new
    session[:movie_params] = {}
    @movie = Movie.new
    session[:step] = nil
    if params[:watchlist] == 'true'
      session[:watchlist] = true
    else
      session[:watchlist] = nil
    end
  end

  def create
    session[:movie_params].deep_merge!(params[:movie]) if params[:movie]
    @movie = Movie.new(session[:movie_params])
    @movie.current_step = session[:step]
    if @movie.first_step?
      @results = TmdbMovie.find(:title => "#{title(params[:movie][:title])}", :limit => 6)
    end
    if @movie.second_step?
      assign_params(params[:movie][:tmdb_id])
      session[:movie_params].deep_merge!(params[:movie]) if params[:movie]
    end
    if @movie.last_step?
      @movie.save
    end
    if params[:back_button]
      @movie.previous_step
    else
      @movie.next_step
    end
    if @movie.new_record?
      session[:step] = @movie.current_step
      render :new
    else
      session[:step] = session[:movie_params] = nil
      redirect_to admin_root_path
    end
  end

  private
    def authorization
      unless session[:user]
        flash[:error] = "This action involves logging in."
        redirect_to login_path
      end
    end

    def set_tmdb_api
      Tmdb.api_key = "cc4b67c52acb514bdf4931f7cedfd12b"
      Tmdb.default_language = "en"
    end


    def assign_params(id)
      Tmdb.api_key = "cc4b67c52acb514bdf4931f7cedfd12b"
      Tmdb.default_language = "en"
      m = TmdbMovie.find(:id => id)
      params[:movie][:title] = m.name
      params[:movie][:cast] = cast(m.cast)
      params[:movie][:director] = director(m.cast)
      params[:movie][:duration] = m.runtime
      params[:movie][:genre] = genres_names(m.genres)
      params[:movie][:release] = Date.parse(m.released)
      params[:movie][:to_see] = session[:watchlist] ? true : false
    end

    def director(people)
      people.each do |person|
        return person.name if person.job == 'Director'
      end
      return nil
    end

    def genres_names(genres)
      results = []
      genres.each do |genre|
        if genre.type == 'genre'
          results << genre.name
        end
      end
      return results.join(", ")
    end

    def cast(people)
      results = []
      people.each do |person|
        if person.job == 'Actor'
          results << person.name
        end
      end
      return results[0..10].join(", ")
    end

    def title(string)
      # From weird reason TMDB gem doesn't show
      # proper results if string contains : or -
      string.gsub('-', ' ').gsub(':', ' ')
    end
end
