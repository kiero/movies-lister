require 'spec_helper'

describe Admin::PagesController do

  describe "GET 'dashboard'" do
    it "returns http success" do
      get 'dashboard'
      response.should be_success
    end

    it "populates an array with movies" do
      movie = FactoryGirl.create(:movie)
      get :dashboard
      assigns(:movies).should eq([movie])
    end

    it "renders the :dashboard view" do
      get :dashboard
      response.should render_template :dashboard
    end
  end

  describe "GET 'add_movie'" do
    it "returns http success" do
      get :add_movie
      response.should be_success
    end

    it "renders the :add_movie view" do
      get :add_movie
      response.should render_template :add_movie
    end
  end
end
