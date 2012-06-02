require 'spec_helper'

describe MoviesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "populates an array with movies" do
      movie = FactoryGirl.create(:movie)
      get 'index'
      assigns(:movies).should eq([movie])
    end

    it "renders the 'index' view'" do
      get :index
      response.should render_template :index
    end
  end
end
