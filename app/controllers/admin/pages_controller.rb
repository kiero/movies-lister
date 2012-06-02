
class Admin::PagesController < ApplicationController
  def dashboard
    @movies = Movie.all
  end
end
