require 'spec_helper'

describe Admin::MoviesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "populates an array with movies" do
      movie = FactoryGirl.create(:movie_to_see)
      get :index
      assigns(:movies).should eq([movie])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST :create" do
    before(:each) do
      @request.session[:movie_params] = {}
      @request.session[:step] = 'save_movie'
    end

    context "with valid attributes" do
      it "saves the new movie to the database" do
        expect {
          post :create, movie: FactoryGirl.attributes_for(:movie)
        }.to change(Movie, :count).by(1)
      end

      it "redirects to admin root page" do
        post :create, movie: FactoryGirl.attributes_for(:movie)
        response.should redirect_to admin_root_path
      end
    end
    
    context "with invalid attributes" do
      it "doesn't save the new movie to the database" do
        expect {
          post :create, movie: FactoryGirl.attributes_for(:invalid_movie)
        }.to_not change(Movie, :count)
      end

      it "re-renders the :new template" do
        post :create, movie: FactoryGirl.attributes_for(:invalid_movie)
        response.should render_template :new
      end
    end
  end
end
