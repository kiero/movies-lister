module Admin::MoviesHelper

  def possible_title(movie)
    "#{movie.name} (#{year(movie.released)})"
  end

  def year(release_date)
    release_date.to_s.split("-").first
  end

  def to_watchlist
    session[:watchlist]
  end
end
